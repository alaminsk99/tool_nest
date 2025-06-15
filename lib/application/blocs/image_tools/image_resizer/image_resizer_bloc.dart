import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';

import 'image_resizer_event.dart';
import 'image_resizer_state.dart';

class ImageResizeBloc extends Bloc<ImageResizeEvent, ImageResizeState> {
  ImageResizeBloc() : super(ImageResizeInitial()) {
    on<PickImageEvent>(_onPickImage);
    on<UpdateWidthEvent>(_onUpdateWidth);
    on<UpdateHeightEvent>(_onUpdateHeight);
    on<UpdateAspectRatioLockEvent>(_onUpdateAspectRatioLock);
    on<ResizeImageEvent>(_onResizeImage);
  }

  void _onPickImage(PickImageEvent event, Emitter<ImageResizeState> emit) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      final decoded = img.decodeImage(bytes);
      if (decoded != null) {
        emit(ImageResizeLoaded(
          originalImage: decoded,
          imageBytes: bytes,
          width: decoded.width,
          height: decoded.height,
          lockAspectRatio: true,
        ));
      } else {
        emit(ImageResizeError('Failed to decode image.'));
      }
    } else {
      emit(ImageResizeError('No image selected.'));
    }
  }

  void _onUpdateWidth(UpdateWidthEvent event, Emitter<ImageResizeState> emit) {
    final current = state;
    if (current is ImageResizeLoaded) {
      int newHeight = current.height;

      if (current.lockAspectRatio) {
        newHeight = (current.originalImage.height * event.width / current.originalImage.width).round();
      }

      emit(current.copyWith(width: event.width, height: newHeight));
    }
  }

  void _onUpdateHeight(UpdateHeightEvent event, Emitter<ImageResizeState> emit) {
    final current = state;
    if (current is ImageResizeLoaded) {
      int newWidth = current.width;

      if (current.lockAspectRatio) {
        newWidth = (current.originalImage.width * event.height / current.originalImage.height).round();
      }

      emit(current.copyWith(width: newWidth, height: event.height));
    }
  }

  void _onUpdateAspectRatioLock(UpdateAspectRatioLockEvent event, Emitter<ImageResizeState> emit) {
    final current = state;
    if (current is ImageResizeLoaded) {
      emit(current.copyWith(lockAspectRatio: event.lock));
    }
  }

  void _onResizeImage(ResizeImageEvent event, Emitter<ImageResizeState> emit) {
    final current = state;
    if (current is ImageResizeLoaded) {
      final resized = img.copyResize(
        current.originalImage,
        width: current.width,
        height: current.height,
      );
      final bytes = Uint8List.fromList(img.encodeJpg(resized));
      emit(ImageResizeDone(
        resizedBytes: bytes,
        width: current.width,
        height: current.height,
      ));
    }
  }
}
