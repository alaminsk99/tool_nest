

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:tool_nest/core/constants/colors.dart';
import 'package:tool_nest/core/constants/sizes.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/presentation/widgets/bottom_sheets/Items_selection_bottom_sheets.dart';

class OrientationSection extends StatelessWidget {
  final String selectedOrientation;
  final ValueChanged<String> onSelect;
  final List<String> orientations;

  const OrientationSection({
    super.key,
    required this.selectedOrientation,
    required this.onSelect,
    required this.orientations,
  });


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(TNTextStrings.orientation,
            style: Theme.of(context).textTheme.titleSmall),
        const Gap(6),
        ListTile(
          tileColor: TNColors.buttonSecondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(TNSizes.borderRadiusSM),
          ),
          title: Text(selectedOrientation),
          trailing: const Icon(LucideIcons.chevronDown),
          onTap: () => ItemsSelectionBottomSheet.show(
              context: context,
              title: TNTextStrings.selectOrientation,
              options: orientations,
              selectedValue: selectedOrientation,
              onSelect: onSelect,
          ),
        ),
      ],
    );
  }
}