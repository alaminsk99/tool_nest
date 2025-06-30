import 'package:flutter/material.dart';
import 'package:toolest/core/constants/colors.dart';

class TNTextTheme{
  TNTextTheme._();

  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(fontSize: 32.0,fontWeight: FontWeight.bold,color: TNColors.black),
    headlineMedium: const TextStyle().copyWith(fontSize: 24.0,fontWeight: FontWeight.w600,color: TNColors.black),
    headlineSmall: const TextStyle().copyWith(fontSize: 18.0,fontWeight: FontWeight.w600,color: TNColors.black),

    titleLarge: const TextStyle().copyWith(fontSize: 16.0,fontWeight: FontWeight.w600,color: TNColors.black),
    titleMedium: const TextStyle().copyWith(fontSize: 16.0,fontWeight: FontWeight.w500,color: TNColors.black),
    titleSmall: const TextStyle().copyWith(fontSize: 16.0,fontWeight: FontWeight.w400,color: TNColors.black),

    bodyLarge: const TextStyle().copyWith(fontSize: 14.0,fontWeight: FontWeight.w500,color: TNColors.black),
    bodyMedium: const TextStyle().copyWith(fontSize: 14.0,fontWeight: FontWeight.normal,color: TNColors.black),
    bodySmall: const TextStyle().copyWith(fontSize: 14.0,fontWeight: FontWeight.w500,color: TNColors.black.withOpacity(0.5)),

    labelLarge: const TextStyle().copyWith(fontSize: 12.0,fontWeight: FontWeight.normal,color: TNColors.black),
    labelMedium: const TextStyle().copyWith(fontSize: 12.0,fontWeight: FontWeight.normal,color: TNColors.black.withOpacity(0.5)),



  );
}