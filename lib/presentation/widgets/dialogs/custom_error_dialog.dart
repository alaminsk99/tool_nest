import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:toolest/core/constants/colors.dart';
import 'package:toolest/core/constants/sizes.dart';
import 'package:toolest/core/constants/text_strings.dart';
import 'package:toolest/presentation/styles/spacing_style/padding_style.dart';


class DialogOptions{


  Future<void> showModernErrorDialog(BuildContext context, String message) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        insetPadding: const EdgeInsets.symmetric(horizontal: TNSizes.spaceXXL),
        child: Padding(
          padding: TNPaddingStyle.allPaddingLG,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Error Icon
              const Icon(
                Icons.error_outline_rounded,
                color: TNColors.error,
                size: 48,
              ),
              Gap(TNSizes.spaceMD),

              // Title
              const Text(
                TNTextStrings.somThingWrong,
                style: TextStyle(
                  fontSize: TNSizes.fontSizeLG,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              Gap(12),

              // Error Message
              Text(
                message,
                style: const TextStyle(
                  fontSize: TNSizes.fontSizeMD,
                  color: TNColors.black,
                ),
                textAlign: TextAlign.center,
              ),

              Gap(TNSizes.spaceLG),

              // OK Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: TNPaddingStyle.onlyVerticalMDPadding,
                    backgroundColor: TNColors.error,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    'OK',
                    style: TextStyle(fontSize: TNSizes.fontSizeMD, color: TNColors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Future<void> showModernSuccessDialog(BuildContext context, String message){
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        insetPadding: const EdgeInsets.symmetric(horizontal: TNSizes.spaceXXL),
        child: Padding(
          padding: TNPaddingStyle.allPaddingLG,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Error Icon
              Icon(
                LucideIcons.circleCheck,
                color: TNColors.success,
                size: 48,
              ),
              Gap(TNSizes.spaceMD),

              // Title
              const Text(
                TNTextStrings.successMessage,
                style: TextStyle(
                  fontSize: TNSizes.fontSizeLG,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              Gap(12),

              // Error Message
              Text(
                message,
                style: const TextStyle(
                  fontSize: TNSizes.fontSizeMD,
                  color: TNColors.black,
                ),
                textAlign: TextAlign.center,
              ),

              Gap(TNSizes.spaceLG),

              // OK Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: TNPaddingStyle.onlyVerticalMDPadding,
                    backgroundColor: TNColors.success,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    'OK',
                    style: TextStyle(fontSize: TNSizes.fontSizeMD, color: TNColors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}

