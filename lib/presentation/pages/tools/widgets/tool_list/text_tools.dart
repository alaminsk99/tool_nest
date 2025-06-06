

import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:tool_nest/core/constants/text_strings.dart';

import '../list_tile/list_tile_for_tools.dart';

class TextTools extends StatelessWidget {
  const TextTools({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
      ],
    );
  }
}
