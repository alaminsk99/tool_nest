import 'dart:io';
import 'dart:ui';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:tool_nest/domain/models/pdf_tools/pdf_merge_model/pdf_file_model.dart';



class PdfService {


  Future<File> mergePdfs(List<PdfFileModel> files) async {
    if (files.isEmpty) throw Exception("No PDF files to merge.");

    final PdfDocument output = PdfDocument();

    for (final f in files) {
      final bytes = await f.file.readAsBytes();
      final PdfDocument doc = PdfDocument(inputBytes: bytes);

      for (int i = 0; i < doc.pages.count; i++) {
        final originalPage = doc.pages[i];

        // Create a template from the original page
        final template = originalPage.createTemplate();

        // Create a new page with the same size as the original
        final settings = PdfPageSettings();
        settings.size = Size(
          originalPage.size.width,
          originalPage.size.height,
        );

        // Set page settings before adding
        output.pageSettings = settings;
        final newPage = output.pages.add();

        // Draw the template to avoid cropping
        newPage.graphics.drawPdfTemplate(template, const Offset(0, 0));
      }

      doc.dispose();
    }

    final bytes = await output.save();
    output.dispose();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/merged_${DateTime.now().millisecondsSinceEpoch}.pdf');
    await file.writeAsBytes(bytes);

    return file;
  }
  Future<List<File>> splitPdf(File pdfFile, List<int> selectedPages) async {
    final originalBytes = await pdfFile.readAsBytes();
    final PdfDocument originalDocument = PdfDocument(inputBytes: originalBytes);

    final outputFiles = <File>[];
    final tempDir = await getTemporaryDirectory();

    for (int pageIndex in selectedPages) {
      if (pageIndex <= 0 || pageIndex > originalDocument.pages.count) continue;

      final PdfDocument newDoc = PdfDocument();
      final page = originalDocument.pages[pageIndex - 1];

      final template = page.createTemplate();
      final settings = PdfPageSettings();
      settings.size = Size(page.size.width, page.size.height);
      newDoc.pageSettings = settings;

      final newPage = newDoc.pages.add();
      newPage.graphics.drawPdfTemplate(template, Offset.zero);

      final bytes = await newDoc.save();
      newDoc.dispose();

      final filePath = '${tempDir.path}/split_page_$pageIndex.pdf';
      final file = File(filePath);
      await file.writeAsBytes(bytes, flush: true); // Ensure file is flushed to disk
      outputFiles.add(file);
    }

    originalDocument.dispose();
    return outputFiles;
  }





}
