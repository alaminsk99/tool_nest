

part of 'split_pdf_bloc.dart';

abstract class SplitPdfState extends Equatable {
  const SplitPdfState();

  @override
  List<Object?> get props => [];
}

class SplitPdfInitial extends SplitPdfState {}

class FileSelected extends SplitPdfState {
  final PdfSplitFileModel file;
  const FileSelected(this.file);

  @override
  List<Object?> get props => [file];
}

class SplitSettingsUpdated extends SplitPdfState {
  final PdfSplitFileModel file;
  final List<int> selectedPages;
  const SplitSettingsUpdated(this.file, this.selectedPages);

  @override
  List<Object?> get props => [file, selectedPages];
}

class SplittingInProgress extends SplitPdfState {}

class SplitSuccess extends SplitPdfState {
  final List<File> splitFiles;
  const SplitSuccess(this.splitFiles);

  @override
  List<Object?> get props => [splitFiles];
}

class SplitFailed extends SplitPdfState {
  final String error;
  const SplitFailed(this.error);

  @override
  List<Object?> get props => [error];
}
