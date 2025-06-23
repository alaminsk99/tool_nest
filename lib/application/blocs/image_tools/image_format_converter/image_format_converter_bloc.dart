import 'dart:typed_data';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
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


  void _onConvert(ConvertFormatEvent event, Emitter emit) {
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
        } else {
          emit(ImageFormatError('Unsupported format.'));
        }
      } catch (e) {
        emit(ImageFormatError('Failed to convert: $e'));
      }
    }
  }

}
