
import 'dart:ui';

import 'package:flutter/material.dart';

class TNColors{
  TNColors._();

  /// App Basic Color
  static const Color primary = Color(0xff2E8735);
  static const Color secondary = Color(0xffF2F2F5);
  static const Color black = Color(0xff1E1E1E);
  static const MaterialColor materialPrimaryColor = MaterialColor(
    _primaryValue,
    <int, Color>{
      50: Color(0xffE1F2E4),
      100: Color(0xffB6E1BB),
      200: Color(0xff88CF8F),
      300: Color(0xff59BD63),
      400: Color(0xff3CA448),
      500: Color(_primaryValue),
      600: Color(0xff28772F),
      700: Color(0xff226429),
      800: Color(0xff1C5223),
      900: Color(0xff123A17),
    },
  );

  static const int _primaryValue = 0xff2E8735;

  /// Terms and Condition Color
  static const Color termTextColor = Color(0xff2A9CAE);



  /// Gradient Color
  static const Gradient linearGradient = LinearGradient(
      begin: Alignment(0.0, 0.0),
      end: Alignment(0.707, -0.707),
      colors: [
        Color(0xffff9a9e),
        Color(0xfffad0c4),
        Color(0xfffad0c4),
      ]);
  /// Text Color
  static const Color textPrimary = Color(0xff333333);
  static const Color textSecondary = Color(0xff6c757d);
  static const Color textWhite = Color(0xffffffff);

  /// Background Color
  static const Color light = Color(0xfff6f6f6);
  static const Color dark = Color(0xff272727);
  static const Color primaryBackground = Color(0xfff3f5ff);

  /// Background Container Color
  static const Color lightContainer = Color(0xfff6f6f6);
  static  Color darkContainer = TNColors.white.withOpacity(0.1);

  /// Button Color
  static const Color buttonPrimary = Color(0xff4b68ff);
  static const Color buttonSecondary = Color(0xff6c757d);
  static const Color buttonDisabled = Color(0xffc4c4c4);


  /// Border Color
  static const Color borderPrimary = Color(0xffd9d9d9);
  static const Color borderSecondary = Color(0xffe6e6e6);

  /// Error and Validation Color
  static const Color  error = Color(0xffd32f2f);
  static const Color  success = Color(0xff388e3c);
  static const Color  warning = Color(0xfff57c00);
  static const Color  info = Color(0xff1976d2);

  /// Neutral Shades
  static const Color blacks = Color(0xff232323);
  static const Color darkerGrey = Color(0xff4f4f4f);
  static const Color darkGrey = Color(0xff939393);
  static const Color grey = Color(0xffe0e0e0);
  static const Color softGrey = Color(0xfff4f4f4);
  static const Color lightGrey = Color(0xfff9f9f9);
  static const Color white = Color(0xffffffff);
  static const Color transparent = Colors.transparent;
}