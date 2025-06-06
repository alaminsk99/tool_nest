import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tool_nest/core/constants/sizes.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/presentation/widgets/appbar/main_section_appbar/appbar_for_main_sections.dart';

import '../../widgets/buttons/process_button.dart';
import '../../widgets/container/upload_image_container.dart';

class ImageToPdfPage extends StatelessWidget {
  const ImageToPdfPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarForMainSections(
        title: TNTextStrings.imageToPDF,
        isLeadingIcon: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(TNSizes.spaceMD),
        child: Column(
          children: [
            ///  Upload Image container
            UploadImageContainer(),

            const Gap(TNSizes.spaceMD),

            ///  Process Button
            ProcessButton(),
          ],
        ),
      ),
    );
  }
}



