
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/buttons/button_with_style/two_action_buttons.dart';

class ActionButtonForShareAndDownload extends StatelessWidget {
  const ActionButtonForShareAndDownload({super.key, required this.filePath});
  final String filePath;
  @override
  Widget build(BuildContext context) {
    return TwoActionButtons(
        title1: TNTextStrings.share,
        icon1: LucideIcons.share2,
        title2: TNTextStrings.save,
        icon2: LucideIcons.fileDown,
        onPressed2: (){},
        onPressed1: (){},
    );
  }
}
