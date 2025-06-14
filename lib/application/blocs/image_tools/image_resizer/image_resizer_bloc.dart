import 'dart:async';
import 'dart:typed_data';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';

part 'image_resizer_event.dart';
part 'image_resizer_state.dart';

class ImageResizerBloc extends Bloc<ImageResizerEvent, ImageResizerState> {
  ImageResizerBloc() : super(ImageResizerInitial()) {
    on<SelectImage>(_onSelectImage);
    on<SetDimensions>(_onSetDimensions);
    on<ResizeImage>(_onResizeImage);
    on<ResetState>(_onResetState);
  }

  Future<void> _onSelectImage(
      SelectImage event,
      Emitter<ImageResizerState> emit,
      ) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile == null) return;

      final file = File(pickedFile.path);
      final bytes = await file.readAsBytes();
      emit(ImageSelected(file, bytes));
    } catch (e) {
      emit(ImageResizerError('Failed to select image: ${e.toString()}'));
    }
  }

  void _onSetDimensions(
      SetDimensions event,
      Emitter<ImageResizerState> emit,
      ) {
    if (state is ImageSelected) {
      final currentState = state as ImageSelected;
      emit(DimensionsSet(
        imageFile: currentState.imageFile,
        imageBytes: currentState.imageBytes,
        width: event.width,
        height: event.height,
      ));
    }
  }

  Future<void> _onResizeImage(
      ResizeImage event,
      Emitter<ImageResizerState> emit,
      ) async {
    if (state is! DimensionsSet) return;

    emit(ImageResizing());

    try {
      final currentState = state as DimensionsSet;
      final original = img.decodeImage(currentState.imageBytes);
      if (original == null) throw Exception('Invalid image data');

      final resized = img.copyResize(
        original,
        width: currentState.width,
        height: currentState.height,
      );

      final resizedBytes = Uint8List.fromList(img.encodePng(resized));
      emit(ImageResized(
        resizedImage: resizedBytes,
        originalPath: currentState.imageFile.path,
        width: currentState.width,
        height: currentState.height,
      ));
    } catch (e) {
      debugPrint(e.toString());
      emit(ImageResizerError('Resize failed: ${e.toString()}'));
    }
  }

  void _onResetState(
      ResetState event,
      Emitter<ImageResizerState> emit,
      ) {
    emit(ImageResizerInitial());
  }
}
