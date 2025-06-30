import 'package:flutter/material.dart';
import 'package:toolest/core/constants/colors.dart';
import 'package:toolest/core/constants/sizes.dart';


class TNTextFieldThemes{





  static InputDecorationTheme  lightTextFieldThemes = InputDecorationTheme(

    errorMaxLines: 3,
    prefixIconColor: Colors.grey,
    suffixIconColor: Colors.grey,
    //constraints: BoxConstraints.expand(height: 14.inputFileHeight),
    labelStyle: const TextStyle().copyWith(fontSize: TNSizes.fontSizeMD,color: TNColors.blacks ),
    hintStyle: const TextStyle().copyWith(fontSize: TNSizes.fontSizeMD,color: TNColors.blacks ),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),

    floatingLabelStyle:  const TextStyle().copyWith(color: TNColors.blacks.withOpacity(0.8) ),

    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(TNSizes.borderRadiusMD),
      borderSide: const BorderSide(width: 1,color:  TNColors.grey),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(width: 1,color: TNColors.grey),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(width: 1,color: TNColors.black),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(width: 1,color: TNColors.error),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(width: 1,color: TNColors.warning),
    ),




  );
}