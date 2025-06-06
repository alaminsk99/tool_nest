import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:tool_nest/core/constants/sizes.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/buttons/icon_with_outline_button.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/buttons/icon_with_process.dart';



class TwoActionButtons extends StatelessWidget {
  const TwoActionButtons({
    super.key,
    required this.title1,
    required this.icon1,
    this.onPressed1,
    required this.title2,
    required this.icon2,
    this.onPressed2,
  });

  final String title1;
  final IconData icon1;
  final VoidCallback? onPressed1;
  final String title2;
  final IconData icon2;
  final VoidCallback? onPressed2;


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: IconWithOutlineButton(icon: icon1, title: title1,onPressed: onPressed1,),
        ),
        const Gap(TNSizes.spaceSM),
        Expanded(
          child: IconWithProcess(title: title2, icon: icon2,onPressed: onPressed2,),
        ),
      ],
    );
  }
}