import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
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
          onPressed: (){},
        ),
        ListTileForTools(
          icon: LucideIcons.minimize,
          title: TNTextStrings.imageResizer,
          subTitle: TNTextStrings.imageResizerSubTitle,
          onPressed: (){},
        ),
        ListTileForTools(
          icon: LucideIcons.fileImage,
          title: TNTextStrings.imageToPDF,
          subTitle: TNTextStrings.imageToPDFSubTitle,
          onPressed: (){},
        ),
        ListTileForTools(
          icon: LucideIcons.repeat,
          title: TNTextStrings.formatConverter,
          subTitle: TNTextStrings.formatConverterSubTitle,
          onPressed: (){},
        ),
        ListTileForTools(
          icon: LucideIcons.rotateCcw,
          title: TNTextStrings.imageRotator,
          subTitle: TNTextStrings.imageRotatorSubTitle,
          onPressed: (){},
        ),
      ],
    );
  }
}
