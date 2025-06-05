
import 'package:flutter/material.dart';

import 'chip/custom_margin_chip.dart';

class CustomMarginChipsForImageToPdf extends StatelessWidget {
  final List<double> customMarginOptions;
  final double selectedMargin;
  final Map<double, VoidCallback> chipCallbacks;

  const CustomMarginChipsForImageToPdf({
    super.key,
    required this.customMarginOptions,
    required this.selectedMargin,
    required this.chipCallbacks,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: customMarginOptions.map((value) {
        return CustomMarginChip(
          key: ValueKey(value),
          value: value,
          selectedValue: selectedMargin,
          onSelected: chipCallbacks[value]!,
        );
      }).toList(),
    );
  }
}