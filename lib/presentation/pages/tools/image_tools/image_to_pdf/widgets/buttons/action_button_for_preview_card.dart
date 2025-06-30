

import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:toolest/core/constants/text_strings.dart';
import 'package:toolest/presentation/pages/tools/widgets/buttons/button_with_style/two_action_buttons.dart';

class ActionButtonForPreviewCard extends StatelessWidget {
  const ActionButtonForPreviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return TwoActionButtons(title1: TNTextStrings.back, icon1: LucideIcons.arrowLeft, title2: TNTextStrings.processFile, icon2: LucideIcons.files);
  }
}
