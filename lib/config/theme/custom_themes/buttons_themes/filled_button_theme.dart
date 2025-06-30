

import 'package:flutter/material.dart';
import 'package:toolest/core/constants/colors.dart';
import 'package:toolest/core/constants/sizes.dart';

class TNFilledButtonTheme{
  TNFilledButtonTheme._();


  static final lightFilledButtonTheme = FilledButtonThemeData(
    style: ButtonStyle(
      elevation: WidgetStateProperty.all(0),
      shadowColor: WidgetStateProperty.all(Colors.transparent),
      surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
      backgroundColor: WidgetStateProperty.resolveWith<Color>(
            (states) {
          if (states.contains(WidgetState.disabled)) {
            return TNColors.buttonDisabled;
          }
          return TNColors.primary;
        },
      ),
      foregroundColor: WidgetStateProperty.resolveWith<Color>(
            (states) {
          if (states.contains(WidgetState.disabled)) {
            return TNColors.buttonSecondary;
          }
          return TNColors.black;
        },
      ),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(TNSizes.borderRadiusSM),
          side: const BorderSide(color: TNColors.primary),
        ),
      ),
      textStyle: WidgetStateProperty.all(
        const TextStyle(fontSize: TNSizes.fontSizeSM),
      ),
      overlayColor: WidgetStateProperty.all(Colors.transparent),

    )
  );
}