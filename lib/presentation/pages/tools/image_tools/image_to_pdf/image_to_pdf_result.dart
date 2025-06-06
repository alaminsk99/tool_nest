import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:tool_nest/core/constants/colors.dart';
import 'package:tool_nest/core/constants/sizes.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/presentation/pages/tools/image_tools/image_to_pdf/widgets/buttons/action_button_for_img_to_pdf_result.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/buttons/icon_with_filled_button.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/buttons/icon_with_outline_button.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/buttons/icon_with_process.dart';
import 'package:tool_nest/presentation/widgets/appbar/main_section_appbar/appbar_for_main_sections.dart';
import 'package:tool_nest/presentation/widgets/card/result_card.dart';

class ImageToPdfResultScreen extends StatelessWidget {
  const ImageToPdfResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarForMainSections(title: TNTextStrings.resultPDFScreen, isLeadingIcon: false,),
      body: Padding(
        padding: const EdgeInsets.all(TNSizes.spaceMD),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Heading
            Text(
              TNTextStrings.generatedPDF,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const Gap(TNSizes.spaceMD),

            /// PDF Viewer Placeholder
            ResultCard(),

            const Gap(TNSizes.spaceXL),

            /// Action Buttons
            ActionButtonForImgToPdfResult()



          ],
        ),
      ),
    );
  }
}

