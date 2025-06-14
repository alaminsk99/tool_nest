part of 'image_resizer_bloc.dart';





abstract class ImageResizerEvent extends Equatable {
  const ImageResizerEvent();
}

class SelectImage extends ImageResizerEvent {
  @override
  List<Object?> get props => [];
}

class SetDimensions extends ImageResizerEvent {
  final int width;
  final int height;

  const SetDimensions(this.width, this.height);

  @override
  List<Object?> get props => [width, height];
}

class ResizeImage extends ImageResizerEvent {
  @override
  List<Object?> get props => [];
}

class ResetState extends ImageResizerEvent {
  @override
  List<Object?> get props => [];
}