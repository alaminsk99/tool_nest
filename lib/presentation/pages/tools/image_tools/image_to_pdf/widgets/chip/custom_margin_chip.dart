
import 'package:flutter/material.dart';
import 'package:tool_nest/core/constants/colors.dart';

class CustomMarginChip extends StatelessWidget {
  final double value;
  final double selectedValue;
  final VoidCallback onSelected;

  const CustomMarginChip({
    super.key,
    required this.value,
    required this.selectedValue,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = value == selectedValue;
    final baseStyle = Theme.of(context).textTheme.labelLarge;
    /// choice Chip
    return ChoiceChip(
      label: Container(
        width: 50,
        alignment: Alignment.center,
        child: Text(
          '${value.toInt()} px',
          style: baseStyle?.copyWith(
            fontSize: baseStyle.fontSize,
            fontWeight: FontWeight.normal,
            color: TNColors.black,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      showCheckmark: false,
      selected: isSelected,
      selectedColor: TNColors.primary,
      backgroundColor: TNColors.buttonSecondary,
      side: BorderSide(
        color: isSelected ? TNColors.primary : TNColors.grey,
        width: 1.2,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      onSelected: (_) => onSelected(),
    );
  }
}