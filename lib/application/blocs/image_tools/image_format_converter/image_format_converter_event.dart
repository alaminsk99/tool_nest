abstract class ImageFormatConverterEvent {}

class PickImageFormatEvent extends ImageFormatConverterEvent {}

class UpdateFormatEvent extends ImageFormatConverterEvent {
  final String format;
  UpdateFormatEvent(this.format);
}

class ConvertFormatEvent extends ImageFormatConverterEvent {}

class ResetConverterStateEvent extends ImageFormatConverterEvent {}
