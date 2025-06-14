import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:tool_nest/config/router/route_paths.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/list_tile/list_tile_for_tools.dart';

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
        ),
        ListTileForTools(
          icon: LucideIcons.minimize,
          title: TNTextStrings.imageResizer,
          subTitle: TNTextStrings.imageResizerSubTitle,
          onPressed: () => context.goNamed(AppRoutes.imageResize),
        ),
        ListTileForTools(
          icon: LucideIcons.fileImage,
          title: TNTextStrings.imageToPDF,
          subTitle: TNTextStrings.imageToPDFSubTitle,
          onPressed: () => context.goNamed(AppRoutes.imageToPdf),
        ),
        ListTileForTools(
          icon: LucideIcons.repeat,
          title: TNTextStrings.formatConverter,
          subTitle: TNTextStrings.formatConverterSubTitle,
          onPressed: () {}, // Placeholder
        ),
        ListTileForTools(
          icon: LucideIcons.rotateCcw,
          title: TNTextStrings.imageRotator,
          subTitle: TNTextStrings.imageRotatorSubTitle,
          onPressed: () {}, // Placeholder
        ),
      ],
    );
  }
}

