import 'dart:ui' as ui;
import 'package:flutter/services.dart';


Future<ui.Image> decodeImageFromList(Uint8List bytes) async {
  final codec = await ui.instantiateImageCodec(bytes);
  final frame = await codec.getNextFrame();
  return frame.image;
}
