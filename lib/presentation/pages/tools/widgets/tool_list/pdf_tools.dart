
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:toolest/config/router/route_paths.dart';
import 'package:toolest/core/constants/text_strings.dart';
import 'package:toolest/presentation/pages/tools/widgets/list_tile/list_tile_for_tools.dart';

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
          onPressed: ()=> context.goNamed(AppRoutes.pdfToImage),
        ),
        ListTileForTools(
          icon: LucideIcons.merge,
          title: TNTextStrings.mergePDFs,
          subTitle: TNTextStrings.mergePDFsSubTitle,
          onPressed: ()=> context.goNamed(AppRoutes.mergePdf),
        ),
        ListTileForTools(
          icon: LucideIcons.split,
          title: TNTextStrings.splitPDF,
          subTitle: TNTextStrings.splitPDFSubTitle,
          onPressed: ()=> context.goNamed(AppRoutes.splitPdf),
        ),
        ListTileForTools(
          icon: LucideIcons.fileAxis3d,
          title: TNTextStrings.compressPDF,
          subTitle: TNTextStrings.compressPDFSubTitle,
          onPressed: ()=> context.goNamed(AppRoutes.compressPdf),
        ),
      ],
    );
  }
}
