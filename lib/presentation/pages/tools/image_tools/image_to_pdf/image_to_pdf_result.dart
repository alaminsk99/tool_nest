import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tool_nest/core/constants/sizes.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/presentation/pages/tools/image_tools/image_to_pdf/widgets/buttons/action_button_for_img_to_pdf_result.dart';
import 'package:tool_nest/presentation/widgets/appbar/main_section_appbar/appbar_for_main_sections.dart';

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ImageToPdfResultScreen extends StatelessWidget {
  final String pdfPath;

  const ImageToPdfResultScreen({super.key, required this.pdfPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarForMainSections(
        title: TNTextStrings.resultPDFScreen,
        isLeadingIcon: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(TNSizes.spaceMD),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Heading
            Text(
              TNTextStrings.generatedPDF,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const Gap(TNSizes.spaceMD),

            /// PDF Viewer replacing ResultCard
            Expanded(
              child: SfPdfViewer.file(
                                File(pdfPath),
              ),
            ),

            const Gap(TNSizes.spaceXL),

            /// Action Buttons
            ActionButtonForImgToPdfResult(pdfPath: pdfPath),
          ],
        ),
      ),
    );
  }
}
