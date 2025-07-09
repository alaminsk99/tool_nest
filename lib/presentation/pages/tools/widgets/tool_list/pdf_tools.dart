
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:toolest/config/router/route_paths.dart';
import 'package:toolest/core/constants/colors.dart';
import 'package:toolest/core/constants/sizes.dart';
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
          iconColor: TNColors.specialPurpleColor,
        ),
        Gap(TNSizes.spaceBetweenItems),
        ListTileForTools(
          icon: LucideIcons.merge,
          title: TNTextStrings.mergePDFs,
          subTitle: TNTextStrings.mergePDFsSubTitle,
          onPressed: ()=> context.goNamed(AppRoutes.mergePdf),
          iconColor: TNColors.specialGreenColor,
        ),
        Gap(TNSizes.spaceBetweenItems),
        ListTileForTools(
          icon: LucideIcons.split,
          title: TNTextStrings.splitPDF,
          subTitle: TNTextStrings.splitPDFSubTitle,
          onPressed: ()=> context.goNamed(AppRoutes.splitPdf),
          iconColor: TNColors.specialBlueColor,
        ),
        Gap(TNSizes.spaceBetweenItems),
        ListTileForTools(
          icon: LucideIcons.fileAxis3d,
          title: TNTextStrings.compressPDF,
          subTitle: TNTextStrings.compressPDFSubTitle,
          onPressed: ()=> context.goNamed(AppRoutes.compressPdf),
          iconColor: TNColors.specialBrunColor,
        ),
      ],
    );
  }
}
