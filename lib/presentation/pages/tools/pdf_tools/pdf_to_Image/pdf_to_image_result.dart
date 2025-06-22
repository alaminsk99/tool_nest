import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tool_nest/config/router/route_paths.dart';
import 'package:tool_nest/core/constants/colors.dart';
import 'package:tool_nest/core/constants/sizes.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/core/utils/file_services/file_services.dart';
import 'package:tool_nest/domain/models/pdf_tools/pdf_to_image_model/pdf_to_image_result_model.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/buttons/download_button.dart';
import 'package:tool_nest/presentation/widgets/appbar/main_section_appbar/appbar_for_main_sections.dart';
import 'package:tool_nest/presentation/styles/spacing_style/padding_style.dart';
import 'package:tool_nest/presentation/widgets/dialogs/custom_error_dialog.dart';

class PdfToImageResult extends StatelessWidget {
  final List<PdfToImageResultModel> results;
  const PdfToImageResult({super.key, required this.results});

  Future<void> _saveAllImages(BuildContext context) async {
    // Request permission
    final isPermissionGranted = await FileServices.requestStoragePermission();
    if (!isPermissionGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(TNTextStrings.storagePermissionDenied)),
      );
      return;
    }

    // Temporary directory for image files
    final dir = await getTemporaryDirectory();

    for (final item in results) {
      final file = File(
        '${dir.path}/${TNTextStrings.appNameDirectory}pdf_page_${item.pageNumber}.jpg',
      );

      await file.writeAsBytes(item.imageBytes);

      await FileServices.saveImageToGallery(
        context: context,
        imageFile: file,
        fileName: 'pdf_page_${item.pageNumber}',
      );
    }

    // Show success dialog
    DialogOptions().showModernSuccessDialog(context, TNTextStrings.save);

    // Navigate after slight delay
    await Future.delayed(const Duration(milliseconds: 300));
    context.pushNamed(AppRoutes.processFinishedForImgToPdf, extra: 'null');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarForMainSections(
        title: TNTextStrings.pdfToImageResult,
        isLeadingIcon: true,
      ),
      backgroundColor: TNColors.primaryBackground,
      body: SafeArea(
        child: Column(
          children: [
            // Image Viewer Section
            Expanded(
              child: Padding(
                padding: TNPaddingStyle.onlyBottomXXL,
                child: ListView.separated(
                  padding: TNPaddingStyle.allPadding,
                  itemCount: results.length,
                  separatorBuilder: (_, __) => const SizedBox(height: TNSizes.spaceLG),
                  itemBuilder: (ctx, i) => ClipRRect(
                    borderRadius: BorderRadius.circular(TNSizes.borderRadiusLG),
                    child: Image.memory(
                      results[i].imageBytes,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),

            // Bottom Download Panel
            Container(
              padding: TNPaddingStyle.allPaddingLG,
              decoration: BoxDecoration(
                color: TNColors.lightContainer,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(TNSizes.borderRadiusLG),
                  topRight: Radius.circular(TNSizes.borderRadiusLG),
                ),
                boxShadow: [
                  BoxShadow(
                    color: TNColors.black.withOpacity(0.05),
                    blurRadius: 15,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${results.length} Page(s) Converted',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: TNColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: TNSizes.spaceLG),
                  DownloadButton(onPressed: () => _saveAllImages(context)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
