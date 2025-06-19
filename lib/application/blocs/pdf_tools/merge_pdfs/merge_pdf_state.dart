part of 'merge_pdf_bloc.dart';

sealed class MergePdfState extends Equatable {
  const MergePdfState();
  @override List<Object?> get props => [];
}

final class MergePdfInitial extends MergePdfState {}

final class FilesPicked extends MergePdfState {
  final List<PdfFileModel> files;
  const FilesPicked(this.files);
  @override List<Object?> get props => [files];
}

final class SettingsUpdated extends MergePdfState {
  final List<PdfFileModel> files;
  final int spacing;
  const SettingsUpdated(this.files, this.spacing);
  @override List<Object?> get props => [files, spacing];
}

final class MergingInProgress extends MergePdfState {}

final class MergedSuccess extends MergePdfState {
  final File mergedPdf;
  const MergedSuccess(this.mergedPdf);
  @override List<Object?> get props => [mergedPdf];
}

final class MergeFailed extends MergePdfState {
  final String error;
  const MergeFailed(this.error);
  @override List<Object?> get props => [error];
}
