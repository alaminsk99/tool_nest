import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:tool_nest/core/constants/sizes.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/presentation/styles/spacing_style/padding_style.dart';
import 'package:tool_nest/presentation/widgets/appbar/main_section_appbar/appbar_for_main_sections.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/list_tile/list_tile_for_tools.dart';
import 'package:tool_nest/presentation/widgets/section_style/section_style.dart';

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
              ListTileForTools(
                icon: LucideIcons.image,
                title: TNTextStrings.compressImage,
                subTitle: TNTextStrings.compressImageSubTitle,
              ),
              ListTileForTools(
                icon: LucideIcons.minimize,
                title: TNTextStrings.imageResizer,
                subTitle: TNTextStrings.imageResizerSubTitle,
              ),
              ListTileForTools(
                icon: LucideIcons.fileImage,
                title: TNTextStrings.imageToPDF,
                subTitle: TNTextStrings.imageToPDFSubTitle,
              ),
              ListTileForTools(
                icon: LucideIcons.repeat,
                title: TNTextStrings.formatConverter,
                subTitle: TNTextStrings.formatConverterSubTitle,
              ),
              ListTileForTools(
                icon: LucideIcons.rotateCcw,
                title: TNTextStrings.imageRotator,
                subTitle: TNTextStrings.imageRotatorSubTitle,
              ),

              Gap(TNSizes.spaceXL),

              /// 📄 PDF Tools Section
              const ToolSectionHeader(title: TNTextStrings.pdfTools),
              Gap(TNSizes.spaceMD),
              ListTileForTools(
                icon: LucideIcons.fileImage,
                title: TNTextStrings.pdfToImage,
                subTitle: TNTextStrings.pdfToImageSubTitle,
              ),
              ListTileForTools(
                icon: LucideIcons.merge,
                title: TNTextStrings.mergePDFs,
                subTitle: TNTextStrings.mergePDFsSubTitle,
              ),
              ListTileForTools(
                icon: LucideIcons.split,
                title: TNTextStrings.splitPDF,
                subTitle: TNTextStrings.splitPDFSubTitle,
              ),
              ListTileForTools(
                icon: LucideIcons.fileAxis3d,
                title: TNTextStrings.compressPDF,
                subTitle: TNTextStrings.compressPDFSubTitle,
              ),

              Gap(TNSizes.spaceXL),

              /// 🔤 Text Tools Section
              const ToolSectionHeader(title: "Text Tools"),
              Gap(TNSizes.spaceMD),
              ListTileForTools(
                icon: LucideIcons.scanText,
                title: TNTextStrings.textExtractor,
                subTitle: TNTextStrings.textExtractorSubTitle,
              ),
              ListTileForTools(
                icon: LucideIcons.alignJustify,
                title: TNTextStrings.textSummarizer,
                subTitle: TNTextStrings.textSummarizerSubTitle,
              ),
              Gap(TNSizes.spaceXS),
            ],
          ),
        ),
      ),
    );
  }
}
