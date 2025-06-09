import 'dart:io';

abstract class ImageToPdfState {
  final List<File> selectedImages;
  final String pageSize;
  final String orientation;
  final double margin;
  final bool isCustomMargin;

  const ImageToPdfState({
    required this.selectedImages,
    required this.pageSize,
    required this.orientation,
    required this.margin,
    required this.isCustomMargin,
  });
}

class ImageToPdfInitial extends ImageToPdfState {
  ImageToPdfInitial()
      : super(
    selectedImages: [],
    pageSize: 'Original',
    orientation: 'Portrait',
    margin: 10.0,
    isCustomMargin: false,
  );
}

class SettingsUpdated extends ImageToPdfState {
  SettingsUpdated({
    required super.selectedImages,
    required super.pageSize,
    required super.orientation,
    required super.margin,
    required super.isCustomMargin,
  });
}

class ImageSelectionSuccess extends ImageToPdfState {
  ImageSelectionSuccess({
    required super.selectedImages,
    required super.pageSize,
    required super.orientation,
    required super.margin,
    required super.isCustomMargin,
  });
}

class PdfConversionInProgress extends ImageToPdfState {
  PdfConversionInProgress({
    required super.selectedImages,
    required super.pageSize,
    required super.orientation,
    required super.margin,
    required super.isCustomMargin,
  });
}

class PdfConversionSuccess extends ImageToPdfState {
  final String pdfPath;

  PdfConversionSuccess({
    required super.selectedImages,
    required super.pageSize,
    required super.orientation,
    required super.margin,
    required super.isCustomMargin,
    required this.pdfPath,
  });
}

class ImageToPdfError extends ImageToPdfState {
  final String message;

  ImageToPdfError({
    required super.selectedImages,
    required super.pageSize,
    required super.orientation,
    required super.margin,
    required super.isCustomMargin,
    required this.message,
  });
}