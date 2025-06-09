import 'package:flutter/material.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/presentation/pages/tools/image_tools/image_compressor/widgets/buttons/action_button_for_compress_image.dart';
import 'package:tool_nest/presentation/styles/spacing_style/padding_style.dart';
import 'package:tool_nest/presentation/widgets/appbar/main_section_appbar/appbar_for_main_sections.dart';


class ImageCompressResult extends StatelessWidget {
  const ImageCompressResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarForMainSections(title: TNTextStrings.compressionResult, isLeadingIcon: true),
      body: SafeArea(
        child: Padding(
          padding: TNPaddingStyle.allPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Here is Preview Option in


              // Here is buttons for Share the compressed image to other apps and Save button for saved the image
              // ActionButtonForShareAndDownload(filePath: null),
            ],
          ),
        ),
      ),
    );
  }
}
