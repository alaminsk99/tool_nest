
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/list_tile/list_tile_for_tools.dart';

class PdfTools extends StatelessWidget {
  const PdfTools({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTileForTools(
          icon: LucideIcons.fileImage,
          title: TNTextStrings.pdfToImage,
          subTitle: TNTextStrings.pdfToImageSubTitle,
          onPressed: (){},
        ),
        ListTileForTools(
          icon: LucideIcons.merge,
          title: TNTextStrings.mergePDFs,
          subTitle: TNTextStrings.mergePDFsSubTitle,
          onPressed: (){},
        ),
        ListTileForTools(
          icon: LucideIcons.split,
          title: TNTextStrings.splitPDF,
          subTitle: TNTextStrings.splitPDFSubTitle,
          onPressed: (){},
        ),
        ListTileForTools(
          icon: LucideIcons.fileAxis3d,
          title: TNTextStrings.compressPDF,
          subTitle: TNTextStrings.compressPDFSubTitle,
          onPressed: (){},
        ),
      ],
    );
  }
}
