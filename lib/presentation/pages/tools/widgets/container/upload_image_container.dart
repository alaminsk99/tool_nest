import 'package:flutter/material.dart';
import 'package:tool_nest/core/constants/colors.dart';
import 'package:tool_nest/core/constants/sizes.dart';

import '../../image_tools/image_to_pdf/widgets/upload_image_section.dart';


class UploadImageContainer extends StatelessWidget {
  const UploadImageContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: TNColors.buttonSecondary,
          borderRadius: BorderRadius.circular(TNSizes.borderRadiusSM),
          border: Border.all(color: TNColors.borderPrimary),
        ),
        child: UploadImageSection(),
      ),
    );
  }
}