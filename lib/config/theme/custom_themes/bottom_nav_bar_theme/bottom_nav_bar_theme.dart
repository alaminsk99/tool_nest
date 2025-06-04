import 'package:flutter/material.dart';
import 'package:tool_nest/core/constants/colors.dart';
import 'package:tool_nest/core/constants/sizes.dart';

class TNBottomNavBarTheme {
  TNBottomNavBarTheme._(); // Private constructor to prevent instantiation

  static const lightBottomNavBarTheme = BottomNavigationBarThemeData(
    backgroundColor: TNColors.transparent,
    elevation: 0,
    selectedIconTheme: IconThemeData(color: TNColors.materialPrimaryColor,size: TNSizes.iconSizeMDForBottoms),
    unselectedIconTheme: IconThemeData(color: TNColors.black,size: TNSizes.iconSizeMDForBottoms),
    showSelectedLabels: false,
    showUnselectedLabels: false,
    type: BottomNavigationBarType.fixed,


  );
}
