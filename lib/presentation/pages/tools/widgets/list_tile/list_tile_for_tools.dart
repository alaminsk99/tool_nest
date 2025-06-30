

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:toolest/core/constants/colors.dart';
import 'package:toolest/core/constants/sizes.dart';
import 'package:toolest/presentation/styles/spacing_style/padding_style.dart';

class ListTileForTools extends StatelessWidget {
  const ListTileForTools({super.key, required this.icon, required this.title, required this.subTitle, this.onPressed});

  final IconData icon;
  final String title;
  final String subTitle;
  final VoidCallback? onPressed;



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: TNPaddingStyle.onlyVerticalSMPadding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Circular avater
            CircleAvatar(
              backgroundColor: TNColors.borderSecondary,
              child: Icon(icon, color: TNColors.primary),
            ),
            Gap(TNSizes.spaceMD),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.bodyLarge,overflow: TextOverflow.ellipsis,),
                  Gap(TNSizes.spaceXS),
                  Text(subTitle, style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
          ],
        ),
      ),
    );

  }
}
