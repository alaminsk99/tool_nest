

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:tool_nest/core/constants/sizes.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/buttons/button_with_style/two_action_buttons.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/buttons/icon_with_filled_button.dart';

class ActionButtonForImgToPdfResult extends StatelessWidget {
  const ActionButtonForImgToPdfResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TwoActionButtons(title1: TNTextStrings.open, icon1: LucideIcons.externalLink, title2: TNTextStrings.save, icon2: LucideIcons.save,onPressed1: (){},onPressed2: (){},),
        const Gap(TNSizes.spaceSM),
        IconWithFilledButton( icon: LucideIcons.share2, title: TNTextStrings.share)
      ],
    );
  }
}
