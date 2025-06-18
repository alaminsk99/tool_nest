import 'dart:typed_data';
import 'dart:io';
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
    on<ResetPdfToImageEvent>((event, emit) {
      _pdfPath = null;
      _pageCount = null;
      emit(PdfInitial());
    });
  }

  Future<void> _onPickPdf(PickPdfEvent event, Emitter<PdfToImageState> emit) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      if (result?.files.single.path != null) {
        _pdfPath = result!.files.single.path!;
        final doc = await PdfDocument.openFile(_pdfPath!);
        _pageCount = doc.pagesCount;
        await doc.close();
        emit(PdfPicked(_pdfPath!, _pageCount!));
      } else {
        emit(PdfError("No PDF selected."));
      }
    } catch (e) {
      emit(PdfError("Failed picking PDF: $e"));
    }
  }

  Future<void> _onConvertPdf(ConvertPdfEvent event, Emitter<PdfToImageState> emit) async {
    if (_pdfPath == null || _pageCount == null) {
      emit(PdfError("No PDF loaded."));
      return;
    }

    if (event.startPage < 1 || event.endPage > _pageCount! || event.startPage > event.endPage) {
      emit(PdfError("Invalid page range."));
      return;
    }

    emit(PdfConverting());
    try {
      final results = <PdfToImageResultModel>[];
      final document = await PdfDocument.openFile(_pdfPath!);

      for (int i = event.startPage; i <= event.endPage; i++) {
        final page = await document.getPage(i);
        final pageImage = await page.render(
          width: page.width,
          height: page.height,
          format: PdfPageImageFormat.png,
        );

        results.add(PdfToImageResultModel(
          imageBytes: Uint8List.fromList(pageImage!.bytes),
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
}
