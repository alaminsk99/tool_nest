

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:toolest/core/constants/colors.dart';
import 'package:toolest/core/constants/sizes.dart';
import 'package:toolest/presentation/styles/spacing_style/padding_style.dart';

class ListTileForTools extends StatelessWidget {
  const ListTileForTools({super.key, required this.icon, required this.title, required this.subTitle, this.onPressed, this.iconColor});

  final IconData icon;
  final String title;
  final String subTitle;
  final VoidCallback? onPressed;
  final Color? iconColor;



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 90,
        decoration: BoxDecoration(
          color: iconColor?.withOpacity(0.05),
          borderRadius: BorderRadius.circular(TNSizes.borderRadiusMD),
          border: Border.all(color: iconColor!,width: 0.5 )
        ),
        padding: TNPaddingStyle.allPadding,

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Circular avater
            Container(
              padding:EdgeInsetsGeometry.all(8),
              decoration: BoxDecoration(
                color: iconColor,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Icon(icon, color: TNColors.white, size: TNSizes.iconSizeMD,),
            ),
            Gap(TNSizes.spaceMD),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleLarge,),
                  Gap(TNSizes.spaceXS),
                  Text(subTitle, style: Theme.of(context).textTheme.labelMedium,),
                ],
              ),
            ),
            Gap(TNSizes.spaceMD),
            Icon(LucideIcons.chevronRight, color: TNColors.darkGrey,size: 25,),
          ],
        ),
      ),
    );

  }
}
