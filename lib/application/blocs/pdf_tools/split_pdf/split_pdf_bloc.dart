// lib/application/blocs/pdf_tools/split_pdf/split_pdf_bloc.dart

import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tool_nest/core/utils/file_services/pdf_service.dart';
import 'package:tool_nest/domain/models/pdf_tools/split_pdf_model/pdf_split_file_model.dart';

part 'split_pdf_event.dart';
part 'split_pdf_state.dart';

class SplitPdfBloc extends Bloc<SplitPdfEvent, SplitPdfState> {
  PdfSplitFileModel? _file;
  List<int> _selectedPages = [];

  final PdfService _pdfService;

  SplitPdfBloc({PdfService? service})
      : _pdfService = service ?? PdfService(),
        super(SplitPdfInitial()) {
    on<PickSplitFile>(_onPickFile);
    on<ApplySplitSettings>(_onApplySettings);
    on<PerformSplit>(_onPerformSplit);
  }

  void _onPickFile(PickSplitFile event, Emitter<SplitPdfState> emit) {
    _file = event.file;
    emit(FileSelected(event.file));
  }

  void _onApplySettings(ApplySplitSettings event, Emitter<SplitPdfState> emit) {
    _selectedPages = event.selectedPages;
    if (_file != null) {
      emit(SplitSettingsUpdated(_file!, _selectedPages));
    }
  }

  Future<void> _onPerformSplit(
      PerformSplit event, Emitter<SplitPdfState> emit) async {
    if (_file == null || _selectedPages.isEmpty) {
      emit(const SplitFailed('No file or pages selected.'));
      return;
    }

    emit(SplittingInProgress());

    try {
      final splitFiles = await _pdfService.splitPdf(_file!.file, _selectedPages);
      emit(SplitSuccess(splitFiles));
    } catch (e) {
      emit(SplitFailed(e.toString()));
    }
  }
}
