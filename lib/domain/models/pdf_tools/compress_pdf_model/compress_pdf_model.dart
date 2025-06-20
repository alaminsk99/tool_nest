
import 'dart:io';

class CompressedPdfModel {
  final File file;
  final int originalSize;
  final int compressedSize;

  CompressedPdfModel({
    required this.file,
    required this.originalSize,
    required this.compressedSize,
  });
}
