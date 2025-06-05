import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:tool_nest/core/constants/sizes.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/buttons/icon_with_outline_button.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/buttons/icon_with_process.dart';



class ActionButtons extends StatelessWidget {
  const ActionButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: IconWithOutlineButton(icon: LucideIcons.arrowLeft, title: TNTextStrings.back),
        ),
        const Gap(TNSizes.spaceSM),
        Expanded(
          child: IconWithProcess(title: TNTextStrings.processFile, icon: LucideIcons.files),
          //IconWithProcess(title: TNTextStrings.processFile, icon: LucideIcons.files),
        ),
      ],
    );
  }
}