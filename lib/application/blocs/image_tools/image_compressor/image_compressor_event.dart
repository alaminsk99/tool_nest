





abstract class ImageCompressorEvent{}







class SelectImageForCompression extends ImageCompressorEvent {}
class ResetCompressionSettings extends ImageCompressorEvent {}
class UpdateCompressionSettings extends ImageCompressorEvent {
  final double quality;
  final String format;
  final String resolution;

  UpdateCompressionSettings({
    required this.quality,
    required this.format,
    required this.resolution,
  });
}
class CompressImageNow extends ImageCompressorEvent {}
class ClearSelectedImagesForImageCompressor extends ImageCompressorEvent {}