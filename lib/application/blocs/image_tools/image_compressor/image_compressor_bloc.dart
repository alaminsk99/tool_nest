
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tool_nest/application/blocs/image_tools/image_compressor/image_compressor_event.dart';
import 'package:tool_nest/application/blocs/image_tools/image_compressor/image_compressor_state.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';
import 'package:tool_nest/core/constants/text_strings.dart';

class ImageCompressorBloc extends Bloc<ImageCompressorEvent, ImageCompressorState> {
  File? _selectedImage;
  double _quality = 70;
  String _format = 'jpeg';
  String _resolution = 'original';

  ImageCompressorBloc() : super(ImageCompressorInitial()) {
    on<SelectImageForCompression>(_onSelectImage);
    on<UpdateCompressionSettings>(_onUpdateSettings);
    on<ResetCompressionSettings>(_onResetSettings);
    on<CompressImageNow>(_onCompressImage);
    on<ClearSelectedImagesEventForImageCompressor>(_onClearSelectedImagesForImageCompressor);
  }

  Future<void> _onSelectImage(SelectImageForCompression event, Emitter emit) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png'],
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        _selectedImage = File(result.files.first.path!);
        emit(ImageCompressorSelected(_selectedImage!.path));
      } else {
        emit(ImageCompressorError(TNTextStrings.noImageSelected));
      }
    } catch (e) {
      emit(ImageCompressorError(TNTextStrings.errorPickingImages));
    }
  }
  void _onClearSelectedImagesForImageCompressor(ClearSelectedImagesEventForImageCompressor event, Emitter emit) {
    _selectedImage = null;
    emit(ImageCompressorInitial());
  }

  void _onUpdateSettings(UpdateCompressionSettings event, Emitter emit) {
    _quality = event.quality;
    _format = event.format;
    _resolution = event.resolution;
    emit(ImageCompressionSettingsUpdated(
      quality: _quality,
      format: _format,
      resolution: _resolution,
    ));
  }

  void _onResetSettings(ResetCompressionSettings event, Emitter emit) {
    _quality = 70;
    _format = 'jpeg';
    _resolution = 'original';
    emit(ImageCompressionSettingsUpdated(
      quality: _quality,
      format: _format,
      resolution: _resolution,
    ));
  }

  Future<void> _onCompressImage(CompressImageNow event, Emitter emit) async {
    if (_selectedImage == null) {
      emit(ImageCompressorError("No image selected"));
      return;
    }

    emit(ImageCompressorLoading());

    try {
      final compressedPath = await _compressImage(
        filePath: _selectedImage!.path,
        quality: _quality,
        format: _format,
        resolution: _resolution,
      );
      emit(ImageCompressionSuccess(compressedPath));
    } catch (e) {
      emit(ImageCompressorError("Compression failed: ${e.toString()}"));
    }
  }

  Future<String> _compressImage({
    required String filePath,
    required double quality,
    required String format,
    required String resolution,
  }) async {
    final dir = await getTemporaryDirectory();
    final timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
    final extension = format == 'png' ? 'png' : 'jpg';
    final targetPath = '${dir.path}/compressed_$timestamp.$extension';

    final formatEnum = format == 'png' ? CompressFormat.png : CompressFormat.jpeg;

    final result = await FlutterImageCompress.compressAndGetFile(
      filePath,
      targetPath,
      quality: quality.toInt(),
      format: formatEnum,
    );

    if (result == null) throw Exception(TNTextStrings.compressionFiled);
    return result.path;
  }
}

