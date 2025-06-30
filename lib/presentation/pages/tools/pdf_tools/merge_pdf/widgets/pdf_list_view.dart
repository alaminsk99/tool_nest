import 'dart:io';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:toolest/domain/models/pdf_tools/pdf_merge_model/pdf_file_model.dart';






class PdfListView extends StatelessWidget {
  final List<PdfFileModel> files;
  const PdfListView({required this.files, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: files.length,
      itemBuilder: (_, i) {
        final f = files[i];
        return ExpansionTile(
          title: Text(f.name),
          children: [
            SizedBox(
              width: double.infinity,
              height: 200,
              child: SfPdfViewer.file(f.file),
            ),
          ],
        );
      },
    );
  }
}
