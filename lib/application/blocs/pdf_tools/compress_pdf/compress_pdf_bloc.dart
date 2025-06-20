import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:tool_nest/domain/models/pdf_tools/compress_pdf_model/compress_pdf_model.dart';

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

