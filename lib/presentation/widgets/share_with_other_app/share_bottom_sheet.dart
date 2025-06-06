import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:tool_nest/core/constants/colors.dart';
import 'package:tool_nest/core/constants/sizes.dart';
import 'package:tool_nest/core/constants/text_strings.dart';

class ShareBottomSheet extends StatelessWidget {
  const ShareBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(TNSizes.spaceLG),
      decoration: const BoxDecoration(
        color: TNColors.primaryBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(TNSizes.borderRadiusLG)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Top Indicator
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: TNColors.grey,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const Gap(TNSizes.spaceMD),

          /// Heading
          Text(
            TNTextStrings.shareWithOthers,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          const Gap(TNSizes.spaceLG),

          /// Share Options
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              _ShareOption(icon: LucideIcons.messageCircle, label: 'WhatsApp'),
              _ShareOption(icon: LucideIcons.mail, label: 'Email'),
              _ShareOption(icon: LucideIcons.share2, label: 'More'),
            ],
          ),
          const Gap(TNSizes.spaceXL),
        ],
      ),
    );
  }
}

class _ShareOption extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ShareOption({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: TNColors.buttonSecondary,
          radius: 28,
          child: Icon(icon, color: TNColors.primary, size: 24),
        ),
        const Gap(TNSizes.spaceXS),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
// showModalBottomSheet(
// context: context,
// shape: const RoundedRectangleBorder(
// borderRadius: BorderRadius.vertical(top: Radius.circular(TNSizes.borderRadiusLG)),
// ),
// backgroundColor: TNColors.primaryBackground,
// builder: (_) => const ShareBottomSheet(),
// );
