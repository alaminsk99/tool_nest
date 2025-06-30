
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:toolest/core/constants/colors.dart';
import 'package:toolest/core/constants/sizes.dart';
import 'package:toolest/presentation/widgets/bottom_sheets/Items_selection_bottom_sheets.dart';


class DropdownButtonSelectionUsingBottomSheets extends StatelessWidget {
  const DropdownButtonSelectionUsingBottomSheets(
      {super.key,
        required this.titleForBottomSheet,
        required this.titleOfTheSection,
        required this.selectedItem,
        required this.options,
        required this.onSelect,
      });
  final String titleForBottomSheet;
  final String titleOfTheSection;/// [Page Size ,Orientation, Save As]
  final String selectedItem;
  final List<String> options;/// [Landscape,Portrait]
  final ValueChanged<String> onSelect;/// [Dynamic Changes]




  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Text for Section Title
        Text(titleOfTheSection,style: Theme.of(context).textTheme.titleSmall,textAlign: TextAlign.center,),

        Gap(TNSizes.spaceSM),

        /// List Tile for Selection Option for Items

        ListTile(
          tileColor: TNColors.buttonSecondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(TNSizes.borderRadiusSM),
          ),
          leading: Text(selectedItem),
          trailing : Icon(LucideIcons.chevronDown),
          onTap: ()=> ItemsSelectionBottomSheet.show(
              context: context,
            /// Text for Bottom Sheet Title
              title: titleForBottomSheet,
              options: options,
              selectedValue: selectedItem,
              onSelect: onSelect,
          ),
        )
      ],
    );
  }
}
