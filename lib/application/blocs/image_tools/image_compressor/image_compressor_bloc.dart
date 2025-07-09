import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';
import 'package:toolest/application/blocs/home/home_page_bloc.dart';
import 'package:toolest/core/constants/text_strings.dart';
import 'package:toolest/core/utils/file_core_helper/file_core_helper.dart';
import 'package:toolest/core/utils/file_services/pdf_service.dart';
import 'package:toolest/domain/models/home/recent_file_model.dart';
import 'package:toolest/presentation/pages/home/widgets/tabbar/recent_tabs.dart';
import 'image_compressor_event.dart';
import 'image_compressor_state.dart';

class ImageCompressorBloc extends Bloc<ImageCompressorEvent, ImageCompressorState> {
  ImageCompressorBloc() : super(ImageCompressorInitial()) {
    on<SelectImageForCompression>(_onSelectImage);
    on<UpdateCompressionSettings>(_onUpdateSettings);
    on<ResetCompressionSettings>(_onResetSettings);
    on<CompressImageNow>(_onCompressImage);
    on<ClearSelectedImagesForImageCompressor>(_onClearSelectedImages);
  }

  Future<void> _onSelectImage(
      SelectImageForCompression event,
      Emitter<ImageCompressorState> emit,
      ) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png'],
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        final selectedImage = File(result.files.first.path!);
        emit(ImageCompressorSelected(
          selectedImage: selectedImage,
          quality: state.quality,
          format: state.format,
          resolution: state.resolution,
        ));
      } else {
        emit(ImageCompressorError(
          selectedImage: state.selectedImage,
          quality: state.quality,
          format: state.format,
          resolution: state.resolution,
          message: TNTextStrings.noImageSelected,
        ));
      }
    } catch (e) {
      emit(ImageCompressorError(
        selectedImage: state.selectedImage,
        quality: state.quality,
        format: state.format,
        resolution: state.resolution,
        message: '${TNTextStrings.errorPickingImages}: ${e.toString()}',
      ));
    }
  }

  void _onUpdateSettings(
      UpdateCompressionSettings event,
      Emitter<ImageCompressorState> emit,
      ) {
    emit(ImageCompressionSettingsUpdated(
      selectedImage: state.selectedImage,
      quality: event.quality,
      format: event.format,
      resolution: event.resolution,
    ));
  }

  void _onResetSettings(
      ResetCompressionSettings event,
      Emitter<ImageCompressorState> emit,
      ) {
    emit(ImageCompressionSettingsUpdated(
      selectedImage: state.selectedImage,
      quality: 70,
      format: 'JPEG',
      resolution: 'Original',
    ));
  }

  Future<void> _onCompressImage(
      CompressImageNow event,
      Emitter<ImageCompressorState> emit,
      ) async {
    if (state.selectedImage == null) {
      emit(ImageCompressorError(
        selectedImage: state.selectedImage,
        quality: state.quality,
        format: state.format,
        resolution: state.resolution,
        message: TNTextStrings.noImageSelected,
      ));
      return;
    }

    emit(ImageCompressionInProgress(
      selectedImage: state.selectedImage,
      quality: state.quality,
      format: state.format,
      resolution: state.resolution,
    ));

    try {
      final compressedFile = await _compressImage(
        file: state.selectedImage!,
        quality: state.quality,
        format: state.format,
        resolution: state.resolution,
      );

      emit(ImageCompressionSuccess(
        selectedImage: state.selectedImage,
        quality: state.quality,
        format: state.format,
        resolution: state.resolution,
        compressedFile: compressedFile,
      ));

      final ratio = await PdfService().detectAspectRatio(compressedFile.path, RecentFileType.image);
      // Optional: Add to recent files
      final recentImage = RecentFileModel(
        path: compressedFile.path,
        name: 'compressed_${compressedFile.path.split('/').last}',
        fileType: RecentFileType.image,
        status: FileStatus.completed,
        tab: RecentTabs.processed,
        aspectRatio: ratio,
      );

      /// Dispatch to HomePageBloc
      event.context.read<HomePageBloc>().add(AddRecentFileEvent(recentImage));
    } catch (e) {
      emit(ImageCompressorError(
        selectedImage: state.selectedImage,
        quality: state.quality,
        format: state.format,
        resolution: state.resolution,
        message: '${TNTextStrings.compressionFiled}: ${e.toString()}',
      ));
      debugPrint("FAiled comp ${e.toString()}");
    }
  }


  void _onClearSelectedImages(
      ClearSelectedImagesForImageCompressor event, Emitter emit,) {
      emit(ImageCompressorInitial());
  }

  Future<File> _compressImage({
    required File file,
    required double quality,
    required String format,
    required String resolution,
  }) async {
    final bytes = await file.readAsBytes();
    final dir = await getTemporaryDirectory();
    final timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());

    // Handle different formats
    final formatEnum = format == 'PNG'
        ? CompressFormat.png
        : CompressFormat.jpeg;

    final extension = format == 'PNG' ? 'png' : 'jpg';
    final targetPath = '${dir.path}/${TNTextStrings.appNameDirectory}$timestamp.$extension';

    // Handle resolution
    int? width, height;
    if (resolution != 'Original') {
      final img = await decodeImageFromList(bytes);
      final ratio = resolution == 'High' ? 0.75 :
      resolution == 'Medium' ? 0.5 : 0.25;
      width = (img.width * ratio).round();
      height = (img.height * ratio).round();
    }

    final result = (width != null && height != null)
        ? await FlutterImageCompress.compressAndGetFile(
      file.path,
      targetPath,
      quality: quality.toInt(),
      format: formatEnum,
      minWidth: width,
      minHeight: height,
      keepExif: true,
    )
        : await FlutterImageCompress.compressAndGetFile(
      file.path,
      targetPath,
      quality: quality.toInt(),
      format: formatEnum,
      keepExif: true,
    );

    if (result == null){
      throw Exception(TNTextStrings.compressionFiled);
    }
    return File(result.path);
  }
}