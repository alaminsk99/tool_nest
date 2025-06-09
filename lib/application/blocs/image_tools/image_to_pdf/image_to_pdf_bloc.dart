import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/core/utils/file_core_helper/file_core_helper.dart';
import 'image_to_pdf_event.dart';
import 'image_to_pdf_state.dart';
import 'package:pdf/pdf.dart' as pdf;
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';

class ImageToPdfBloc extends Bloc<ImageToPdfEvent, ImageToPdfState> {
  ImageToPdfBloc() : super(ImageToPdfInitial()) {
    on<SelectImagesEvent>(_onSelectImages);
    on<UpdateSettingsEvent>(_onUpdateSettings);
    on<ToggleMarginTypeEvent>(_onToggleMarginType);
    on<UpdateMarginValueEvent>(_onUpdateMarginValue);
    on<ConvertToPdfEvent>(_onConvertToPdf);
    on<ClearSelectedImagesEvent>(_onClearSelectedImages);
  }

  Future<void> _onSelectImages(SelectImagesEvent event, Emitter emit) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png'],
        allowMultiple: true,
      );

      if (result != null && result.files.isNotEmpty) {
        final selectedImages = result.paths.map((path) => File(path!)).toList();
        emit(ImageSelectionSuccess(
          selectedImages: selectedImages,
          pageSize: state.pageSize,
          orientation: state.orientation,
          margin: state.margin,
          isCustomMargin: state.isCustomMargin,
        ));
      } else {
        emit(ImageToPdfError(
          selectedImages: state.selectedImages,
          pageSize: state.pageSize,
          orientation: state.orientation,
          margin: state.margin,
          isCustomMargin: state.isCustomMargin,
          message: TNTextStrings.noImageSelected,
        ));
      }
    } catch (e) {
      emit(ImageToPdfError(
        selectedImages: state.selectedImages,
        pageSize: state.pageSize,
        orientation: state.orientation,
        margin: state.margin,
        isCustomMargin: state.isCustomMargin,
        message: '${TNTextStrings.errorPickingImages}: ${e.toString()}',
      ));
    }
  }

  void _onUpdateSettings(UpdateSettingsEvent event, Emitter emit) {
    emit(SettingsUpdated(
      selectedImages: state.selectedImages,
      pageSize: event.pageSize,
      orientation: event.orientation,
      margin: event.margin,
      isCustomMargin: event.isCustomMargin,
    ));
  }

  void _onToggleMarginType(ToggleMarginTypeEvent event, Emitter emit) {
    emit(SettingsUpdated(
      selectedImages: state.selectedImages,
      pageSize: state.pageSize,
      orientation: state.orientation,
      margin: state.margin,
      isCustomMargin: event.isCustom,
    ));
  }

  void _onUpdateMarginValue(UpdateMarginValueEvent event, Emitter emit) {
    emit(SettingsUpdated(
      selectedImages: state.selectedImages,
      pageSize: state.pageSize,
      orientation: state.orientation,
      margin: event.margin,
      isCustomMargin: state.isCustomMargin,
    ));
  }

  void _onClearSelectedImages(ClearSelectedImagesEvent event, Emitter emit) {
    emit(ImageToPdfInitial());
  }

  Future<void> _onConvertToPdf(ConvertToPdfEvent event, Emitter emit) async {
    emit(PdfConversionInProgress(
      selectedImages: state.selectedImages,
      pageSize: state.pageSize,
      orientation: state.orientation,
      margin: state.margin,
      isCustomMargin: state.isCustomMargin,
    ));

    try {
      final doc = pw.Document();

      for (var image in state.selectedImages) {
        final imageBytes = await image.readAsBytes();
        final compressed = await FlutterImageCompress.compressWithList(imageBytes);
        final pdfImage = pw.MemoryImage(compressed);

        late pdf.PdfPageFormat pageFormat;
        if (state.pageSize == 'Original') {
          final decodedImage = await decodeImageFromList(compressed);
          pageFormat = pdf.PdfPageFormat(
            decodedImage.width.toDouble(),
            decodedImage.height.toDouble(),
          );
        } else {
          pageFormat = _getPageFormat(state.pageSize, state.orientation);
        }

        doc.addPage(
          pw.Page(
            pageFormat: pageFormat,
            margin: pw.EdgeInsets.all(state.pageSize == 'Original' ? 0 : state.margin),
            build: (context) => pw.Container(
              color: PdfColors.white,
              alignment: pw.Alignment.center,
              child: pw.Image(
                pdfImage,
                fit: state.pageSize == 'Original' ? pw.BoxFit.fill : pw.BoxFit.contain,
              ),
            ),
          ),
        );
      }

      final dir = await getTemporaryDirectory();
      final formattedDate = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
      final pdfPath = '${dir.path}/${TNTextStrings.converted}$formattedDate.pdf';
      final file = File(pdfPath);
      await file.writeAsBytes(await doc.save());

      emit(PdfConversionSuccess(
        selectedImages: state.selectedImages,
        pageSize: state.pageSize,
        orientation: state.orientation,
        margin: state.margin,
        isCustomMargin: state.isCustomMargin,
        pdfPath: pdfPath,
      ));
    } catch (e) {
      emit(ImageToPdfError(
        selectedImages: state.selectedImages,
        pageSize: state.pageSize,
        orientation: state.orientation,
        margin: state.margin,
        isCustomMargin: state.isCustomMargin,
        message: '${TNTextStrings.pdfConvFailed}: ${e.toString()}',
      ));
    }
  }

  pdf.PdfPageFormat _getPageFormat(String size, String orientation) {
    pdf.PdfPageFormat format;

    switch (size) {
      case 'Letter':
        format = pdf.PdfPageFormat.letter;
        break;
      case 'Legal':
        format = pdf.PdfPageFormat.legal;
        break;
      default:
        format = pdf.PdfPageFormat.a4;
    }

    return orientation == 'Landscape' ? format.landscape : format;
  }
}
