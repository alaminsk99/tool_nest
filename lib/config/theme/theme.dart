
import 'package:flutter/material.dart';
import 'package:tool_nest/config/theme/custom_themes/appbar_themes/appbar_theme.dart';
import 'package:tool_nest/config/theme/custom_themes/bottom_nav_bar_theme/bottom_nav_bar_theme.dart';
import 'package:tool_nest/config/theme/custom_themes/buttons_themes/filled_button_theme.dart';
import 'package:tool_nest/config/theme/custom_themes/buttons_themes/outline_button_theme.dart';
import 'package:tool_nest/config/theme/custom_themes/text_field_themes/text_field_themes_t_n.dart';
import 'package:tool_nest/core/constants/colors.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'custom_themes/buttons_themes/elevated_button_theme.dart';
import 'custom_themes/text_themes/text_theme.dart';

class TNTheme{
  TNTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    primarySwatch: TNColors.materialPrimaryColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    appBarTheme: TNAppBarTheme.lightAppBarTheme,
    fontFamily: TNTextStrings.fontFamily,
    textTheme: TNTextTheme.lightTextTheme,
    bottomNavigationBarTheme: TNBottomNavBarTheme.lightBottomNavBarTheme,
    splashFactory: NoSplash.splashFactory,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
    elevatedButtonTheme: TNElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: TNOutlineButtonTheme.lightOutlinedButtonTheme,
    filledButtonTheme: TNFilledButtonTheme.lightFilledButtonTheme,
    inputDecorationTheme: TNTextFieldThemes.lightTextFieldThemes,




  );
}