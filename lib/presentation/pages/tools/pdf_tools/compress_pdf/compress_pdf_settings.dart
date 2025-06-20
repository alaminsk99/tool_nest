import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:tool_nest/core/constants/sizes.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/buttons/icon_with_process.dart';
import 'package:tool_nest/presentation/widgets/appbar/main_section_appbar/appbar_for_main_sections.dart';








class CompressPdfSettings extends StatelessWidget {
  const CompressPdfSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarForMainSections(title: TNTextStrings.compressPdfSettings, isLeadingIcon: true),

      body: SafeArea(
        child: Stack(
          children: [
            // --- Settings If any


            Positioned(
              bottom: TNSizes.spaceMD,
              left: TNSizes.spaceMD,
              right: TNSizes.spaceMD,
              child: IconWithProcess(title: TNTextStrings.splitPDF, icon: LucideIcons.code,onPressed: (){},),
            ),

          ],
        ),
      ),
    );
  }
}
