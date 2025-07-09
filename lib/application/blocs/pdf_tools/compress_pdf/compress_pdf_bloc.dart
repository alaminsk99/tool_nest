import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:toolest/application/blocs/home/home_page_bloc.dart';
import 'package:toolest/core/utils/file_services/pdf_service.dart';
import 'package:toolest/domain/models/home/recent_file_model.dart';
import 'package:toolest/domain/models/pdf_tools/compress_pdf_model/compress_pdf_model.dart';
import 'package:toolest/presentation/pages/home/widgets/tabbar/recent_tabs.dart';

part 'compress_pdf_event.dart';
part 'compress_pdf_state.dart';

class CompressPdfBloc extends Bloc<CompressPdfEvent, CompressPdfState> {
  File? _pickedFile;
  CompressionLevel _selectedLevel = CompressionLevel.recommended;

  CompressPdfBloc() : super(CompressPdfInitial()) {
    on<PickPdfFileEvent>(_onPickFile);
    on<SetCompressionLevelEvent>(_onSetCompressionLevel);
    on<CompressPdfFileEvent>(_onCompressPdf);
    on<ClearPickedPdfEvent>(_onClearPickedFile);
  }

  Future<void> _onPickFile(PickPdfFileEvent event, Emitter<CompressPdfState> emit) async {
    emit(CompressPdfLoading());
    try {
      final file = File(event.filePath);
      if (!await file.exists()) {
        emit(const CompressPdfError("Selected file does not exist."));
        return;
      }
      _pickedFile = file;
      emit(CompressPdfPicked(file, _selectedLevel));
    } catch (e) {
      emit(CompressPdfError("Failed to pick file: ${e.toString()}"));
    }
  }


  void _onSetCompressionLevel(SetCompressionLevelEvent event, Emitter<CompressPdfState> emit) {
    _selectedLevel = event.level;
    if (_pickedFile != null) {
      emit(CompressPdfPicked(_pickedFile!, _selectedLevel));
    }
  }

  Future<void> _onCompressPdf(CompressPdfFileEvent event, Emitter<CompressPdfState> emit) async {
    if (_pickedFile == null) return;
    emit(CompressPdfLoading());
    try {
      final originalSize = await _pickedFile!.length();
      final document = PdfDocument(inputBytes: await _pickedFile!.readAsBytes());

      switch (_selectedLevel) {
        case CompressionLevel.extreme:
          document.compressionLevel = PdfCompressionLevel.best;
          break;
        case CompressionLevel.recommended:
          document.compressionLevel = PdfCompressionLevel.normal;
          break;
        case CompressionLevel.less:
          document.compressionLevel = PdfCompressionLevel.none;
          break;
      }

      final bytes = await document.save();
      document.dispose();

      final dir = await getTemporaryDirectory();
      final compressedFile = File("${dir.path}/compressed_${DateTime.now().millisecondsSinceEpoch}.pdf");
      await compressedFile.writeAsBytes(bytes);

      final compressedSize = await compressedFile.length();

      emit(CompressPdfSuccess(
        CompressedPdfModel(
          file: compressedFile,
          originalSize: originalSize,
          compressedSize: compressedSize,
        ),
      ));

      final aspectRatio = await PdfService().detectAspectRatio(compressedFile.path, RecentFileType.pdf);
      /// Add compressed PDF to recent processed files
      final recentFile = RecentFileModel(
        path: compressedFile.path,
        name: compressedFile.path.split('/').last,
        fileType: RecentFileType.pdf,
        status: FileStatus.completed,
        tab: RecentTabs.processed,
        aspectRatio: aspectRatio,
      );

      event.context.read<HomePageBloc>().add(AddRecentFileEvent(recentFile));
    } catch (e) {
      emit(CompressPdfError(e.toString()));
    }
  }

  void _onClearPickedFile(ClearPickedPdfEvent event, Emitter<CompressPdfState> emit) {
    _pickedFile = null;
    _selectedLevel = CompressionLevel.recommended;
    emit(CompressPdfInitial());
  }
}