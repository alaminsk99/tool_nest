import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:toolest/config/router/route_paths.dart';
import 'package:toolest/core/constants/colors.dart';
import 'package:toolest/core/constants/sizes.dart';
import 'package:toolest/core/constants/text_strings.dart';
import 'package:toolest/presentation/pages/tools/widgets/list_tile/list_tile_for_tools.dart';

class ImageTools extends StatelessWidget {
  const ImageTools({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTileForTools(
          icon: LucideIcons.image,
          title: TNTextStrings.compressImage,
          subTitle: TNTextStrings.compressImageSubTitle,
          onPressed: () => context.goNamed(AppRoutes.imageCompressor),
          iconColor: TNColors.specialBlueColor,
        ),
        Gap(TNSizes.spaceBetweenItems),
        ListTileForTools(
          icon: LucideIcons.minimize,
          title: TNTextStrings.imageResizer,
          subTitle: TNTextStrings.imageResizerSubTitle,
          onPressed: () => context.goNamed(AppRoutes.imageResize),
          iconColor: TNColors.specialGreenColor,
        ),
        Gap(TNSizes.spaceBetweenItems),
        ListTileForTools(
          icon: LucideIcons.fileImage,
          title: TNTextStrings.imageToPDF,
          subTitle: TNTextStrings.imageToPDFSubTitle,
          onPressed: () => context.goNamed(AppRoutes.imageToPdf),
          iconColor: TNColors.specialBrunColor,
        ),
        Gap(TNSizes.spaceBetweenItems),
        ListTileForTools(
          icon: LucideIcons.repeat,
          title: TNTextStrings.formatConverter,
          subTitle: TNTextStrings.formatConverterSubTitle,
          onPressed: () => context.goNamed(AppRoutes.imageFormatConverter),
          iconColor: TNColors.info,
        ),

      ],
    );
  }
}

