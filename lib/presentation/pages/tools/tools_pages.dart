import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:tool_nest/core/constants/sizes.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/tool_list/image_tools.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/tool_list/pdf_tools.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/tool_list/text_tools.dart';
import 'package:tool_nest/presentation/styles/spacing_style/padding_style.dart';
import 'package:tool_nest/presentation/widgets/appbar/main_section_appbar/appbar_for_main_sections.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/list_tile/list_tile_for_tools.dart';
import 'package:tool_nest/presentation/widgets/section_style/section_style.dart';

import 'image_tools/image_tools_page.dart';

class ToolsPages extends StatelessWidget {
  const ToolsPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarForMainSections(title: TNTextStrings.toolScreenName,isLeadingIcon: false,),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: TNPaddingStyle.allPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// 🖼 Image Tools Section
              const ToolSectionHeader(title: TNTextStrings.imageTools),
              Gap(TNSizes.spaceMD),
              ImageTools(),
              Gap(TNSizes.spaceXL),

              /// 📄 PDF Tools Section
              const ToolSectionHeader(title: TNTextStrings.pdfTools),
              Gap(TNSizes.spaceMD),
              PdfTools(),

              Gap(TNSizes.spaceXL),

              /// 🔤 Text Tools Section
              const ToolSectionHeader(title: "Text Tools"),
              Gap(TNSizes.spaceMD),
              TextTools(),
              Gap(TNSizes.spaceXS),
            ],
          ),
        ),
      ),
    );
  }
}
