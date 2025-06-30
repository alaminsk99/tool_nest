
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:toolest/core/constants/colors.dart';
import 'package:toolest/core/constants/text_strings.dart';
import 'package:toolest/presentation/pages/tools/image_tools/image_to_pdf/image_to_pdf_settings.dart';
import 'package:toolest/presentation/pages/tools/image_tools/image_to_pdf/widgets/custom_margin_chip_for_image_to_pdf.dart';

class MarginTypeSection extends StatelessWidget {
  final double margin;
  final bool isCustom;
  final double customMargin;
  final List<double> customMarginOptions;
  final Map<double, VoidCallback> chipCallbacks;
  final VoidCallback onDefaultSelected;
  final VoidCallback onCustomSelected;

  const MarginTypeSection({
    super.key,
    required this.margin,
    required this.isCustom,
    required this.customMargin,
    required this.customMarginOptions,
    required this.chipCallbacks,
    required this.onDefaultSelected,
    required this.onCustomSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${TNTextStrings.pageMargin} (${margin.toInt()} px)',
            style: Theme.of(context).textTheme.titleSmall),
        const Gap(8),
        Row(
          children: [
            ChoiceChip(
              label: const Text(TNTextStrings.defaultText),
              selected: !isCustom,
              showCheckmark: false,
              onSelected: (_) => onDefaultSelected(),
              selectedColor: TNColors.primary,
            ),
            const Gap(12),
            ChoiceChip(
              label: const Text(TNTextStrings.custom),
              selected: isCustom,
              showCheckmark: false,
              onSelected: (_) => onCustomSelected(),
              selectedColor: TNColors.primary,
            ),
          ],
        ),
        if (isCustom) ...[
          const Gap(12),
          CustomMarginChipsForImageToPdf(
            customMarginOptions: customMarginOptions,
            selectedMargin: customMargin,
            chipCallbacks: chipCallbacks,
          ),
        ],
      ],
    );
  }
}