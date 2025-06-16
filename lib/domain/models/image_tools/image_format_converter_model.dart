import 'dart:typed_data';

class ImageFormatConverterResultDataModel {
  final Uint8List convertedBytes;
  final String format;

  ImageFormatConverterResultDataModel({required this.convertedBytes, required this.format});
}
