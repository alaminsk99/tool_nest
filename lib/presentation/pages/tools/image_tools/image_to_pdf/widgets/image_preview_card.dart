import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:toolest/core/constants/colors.dart';
import 'package:toolest/core/constants/sizes.dart';
import 'package:toolest/core/constants/text_strings.dart';
import 'package:toolest/presentation/pages/tools/widgets/buttons/icon_with_outline_button.dart';
import 'package:toolest/presentation/pages/tools/widgets/buttons/icon_with_process.dart';
import 'package:toolest/presentation/pages/tools/widgets/buttons/process_button.dart';
import 'package:toolest/presentation/widgets/appbar/main_section_appbar/appbar_for_main_sections.dart';
import 'package:toolest/presentation/widgets/card/preview_card.dart';

import 'buttons/action_button_for_preview_card.dart';

class ImageToPdfPreview extends StatelessWidget {
  const ImageToPdfPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarForMainSections(title: TNTextStrings.previewPDFScreen, isLeadingIcon: false),
      body: Padding(
        padding: const EdgeInsets.all(TNSizes.spaceMD),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Heading
            Text(
              TNTextStrings.yourPDFPreview,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const Gap(TNSizes.spaceMD),

            /// Preview Card
            PreviewCard(),

            const Gap(TNSizes.spaceXL),

            /// Action Buttons
            ActionButtonForPreviewCard(),
          ],
        ),
      ),
    );
  }
}


