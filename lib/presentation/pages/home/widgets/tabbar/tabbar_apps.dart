import 'package:flutter/material.dart';
import 'package:tool_nest/core/constants/colors.dart';
import 'package:tool_nest/core/constants/sizes.dart';

class TabButton extends StatelessWidget {
  final String label;
  final bool selected;

  const TabButton({required this.label, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      backgroundColor: selected ? TNColors.primary : TNColors.secondary,
      labelStyle: TextStyle(
        color: selected ? TNColors.textWhite : TNColors.textPrimary,
        fontWeight: FontWeight.w500,
      ),
      padding: const EdgeInsets.symmetric(horizontal: TNSizes.spaceMD, vertical: TNSizes.spaceSM),
    );
  }
}
