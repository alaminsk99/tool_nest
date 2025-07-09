import 'dart:typed_data';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:toolest/application/blocs/home/home_page_bloc.dart';
import 'package:toolest/core/utils/file_services/pdf_service.dart';
import 'package:toolest/domain/models/home/recent_file_model.dart';
import 'package:toolest/presentation/pages/home/widgets/tabbar/recent_tabs.dart';
import 'image_format_converter_event.dart';
import 'image_format_converter_state.dart';

class ImageFormatConverterBloc extends Bloc<ImageFormatConverterEvent, ImageFormatConverterState> {
  ImageFormatConverterBloc() : super(InitialState()) {
    on<PickImageFormatEvent>(_onPickImage);
    on<UpdateFormatEvent>(_onUpdateFormat);
    on<ConvertFormatEvent>(_onConvert);
    on<ResetConverterStateEvent>((_, emit) => emit(InitialState()));
  }

  void _onPickImage(PickImageFormatEvent event, Emitter emit) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      final decoded = img.decodeImage(bytes);
      if (decoded != null) {
        emit(ImageFormatPickedState(
          originalImage: decoded,
          imageBytes: bytes,
          currentFormat: 'jpg',
          originalFormat: pickedFile.name.split('.').last,
        ));
      } else {
        emit(ImageFormatError('Failed to decode image.'));
      }
    } else {
      emit(ImageFormatError('No image selected.'));
    }
  }

  void _onUpdateFormat(UpdateFormatEvent event, Emitter emit) {
    final current = state;
    if (current is ImageFormatPickedState) {
      emit(ImageFormatPickedState(
        originalImage: current.originalImage,
        imageBytes: current.imageBytes,
        currentFormat: event.format,
        originalFormat: current.originalFormat,
      ));
    }
  }


  Future<void> _onConvert(ConvertFormatEvent event, Emitter emit) async {
    final current = state;
    if (current is ImageFormatPickedState) {
      emit(ImageFormatLoading());
      Uint8List? convertedBytes;
      try {
        // Normalize format string to lowercase
        final format = current.currentFormat.toLowerCase();

        if (format == 'jpg' || format == 'jpeg') {
          convertedBytes = Uint8List.fromList(img.encodeJpg(current.originalImage));
        } else if (format == 'png') {
          convertedBytes = Uint8List.fromList(img.encodePng(current.originalImage));
        }
        // WebP support can be added here if needed
        // else if (format == 'webp') {
        //   convertedBytes = Uint8List.fromList(img.encodeWebp(current.originalImage));
        // }

        if (convertedBytes != null) {
          emit(ImageFormatDone(
            convertedBytes: convertedBytes,
            format: format,
          ));
          // Save file to temp directory
          final tempDir = await getTemporaryDirectory();
          final fileName = 'converted_${DateTime.now().millisecondsSinceEpoch}.$format';
          final filePath = '${tempDir.path}/$fileName';
          final file = File(filePath);
          await file.writeAsBytes(convertedBytes);

          final ratio = await PdfService().detectAspectRatio(file.path, RecentFileType.image);
          // Add to recent files (processed tab)
          final recent = RecentFileModel(
            path: file.path,
            name: fileName,
            fileType: RecentFileType.image,
            status: FileStatus.completed,
            tab: RecentTabs.processed,
            aspectRatio: ratio,
          );
          event.context.read<HomePageBloc>().add(AddRecentFileEvent(recent));
        } else {
          emit(ImageFormatError('Unsupported format.'));
        }
      } catch (e) {
        emit(ImageFormatError('Failed to convert: $e'));
      }
    }
  }

}
