
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:tool_nest/core/constants/colors.dart';
import 'package:tool_nest/core/constants/sizes.dart';
import 'package:tool_nest/core/constants/text_strings.dart';

class UploadImageSection extends StatelessWidget {
  const UploadImageSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(LucideIcons.cloudUpload, size: 60, color: TNColors.darkGrey),
        const Gap(12),
        Text(
          TNTextStrings.uploadFiles,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Text(
          TNTextStrings.dragAndDrop,
          style: Theme.of(context).textTheme.bodySmall,
          overflow: TextOverflow.ellipsis,
        ),
        const Gap(16),

        ///  Browse Files Button
        ElevatedButton(
          onPressed: () async {
            // TODO: File picker logic here
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: TNColors.buttonDisabled,
            elevation: 0,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(TNSizes.borderRadiusSM),
            ),
          ),
          child: const Text(TNTextStrings.browseFiles),
        ),
      ],
    );
  }
}