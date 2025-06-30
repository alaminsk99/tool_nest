import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:toolest/core/constants/colors.dart';
import 'package:toolest/core/constants/sizes.dart';
import 'package:toolest/core/constants/text_strings.dart';
import 'package:toolest/presentation/pages/tools/image_tools/image_to_pdf/widgets/buttons/action_button_for_img_to_pdf_result.dart';
import 'package:toolest/presentation/styles/spacing_style/padding_style.dart';
import 'package:toolest/presentation/widgets/appbar/main_section_appbar/appbar_for_main_sections.dart';

class ImageToPdfResultScreen extends StatelessWidget {
  final String pdfPath;

  const ImageToPdfResultScreen({super.key, required this.pdfPath});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppbarForMainSections(
        title: TNTextStrings.resultPDFScreen,
        isLeadingIcon: true,
      ),
      backgroundColor: TNColors.primaryBackground,
      body: SafeArea(
        child: Padding(
          padding: TNPaddingStyle.allPaddingLG,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title
              Text(
                TNTextStrings.generatedPDF,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: TNColors.textPrimary,
                ),
              ),
              const Gap(TNSizes.spaceSM),
              Text(
                TNTextStrings.viewYourCreatedPdf,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: TNColors.textSecondary,
                ),
              ),

              const Gap(TNSizes.spaceXL),

              /// PDF Viewer
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(TNSizes.borderRadiusLG),
                  child: Container(
                    decoration: BoxDecoration(
                      color: TNColors.white,
                      boxShadow: [
                        BoxShadow(
                          color: TNColors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        )
                      ],
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: TNColors.borderPrimary, width: 1.2),
                        borderRadius: BorderRadius.circular(TNSizes.borderRadiusLG),
                      ),
                      child: SfPdfViewer.file(File(pdfPath)),
                    ),
                  ),
                ),

              ),

              const Gap(TNSizes.spaceXL),

              /// Action Buttons (Share / Save / Home etc.)
              ActionButtonForImgToPdfResult(pdfPath: pdfPath),
            ],
          ),
        ),
      ),
    );
  }
}
