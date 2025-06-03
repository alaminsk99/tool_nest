import 'package:flutter/material.dart';
import 'package:tool_nest/core/constants/colors.dart';

class TNBottomNavBarTheme {
  TNBottomNavBarTheme._(); // Private constructor to prevent instantiation

  static const lightBottomNavBarTheme = BottomNavigationBarThemeData(
    backgroundColor: TNColors.transparent,
    elevation: 0,
    selectedIconTheme: IconThemeData(color: TNColors.materialPrimaryColor,),
    unselectedIconTheme: IconThemeData(color: TNColors.blacks,),
    showSelectedLabels: false,
    showUnselectedLabels: false,
    type: BottomNavigationBarType.fixed,

  );
}
