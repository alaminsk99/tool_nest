part of 'image_resizer_bloc.dart';

abstract class ImageResizerState extends Equatable {
  const ImageResizerState();
}

class ImageResizerInitial extends ImageResizerState {
  @override
  List<Object?> get props => [];
}

class ImageSelected extends ImageResizerState {
  final File imageFile;
  final Uint8List imageBytes;

  const ImageSelected(this.imageFile, this.imageBytes);

  @override
  List<Object?> get props => [imageFile, imageBytes];
}

class DimensionsSet extends ImageResizerState {
  final File imageFile;
  final Uint8List imageBytes;
  final int width;
  final int height;

  const DimensionsSet({
    required this.imageFile,
    required this.imageBytes,
    required this.width,
    required this.height,
  });

  @override
  List<Object?> get props => [imageFile, imageBytes, width, height];
}

class ImageResizing extends ImageResizerState {
  @override
  List<Object?> get props => [];
}

class ImageResized extends ImageResizerState {
  final Uint8List resizedImage;
  final String originalPath;
  final int width;
  final int height;

  const ImageResized({
    required this.resizedImage,
    required this.originalPath,
    required this.width,
    required this.height,
  });

  @override
  List<Object?> get props => [resizedImage, originalPath, width, height];
}

class ImageResizerError extends ImageResizerState {
  final String message;

  const ImageResizerError(this.message);

  @override
  List<Object?> get props => [message];
}
