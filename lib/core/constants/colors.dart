import 'dart:ui';

import 'package:flutter/material.dart';

class TNColors {
  TNColors._();

  /// App Basic Color
  // Changed to match the prominent blue-purple in buttons and icons
  // Uses Color
  static const Color primary = Color(0xff1877F2);
  // Light grey, suitable for secondary button backgrounds or subtle UI elements
  // Uses Color
  static const Color secondary = Color(0xffF2F2F5);
  // Uses Color
  static const Color black = Color(0xff1E1E1E); // Darkest text/icon color

  // Updated MaterialColor to be based on the new primary color
  static const MaterialColor materialPrimaryColor = MaterialColor(
    _primaryValue,
    <int, Color>{
      50: Color(0xFFE9ECFF),  // Lighter shade of primary
      100: Color(0xFFC9D0FF),
      200: Color(0xFFA6B1FF),
      300: Color(0xFF8291FF),
      400: Color(0xFF6678FF),
      500: Color(_primaryValue), // This is primary: 0xff4B68FF
      600: Color(0xFF435EE6),
      700: Color(0xFF3953CC),
      800: Color(0xFF3047B3),
      900: Color(0xFF20338F),  // Darker shade of primary
    },
  );

  // Updated _primaryValue to the new primary color hex
  static const int _primaryValue = 0xff1877F2;

  /// Terms and Condition Color
  // Changed to primary color for consistency, as the original teal was not observed
  static const Color termTextColor = Color(0xff4B68FF); // Uses primary color

  /// Gradient Color
  // This gradient was not observed in the provided screenshots.
  // Kept as is, review if it's used or needs to align with the new theme.
  static const Gradient linearGradient = LinearGradient(
    begin: Alignment(0.0, 0.0),
    end: Alignment(0.707, -0.707),
    colors: [
      Color(0xffff9a9e),
      Color(0xfffad0c4),
      Color(0xfffad0c4),
    ],
  );

  /// Text Color
  static const Color textPrimary = Color(0xff333333); // For main text, titles
  static const Color textSecondary = Color(0xff6C757D); // For subtitles, less important text
  static const Color textWhite = Color(0xffFFFFFF); // For text on dark/colored backgrounds

  /// Background Color
  static const Color light = Color(0xffF6F6F6); // Very light grey, can be an alternative screen bg or card bg
  static const Color dark = Color(0xff272727); // For dark mode background
  // Changed to white for the main app background as seen in screenshots
  static const Color primaryBackground = Color(0xffFFFFFF);

  /// Background Container Color
  // Changed to white for containers like tool buttons, which appear white
  static const Color lightContainer = Color(0xffFFFFFF);
  static Color darkContainer = TNColors.white.withOpacity(0.1); // For dark mode containers

  /// Button Color
  // This is the main action color, same as primary
  static const Color buttonPrimary = Color(0xff4B68FF);
  // Changed to a light grey for secondary button backgrounds (e.g., "Log Out", "Browse Files" bg)
  static const Color buttonSecondary = Color(0xffF2F2F5);
  static const Color buttonDisabled = Color(0xffC4C4C4); // Standard disabled color

  /// Border Color
  static const Color borderPrimary = Color(0xffD9D9D9); // For primary borders
  static const Color borderSecondary = Color(0xffE6E6E6); // For secondary/lighter borders

  /// Error and Validation Color (Standard colors, kept as is)
  static const Color error = Color(0xffD32F2F);
  static const Color success = Color(0xff388E3C);
  static const Color warning = Color(0xffF57C00);
  static const Color info = Color(0xff1976D2);

  /// Neutral Shades (Standard palette, kept as is)
  static const Color blacks = Color(0xff232323);
  static const Color darkerGrey = Color(0xff4F4F4F);
  static const Color darkGrey = Color(0xff939393);
  static const Color grey = Color(0xffE0E0E0);
  static const Color softGrey = Color(0xffF4F4F4);
  static const Color lightGrey = Color(0xffF9F9F9);
  static const Color white = Color(0xffFFFFFF);
  static const Color transparent = Colors.transparent;
}