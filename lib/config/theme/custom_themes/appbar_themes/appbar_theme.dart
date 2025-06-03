

import 'package:flutter/material.dart';
import 'package:tool_nest/core/constants/colors.dart';

class TNAppBarTheme{
  TNAppBarTheme._();

  static const lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    foregroundColor: TNColors.primary,
    iconTheme: IconThemeData(color: TNColors.white,size: 24),
    actionsIconTheme: IconThemeData(color: TNColors.blacks,size: 24),

  );
}