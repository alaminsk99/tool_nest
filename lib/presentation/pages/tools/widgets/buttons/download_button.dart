import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:tool_nest/core/constants/colors.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/buttons/icon_with_outline_button_with_bacground_color.dart';


class DownloadButton extends StatelessWidget {
  const DownloadButton({super.key, required this.onPressed});
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return IconWithOutlineButtonWithBackgroundColor(icon: LucideIcons.fileDown, title: TNTextStrings.save, onPressed: onPressed,color: TNColors.materialPrimaryColor[400],);
  }
}
