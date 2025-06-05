import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:tool_nest/core/constants/colors.dart';
import 'package:tool_nest/core/constants/sizes.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
class PreviewCard extends StatelessWidget {
  const PreviewCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: TNColors.lightContainer,
          borderRadius: BorderRadius.circular(TNSizes.borderRadiusLG),
          boxShadow: [
            BoxShadow(
              color: TNColors.black.withOpacity(0.05),
              blurRadius: 3,
              offset: const Offset(0, 1),
            )
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(LucideIcons.files, size: 64, color: TNColors.primary),
              const Gap(12),
              Text(
                TNTextStrings.pDFPreviewAppearHere,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const Gap(4),
              Text(
                TNTextStrings.addPagesGeneratePreview,
                style: Theme.of(context).textTheme.bodySmall,
              )
            ],
          ),
        ),
      ),
    );
  }
}
