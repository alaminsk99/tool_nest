import 'package:flutter/material.dart';
import 'package:toolest/core/constants/colors.dart';
import 'package:toolest/core/constants/sizes.dart';

class TNOutlineButtonTheme {
  TNOutlineButtonTheme._();

  static final OutlinedButtonThemeData lightOutlinedButtonTheme =
  OutlinedButtonThemeData(
    style: ButtonStyle(
      elevation: WidgetStateProperty.all(0),
      shadowColor: WidgetStateProperty.all(Colors.transparent),
      surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
      backgroundColor: WidgetStateProperty.resolveWith<Color>(
            (states) {
          if (states.contains(WidgetState.disabled)) {
            return TNColors.buttonDisabled;
          }
          return Colors.transparent;
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
      side: WidgetStateProperty.resolveWith<BorderSide>(
            (states) {
          if (states.contains(WidgetState.disabled)) {
            return const BorderSide(color: TNColors.borderPrimary);
          }
          return const BorderSide(color: TNColors.borderPrimary);
        },
      ),
      textStyle: WidgetStateProperty.all(
        const TextStyle(fontSize: TNSizes.fontSizeSM),
      ),
      padding: WidgetStateProperty.all(
        const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
      ),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(TNSizes.borderRadiusSM),
        ),
      ),
      overlayColor: WidgetStateProperty.all(Colors.transparent),
    ),
  );
}