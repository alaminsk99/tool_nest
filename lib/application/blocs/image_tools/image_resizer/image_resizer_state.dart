import 'dart:typed_data';
import 'package:equatable/equatable.dart';
import 'package:image/image.dart' as img;

abstract class ImageResizeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ImageResizeInitial extends ImageResizeState {}

class ImageResizeLoaded extends ImageResizeState {
  final img.Image originalImage;
  final Uint8List imageBytes;
  final int width;
  final int height;
  final bool lockAspectRatio;

  ImageResizeLoaded({
    required this.originalImage,
    required this.imageBytes,
    required this.width,
    required this.height,
    required this.lockAspectRatio,
  });

  ImageResizeLoaded copyWith({
    int? width,
    int? height,
    bool? lockAspectRatio,
  }) {
    return ImageResizeLoaded(
      originalImage: originalImage,
      imageBytes: imageBytes,
      width: width ?? this.width,
      height: height ?? this.height,
      lockAspectRatio: lockAspectRatio ?? this.lockAspectRatio,
    );
  }

  @override
  List<Object?> get props => [imageBytes, width, height, lockAspectRatio];
}

class ImageResizeDone extends ImageResizeState {
  final Uint8List resizedBytes;
  final int width;
  final int height;

  ImageResizeDone({
    required this.resizedBytes,
    required this.width,
    required this.height,
  });

  @override
  List<Object?> get props => [resizedBytes, width, height];
}

class ImageResizeError extends ImageResizeState {
  final String message;

  ImageResizeError(this.message);

  @override
  List<Object?> get props => [message];
}
