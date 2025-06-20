
import 'package:flutter/material.dart';
import 'package:tool_nest/core/constants/sizes.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/buttons/download_button.dart';
import 'package:tool_nest/presentation/widgets/appbar/main_section_appbar/appbar_for_main_sections.dart';










class CompressPdfResult extends StatelessWidget {
  const CompressPdfResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarForMainSections(title: TNTextStrings.compressPdfResult, isLeadingIcon: true),
      body: SafeArea(
        child: Stack(
          children: [
            // --- Show the compressed pdf

            // --- Download File
            Positioned(
              bottom: TNSizes.spaceMD,
              left: TNSizes.spaceMD,
              right: TNSizes.spaceMD,
              child: DownloadButton( onPressed: (){},),
            ),

          ],
        ),
      ),
    );
  }
}
