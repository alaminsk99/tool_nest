part of 'merge_pdf_bloc.dart';

sealed class MergePdfEvent extends Equatable {
  const MergePdfEvent();
  @override List<Object?> get props => [];
}

final class AddFiles extends MergePdfEvent {
  final List<PdfFileModel> files;
  const AddFiles(this.files);
  @override List<Object?> get props => [files];
}

final class UpdateSettings extends MergePdfEvent {
  final int spacing;
  const UpdateSettings(this.spacing);
  @override List<Object?> get props => [spacing];
}

class MergeRequested extends MergePdfEvent {
  final BuildContext context;

  MergeRequested({required this.context});
}


class ClearFiles extends MergePdfEvent {
  const ClearFiles();
  @override
  List<Object> get props => [];
}
