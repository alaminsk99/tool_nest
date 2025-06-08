abstract class ImageToPdfState {}

class ImageToPdfInitial extends ImageToPdfState {}

class ImageSelectionSuccess extends ImageToPdfState {
  final List<String> imagePaths;
  ImageSelectionSuccess(this.imagePaths);
}

class SettingsUpdated extends ImageToPdfState {
  final String pageSize;
  final String orientation;
  final double margin;

  SettingsUpdated(this.pageSize, this.orientation, this.margin);
}

class PdfConversionInProgress extends ImageToPdfState {}

class PdfConversionSuccess extends ImageToPdfState {
  final String pdfPath;
  PdfConversionSuccess(this.pdfPath);
}

class ImageToPdfError extends ImageToPdfState {
  final String message;
  ImageToPdfError(this.message);
}
