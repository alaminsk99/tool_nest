import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tool_nest/core/utils/file_services/pdf_service.dart';
import 'package:tool_nest/domain/models/pdf_tools/pdf_merge_model/pdf_file_model.dart';

part 'merge_pdf_event.dart';
part 'merge_pdf_state.dart';

class MergePdfBloc extends Bloc<MergePdfEvent, MergePdfState> {
  final PdfService _service;
  List<PdfFileModel> _files = [];
  int _spacing = 0;

  MergePdfBloc({PdfService? service})
      : _service = service ?? PdfService(),
        super(MergePdfInitial()) {
    on<AddFiles>(_onAddFiles);
    on<UpdateSettings>(_onUpdateSettings);
    on<MergeRequested>(_onMergeRequested);
    on<ClearFiles>((event, emit) {
      _files.clear();
      emit(MergePdfInitial());
    });

  }

  void _onAddFiles(AddFiles event, Emitter<MergePdfState> emit) {
    _files.addAll(event.files);
    emit(FilesPicked(List.from(_files)));
  }

  void _onUpdateSettings(UpdateSettings event, Emitter<MergePdfState> emit) {
    _spacing = event.spacing;
    emit(SettingsUpdated(List.from(_files), _spacing));
  }

  Future<void> _onMergeRequested(
      MergeRequested event, Emitter<MergePdfState> emit) async {
    emit(MergingInProgress());
    try {
      final merged = await _service.mergePdfs(_files);
      emit(MergedSuccess(merged));
    } catch (e) {
      emit(MergeFailed(e.toString()));
    }
  }
}
