import 'dart:io';
import 'dart:math';

abstract class ImageCompressorState {
  final File? selectedImage;
  final double quality;
  final String format;
  final String resolution;

  const ImageCompressorState({
    required this.selectedImage,
    required this.quality,
    required this.format,
    required this.resolution,
  });

  // Add helper to get file size
  String get originalSize {
    if (selectedImage == null) return '0 KB';
    final bytes = selectedImage!.lengthSync();
    return _formatBytes(bytes);
  }

  static String _formatBytes(int bytes) {
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB"];
    final i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(2)} ${suffixes[i]}';
  }
}

class ImageCompressorInitial extends ImageCompressorState {
  ImageCompressorInitial()
      : super(
    selectedImage: null,
    quality: 70,
    format: 'JPEG',
    resolution: 'Original',
  );
}

class ImageCompressorSelected extends ImageCompressorState {
  ImageCompressorSelected({
    required File? selectedImage,
    required double quality,
    required String format,
    required String resolution,
  }) : super(
    selectedImage: selectedImage,
    quality: quality,
    format: format,
    resolution: resolution,
  );
}

class ImageCompressionSettingsUpdated extends ImageCompressorState {
  ImageCompressionSettingsUpdated({
    required File? selectedImage,
    required double quality,
    required String format,
    required String resolution,
  }) : super(
    selectedImage: selectedImage,
    quality: quality,
    format: format,
    resolution: resolution,
  );
}

class ImageCompressionInProgress extends ImageCompressorState {
  ImageCompressionInProgress({
    required File? selectedImage,
    required double quality,
    required String format,
    required String resolution,
  }) : super(
    selectedImage: selectedImage,
    quality: quality,
    format: format,
    resolution: resolution,
  );
}

class ImageCompressionSuccess extends ImageCompressorState {
  final File compressedFile;

  ImageCompressionSuccess({
    required File? selectedImage,
    required double quality,
    required String format,
    required String resolution,
    required this.compressedFile,
  }) : super(
    selectedImage: selectedImage,
    quality: quality,
    format: format,
    resolution: resolution,
  );

  // Add compressed size helper
  String get compressedSize {
    final bytes = compressedFile.lengthSync();
    return ImageCompressorState._formatBytes(bytes);
  }
}

class ImageCompressorError extends ImageCompressorState {
  final String message;

  ImageCompressorError({
    required File? selectedImage,
    required double quality,
    required String format,
    required String resolution,
    required this.message,
  }) : super(
    selectedImage: selectedImage,
    quality: quality,
    format: format,
    resolution: resolution,
  );
}