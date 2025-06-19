import 'dart:io';













class PdfFileModel {
  final File file;
  final String name;
  PdfFileModel(this.file) : name = file.path.split('/').last;
}
