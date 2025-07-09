import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:toolest/core/constants/colors.dart';
import 'package:toolest/core/constants/sizes.dart';
import 'package:toolest/presentation/styles/spacing_style/padding_style.dart';

class ToolCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final String? subtitle;

  const ToolCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap, this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 130,
        width: 100,
        padding: TNPaddingStyle.allPaddingXS,
        decoration: BoxDecoration(
          color: color.withOpacity(0.02),
          borderRadius: BorderRadius.circular(TNSizes.borderRadiusMD),
          border: Border.all(color: color,width: 0.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: TNPaddingStyle.allPaddingSM,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(TNSizes.borderRadiusSM),
              ),
              child: Icon(
                icon,
                color: TNColors.white,
                size: TNSizes.iconSizeMD,
              ),
            ),
            Gap(TNSizes.spaceBetweenItems),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: TNColors.textPrimary,
              ),
            ),
            Gap(TNSizes.spaceXS),
            if(subtitle !=null)Text(subtitle!,style: Theme.of(context).textTheme.labelMedium?.copyWith(color: TNColors.textSecondary),textAlign: TextAlign.center,),
          ],
        ),
      ),
    );
  }
}
