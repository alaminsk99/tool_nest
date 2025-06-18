import 'dart:typed_data';

class PdfToImageResultModel {
  final Uint8List imageBytes;
  final int pageNumber;

  const PdfToImageResultModel({
    required this.imageBytes,
    required this.pageNumber,
  });
}
