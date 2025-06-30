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

  const ToolCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: TNPaddingStyle.allPaddingXS,
        decoration: BoxDecoration(
          color: TNColors.white,
          borderRadius: BorderRadius.circular(TNSizes.borderRadiusMD),
          boxShadow: [
            BoxShadow(
              color: TNColors.black.withOpacity(0.06),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: TNPaddingStyle.allPaddingSM,
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(TNSizes.borderRadiusSM),
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
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
          ],
        ),
      ),
    );
  }
}
