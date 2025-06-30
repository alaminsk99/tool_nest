import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolest/application/blocs/home/home_page_bloc.dart';
import 'package:toolest/core/utils/file_services/pdf_service.dart';
import 'package:toolest/domain/models/home/recent_file_model.dart';
import 'package:toolest/domain/models/pdf_tools/pdf_merge_model/pdf_file_model.dart';
import 'package:toolest/presentation/pages/home/widgets/tabbar/recent_tabs.dart';

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
      ///  Add merged PDF to recent processed files
      final recentFile = RecentFileModel(
        path: merged.path,
        name: merged.path.split('/').last,
        fileType: RecentFileType.pdf,
        status: FileStatus.completed,
        tab: RecentTabs.processed,
      );

      event.context.read<HomePageBloc>().add(AddRecentFileEvent(recentFile));
    } catch (e) {
      emit(MergeFailed(e.toString()));
    }
  }
}
