



abstract class ImageCompressorState{}








class ImageCompressorInitial extends ImageCompressorState {}
class ImageCompressorLoading extends ImageCompressorState {}
class ImageCompressorSelected extends ImageCompressorState {
  final String imagePath;

  ImageCompressorSelected(this.imagePath);
}
class ImageCompressionSettingsUpdated extends ImageCompressorState {
  final double quality;
  final String format;
  final String resolution;

  ImageCompressionSettingsUpdated({
    required this.quality,
    required this.format,
    required this.resolution,
  });
}
class ImageCompressionInProgress extends ImageCompressorState {}
class ImageCompressionSuccess extends ImageCompressorState {
  final String compressedFilePath;

  ImageCompressionSuccess(this.compressedFilePath);
}

class ImageCompressorError extends ImageCompressorState {
  final String message;

  ImageCompressorError(this.message);
}
