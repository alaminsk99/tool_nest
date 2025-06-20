

part of 'split_pdf_bloc.dart';

abstract class SplitPdfEvent extends Equatable {
  const SplitPdfEvent();

  @override
  List<Object?> get props => [];
}

class PickSplitFile extends SplitPdfEvent {
  final PdfSplitFileModel file;
  const PickSplitFile(this.file);

  @override
  List<Object?> get props => [file];
}

class ApplySplitSettings extends SplitPdfEvent {
  final List<int> selectedPages;
  const ApplySplitSettings(this.selectedPages);

  @override
  List<Object?> get props => [selectedPages];
}

class PerformSplit extends SplitPdfEvent {}
