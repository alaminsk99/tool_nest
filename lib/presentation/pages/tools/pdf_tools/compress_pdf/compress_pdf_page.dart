import 'package:flutter/material.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/container/upload_image_container.dart';
import 'package:tool_nest/presentation/widgets/appbar/main_section_appbar/appbar_for_main_sections.dart';


class CompressPdfPage extends StatelessWidget {
  const CompressPdfPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarForMainSections(title: TNTextStrings.compressPDF,isLeadingIcon: true,),
      body: SafeArea(
        child: Stack(
          children: [

            // --- Here is Upload Button then show the pdf
            UploadContainerForItem(
              title: TNTextStrings.uploadFiles,
              subTitle: TNTextStrings.compressPDFSubTitle,
              onPressed: () {},
            ),
            // --- Show the pdf if possible
            // --- Process Button for Goto Image to SplitPdfSettings
          ],
        ),
      ),
    );
  }
}
