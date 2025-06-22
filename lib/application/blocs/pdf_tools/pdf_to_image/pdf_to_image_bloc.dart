import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:pdfx/pdfx.dart';
import 'package:tool_nest/domain/models/pdf_tools/pdf_to_image_model/pdf_to_image_result_model.dart';
import 'pdf_to_image_event.dart';
import 'pdf_to_image_state.dart';

class PdfToImageBloc extends Bloc<PdfToImageEvent, PdfToImageState> {
  String? _pdfPath;
  int? _pageCount;

  PdfToImageBloc() : super(PdfInitial()) {
    on<PickPdfEvent>(_onPickPdf);
    on<ConvertPdfEvent>(_onConvertPdf);
    on<ResetPdfToImageEvent>(_onReset);
  }

  Future<void> _onPickPdf(PickPdfEvent event, Emitter<PdfToImageState> emit) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      final path = result?.files.single.path;
      if (path == null) {
        emit(PdfError("No PDF selected."));
        return;
      }

      final doc = await PdfDocument.openFile(path);
      _pageCount = doc.pagesCount;
      _pdfPath = path;
      await doc.close();

      emit(PdfPicked(path, _pageCount!));
    } catch (e) {
      emit(PdfError("Failed picking PDF: $e"));
    }
  }

  Future<void> _onConvertPdf(ConvertPdfEvent event, Emitter<PdfToImageState> emit) async {
    if (_pdfPath == null || _pageCount == null) {
      emit(PdfError("No PDF loaded."));
      return;
    }

    final start = event.startPage;
    final end = event.endPage;

    if (start < 1 || end > _pageCount! || start > end) {
      emit(PdfError("Invalid page range."));
      return;
    }

    emit(PdfConverting());
    try {
      final results = <PdfToImageResultModel>[];
      final document = await PdfDocument.openFile(_pdfPath!);

      for (int i = start; i <= end; i++) {
        final page = await document.getPage(i);
        final image = await page.render(
          width: page.width * 2,
          height: page.height * 2,
          format: PdfPageImageFormat.png,
          backgroundColor: '#FFFFFF',
        );

        results.add(PdfToImageResultModel(
          imageBytes: Uint8List.fromList(image!.bytes),
          pageNumber: i,
        ));

        await page.close();
      }

      await document.close();
      emit(PdfConverted(results));
    } catch (e) {
      emit(PdfError("Conversion failed: $e"));
    }
  }

  void _onReset(ResetPdfToImageEvent event, Emitter<PdfToImageState> emit) {
    _pdfPath = null;
    _pageCount = null;
    emit(PdfInitial());
  }
}
