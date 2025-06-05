import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tool_nest/core/constants/colors.dart';
import 'package:tool_nest/core/constants/sizes.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/presentation/widgets/bottom_sheets/Items_selection_bottom_sheets.dart';

class PageSizeSection extends StatelessWidget {
  final String selectedPageSize;
  final ValueChanged<String> onSelect;
  final List<String> pageSizes;

  const PageSizeSection({
    super.key,
    required this.selectedPageSize,
    required this.onSelect,
    required this.pageSizes,
  });


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(TNTextStrings.pageSize,
            style: Theme.of(context).textTheme.titleSmall),
        const Gap(6),
        ListTile(
          tileColor: TNColors.buttonSecondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(TNSizes.borderRadiusSM),
          ),
          title: Text(selectedPageSize),
          trailing: const Icon(Icons.keyboard_arrow_down),
          onTap: () => ItemsSelectionBottomSheet.show(context: context,
              title: TNTextStrings.selectPageSize,
              options: pageSizes, selectedValue: selectedPageSize,
              onSelect: onSelect),
        ),
      ],
    );
  }
}