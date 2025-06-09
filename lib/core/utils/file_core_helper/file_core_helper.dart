import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';

Future<Size> getImageSize(String path) async {
  final bytes = await File(path).readAsBytes();
  final image = await decodeImageFromList(bytes);
  return Size(image.width.toDouble(), image.height.toDouble());
}



Future<ui.Image> decodeImageFromList(Uint8List bytes) async {
  final codec = await ui.instantiateImageCodec(bytes);
  final frame = await codec.getNextFrame();
  return frame.image;
}
