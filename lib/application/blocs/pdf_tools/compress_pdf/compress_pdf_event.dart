part of 'compress_pdf_bloc.dart';

abstract class CompressPdfEvent extends Equatable {
  const CompressPdfEvent();

  @override
  List<Object?> get props => [];
}

class PickPdfFileEvent extends CompressPdfEvent {
  final String filePath;
  const PickPdfFileEvent(this.filePath);

  @override
  List<Object?> get props => [filePath];
}


class SetCompressionLevelEvent extends CompressPdfEvent {
  final CompressionLevel level;
  const SetCompressionLevelEvent(this.level);

  @override
  List<Object?> get props => [level];
}

class CompressPdfFileEvent extends CompressPdfEvent {}

enum CompressionLevel { extreme, recommended, less }
class ClearPickedPdfEvent extends CompressPdfEvent {
  const ClearPickedPdfEvent();
}
