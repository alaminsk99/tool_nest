import 'package:flutter/material.dart';

abstract class ImageFormatConverterEvent {}

class PickImageFormatEvent extends ImageFormatConverterEvent {}

class UpdateFormatEvent extends ImageFormatConverterEvent {
  final String format;
  UpdateFormatEvent(this.format);
}

class ConvertFormatEvent extends ImageFormatConverterEvent {
  final BuildContext context;
   ConvertFormatEvent({required this.context});
}


class ResetConverterStateEvent extends ImageFormatConverterEvent {}
