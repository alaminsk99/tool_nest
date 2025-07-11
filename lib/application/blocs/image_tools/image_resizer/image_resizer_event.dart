import 'package:flutter/material.dart';

abstract class ImageResizeEvent {}

class PickImageEvent extends ImageResizeEvent {}

class UpdateWidthEvent extends ImageResizeEvent {
  final int width;

  UpdateWidthEvent(this.width);
}

class UpdateHeightEvent extends ImageResizeEvent {
  final int height;

  UpdateHeightEvent(this.height);
}

class UpdateAspectRatioLockEvent extends ImageResizeEvent {
  final bool lock;

  UpdateAspectRatioLockEvent(this.lock);
}

class ResizeImageEvent extends ImageResizeEvent {
  final BuildContext context;

  ResizeImageEvent({required this.context});
}

class ResetResizeStateEvent extends ImageResizeEvent {}

enum DimensionChanged { width, height }
