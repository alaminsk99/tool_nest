
import 'dart:io';

class PdfSplitFileModel {
  final File file;
  final String fileName;

  PdfSplitFileModel(this.file) : fileName = file.path.split('/').last;

  /// Utility to get file name without extension
  String get nameWithoutExtension {
    final dotIndex = fileName.lastIndexOf('.');
    return dotIndex != -1 ? fileName.substring(0, dotIndex) : fileName;
  }

  /// Utility to get file extension
  String get extension {
    final dotIndex = fileName.lastIndexOf('.');
    return dotIndex != -1 ? fileName.substring(dotIndex + 1) : '';
  }
}
