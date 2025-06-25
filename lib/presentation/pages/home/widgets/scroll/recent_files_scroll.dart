import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:tool_nest/core/constants/colors.dart';
import 'package:tool_nest/core/constants/sizes.dart';
import 'package:tool_nest/presentation/styles/spacing_style/padding_style.dart';

class RecentFilesScroll extends StatelessWidget {
  const RecentFilesScroll({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: 5,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) => const RecentFileCard(),
      ),
    );
  }
}

class RecentFileCard extends StatelessWidget {
  const RecentFileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 110,
          height: 130,
          padding: TNPaddingStyle.allPaddingXS,
          decoration: BoxDecoration(
            color: TNColors.white,
            borderRadius: BorderRadius.circular(TNSizes.borderRadiusMD),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 1,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Center(
            child: Icon(
              LucideIcons.fileText,
              color: TNColors.primary,
              size: TNSizes.iconSizeMDForBottoms,
            ),
          ),
        ),
        const Gap(TNSizes.spaceSM),
        SizedBox(
          width: 100,
          child: Text(
            "Document.pdf",
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: TNColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
