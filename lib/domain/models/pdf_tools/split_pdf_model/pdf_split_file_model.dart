import 'dart:io';

class PdfSplitFileModel {
  final File file;
  final String fileName;
  final int totalPages;

  PdfSplitFileModel({
    required this.file,
    required this.totalPages,
  }) : fileName = file.path.split('/').last;

  String get nameWithoutExtension {
    final dotIndex = fileName.lastIndexOf('.');
    return dotIndex != -1 ? fileName.substring(0, dotIndex) : fileName;
  }

  String get extension {
    final dotIndex = fileName.lastIndexOf('.');
    return dotIndex != -1 ? fileName.substring(dotIndex + 1) : '';
  }
}
