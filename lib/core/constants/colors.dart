import 'dart:ui';
import 'package:flutter/material.dart';

class TNColors {
  TNColors._();

  /// App Basic Color
  // Updated to Facebook Blue - primary brand color for buttons, icons, and emphasis
  static const Color primary = Color(0xff1877F2);
  // Light grey for secondary button backgrounds and subtle UI elements
  static const Color secondary = Color(0xffF2F2F5);
  static const Color thirdColor = materialPrimaryColor;
  // Darkest text and icon color
  static const Color black = Color(0xff1E1E1E);

  /// Material Color Swatch
  // Based on primary blue with full Material Design color spectrum
  static const MaterialColor materialPrimaryColor = MaterialColor(
    _primaryValue,
    <int, Color>{
      50: Color(0xffE9ECFF),   // Lightest shade
      100: Color(0xffC9D0FF),
      200: Color(0xffA6B1FF),
      300: Color(0xff8291FF),
      400: Color(0xff6678FF),
      500: Color(_primaryValue), // Core material color
      600: Color(0xff435EE6),
      700: Color(0xff3953CC),
      800: Color(0xff3047B3),
      900: Color(0xff20338F),   // Darkest shade
    },
  );

  static const int _primaryValue = 0xff4B68FF;

  /// Terms and Condition Color
  // Uses primary material color for consistency
  static const Color termTextColor = Color(0xff4B68FF);

  /// Gradient Color
  // Warm gradient from pink to light peach, diagonal direction
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
  static const Color textPrimary = Color(0xff333333);   // Main text and titles
  static const Color textSecondary = Color(0xff6C757D); // Subtitles and secondary text
  static const Color textWhite = Color(0xffFFFFFF);     // Text on dark/colored backgrounds

  /// Background Color
  static const Color primaryBackground = Color(0xffFFFFFF); // Main app background
  static const Color light = Color(0xffF6F6F6);             // Alternative screen or card background
  static const Color dark = Color(0xff272727);              // Dark mode background

  /// Background Container Color
  static const Color lightContainer = Color(0xffFFFFFF);   // Container backgrounds like tool buttons
  static Color darkContainer = TNColors.white.withOpacity(0.1); // Dark mode containers (white with 10% opacity)

  /// Button Color
  static const Color buttonPrimary = Color(0xff4B68FF);    // Main action buttons
  static const Color buttonSecondary = Color(0xffF2F2F5);  // Secondary button backgrounds
  static const Color buttonDisabled = Color(0xffC4C4C4);   // Disabled button state

  /// Border Color
  static const Color borderPrimary = Color(0xffD9D9D9);    // Primary borders
  static const Color borderSecondary = Color(0xffE6E6E6);  // Secondary/lighter borders
  static const Color cusClipperBack = Color(0xffDEF2F9);   // Clipper background color

  /// Functional Colors
  static const Color error = Color(0xffD32F2F);   // Error states and destructive actions
  static const Color success = Color(0xff388E3C); // Success states and confirmations
  static const Color warning = Color(0xffF57C00); // Warning states and alerts
  static const Color info = Color(0xff1976D2);    // Informational states

  /// Neutral Shades
  static const Color blacks = Color(0xff232323);      // Deep black
  static const Color darkerGrey = Color(0xff4F4F4F);  // Darker grey tone
  static const Color darkGrey = Color(0xff939393);    // Medium grey
  static const Color grey = Color(0xffE0E0E0);        // Light grey
  static const Color softGrey = Color(0xffF4F4F4);    // Soft grey
  static const Color lightGrey = Color(0xffF9F9F9);   // Very light grey
  static const Color white = Color(0xffFFFFFF);       // Pure white
  static const Color transparent = Colors.transparent;// Transparent



 /// Special Use Color
  static const Color specialBlueColor = Color(0xff3B82F6);
  static const Color specialGreenColor = Color(0xff22C55E);
  static const Color specialPurpleColor = Color(0xffA855F7);
  static const Color specialBrunColor = Color(0xffF56B13);

  static const specialGreenGradientVeriasion = LinearGradient(
    colors: [
      Color(0xff49DD7F),
      Color(0xff17A44B),
    ],
    stops: [0.2,0.8],
    
  );
}
