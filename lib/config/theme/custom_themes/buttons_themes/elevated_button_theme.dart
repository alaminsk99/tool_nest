import 'package:flutter/material.dart';
import 'package:tool_nest/core/constants/colors.dart';
import 'package:tool_nest/core/constants/sizes.dart';

class TNElevatedButtonTheme {
  TNElevatedButtonTheme._();

  static final ElevatedButtonThemeData lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ButtonStyle(
      elevation: MaterialStateProperty.all(0),
      shadowColor: MaterialStateProperty.all(Colors.transparent),
      surfaceTintColor: MaterialStateProperty.all(Colors.transparent),
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (states) {
          if (states.contains(MaterialState.disabled)) {
            return TNColors.buttonDisabled;
          }
          return TNColors.primary;
        },
      ),
      foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (states) {
          if (states.contains(MaterialState.disabled)) {
            return TNColors.buttonSecondary;
          }
          return TNColors.black;
        },
      ),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(TNSizes.borderRadiusSM),
          side: const BorderSide(color: TNColors.primary),
        ),
      ),
      textStyle: MaterialStateProperty.all(
        const TextStyle(fontSize: TNSizes.fontSizeSM),
      ),
      overlayColor: MaterialStateProperty.all(Colors.transparent),
    ),
  );
}
