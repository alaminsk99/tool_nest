import 'dart:typed_data';
import 'package:image/image.dart' as img;

abstract class ImageFormatConverterState {}

class InitialState extends ImageFormatConverterState {}

class ImageFormatPickedState extends ImageFormatConverterState {
  final img.Image originalImage;
  final Uint8List imageBytes;
  final String currentFormat;

  ImageFormatPickedState({
    required this.originalImage,
    required this.imageBytes,
    required this.currentFormat,
  });
}

class ImageFormatLoading extends ImageFormatConverterState {}

class ImageFormatDone extends ImageFormatConverterState {
  final Uint8List convertedBytes;
  final String format;

  ImageFormatDone({
    required this.convertedBytes,
    required this.format,
  });
}

class ImageFormatError extends ImageFormatConverterState {
  final String message;

  ImageFormatError(this.message);
}
