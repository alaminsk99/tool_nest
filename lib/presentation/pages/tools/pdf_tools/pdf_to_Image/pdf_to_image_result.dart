import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tool_nest/config/router/route_paths.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/core/utils/file_services/file_services.dart';
import 'package:tool_nest/domain/models/pdf_tools/pdf_to_image_model/pdf_to_image_result_model.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/buttons/download_button.dart';
import 'package:tool_nest/presentation/widgets/appbar/main_section_appbar/appbar_for_main_sections.dart';

class PdfToImageResult extends StatelessWidget {
  final List<PdfToImageResultModel> results;

  const PdfToImageResult({super.key, required this.results});

  Future<void> _saveAllImages(BuildContext context) async {
    final status = await Permission.storage.request();
    if (!status.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Storage permission denied")),
      );
      return;
    }

    final dir = await getTemporaryDirectory();

    for (final item in results) {
      final file = File('${dir.path}/pdf_page_${item.pageNumber}.jpg');
      await file.writeAsBytes(item.imageBytes);

      await FileServices.saveImageToGallery(
        context: context,
        imageFile: file,
      );
       // optional delay
    }

    // ScaffoldMessenger.of(context).showSnackBar(
    //   const SnackBar(content: Text("All images saved to gallery")),
    // );
    await Future.delayed(const Duration(milliseconds: 200));

    context.pushNamed(AppRoutes.processFinishedForImgToPdf, extra: 'null');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarForMainSections(
        title: TNTextStrings.pdfToImageResult,
        isLeadingIcon: true,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 80),
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: results.length,
              itemBuilder: (ctx, i) => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.memory(results[i].imageBytes),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: DownloadButton(
              onPressed: () => _saveAllImages(context),
            ),
          ),
        ],
      ),
    );
  }
}
