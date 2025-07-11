import 'package:flutter/material.dart';
import 'package:toolest/core/constants/colors.dart';
import 'package:toolest/core/constants/sizes.dart';
import 'package:toolest/core/constants/text_strings.dart';

import '../../image_tools/image_to_pdf/widgets/upload_image_section.dart';


class UploadContainerForItem extends StatelessWidget {
  const UploadContainerForItem({
    super.key, this.onPressed,required this.title, required this.subTitle,
  });

  final VoidCallback? onPressed;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: TNColors.buttonSecondary,
        borderRadius: BorderRadius.circular(TNSizes.borderRadiusSM),
        border: Border.all(color: TNColors.borderPrimary),
      ),
      child: UploadImageSection(title: title,subTitle: subTitle,onPressed: onPressed,buttonTitle: TNTextStrings.browseFiles,),
    );
  }
}