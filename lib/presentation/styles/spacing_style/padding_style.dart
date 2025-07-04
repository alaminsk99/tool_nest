

import 'package:flutter/cupertino.dart';
import 'package:toolest/core/constants/sizes.dart';

class TNPaddingStyle{
  TNPaddingStyle._();

  static const EdgeInsetsGeometry allPadding = EdgeInsets.all(TNSizes.spaceMD);
  static const EdgeInsetsGeometry allPaddingSM = EdgeInsets.all(TNSizes.spaceSM);
  static const EdgeInsetsGeometry allPaddingXS = EdgeInsets.all(TNSizes.spaceXS);
  static const EdgeInsetsGeometry allPaddingLG = EdgeInsets.all(TNSizes.spaceLG);

  static const EdgeInsetsGeometry onlyVerticalSMPadding = EdgeInsets.symmetric(vertical: TNSizes.paddingSM);
  static const EdgeInsetsGeometry onlyVerticalMDPadding = EdgeInsets.symmetric(vertical: TNSizes.paddingMD);

  static const EdgeInsetsGeometry onlyHorizontalMDPadding = EdgeInsets.symmetric(horizontal: TNSizes.paddingMD);
  static const EdgeInsetsGeometry onlyHorizontalLGPadding = EdgeInsets.symmetric(horizontal: TNSizes.paddingLG);
  static const EdgeInsetsGeometry onlyHorizontalXXLPadding = EdgeInsets.symmetric(horizontal: TNSizes.spaceXXL);
  static const EdgeInsetsGeometry onlyHorizontalSMPadding = EdgeInsets.symmetric(horizontal: TNSizes.spaceSM);

  static const EdgeInsetsGeometry onlyTopPaddingMD = EdgeInsets.only(top: TNSizes.paddingMD);
  static const EdgeInsetsGeometry onlyBottomPaddingLG = EdgeInsets.only(bottom: TNSizes.paddingLG);
  static const EdgeInsetsGeometry symmetricHVMargin = EdgeInsets.symmetric(horizontal: TNSizes.spaceMD, vertical: TNSizes.spaceSM);
  static const EdgeInsetsGeometry onlyBottomXXL = EdgeInsets.only(bottom: TNSizes.spaceXXL);

  static const EdgeInsetsGeometry onlyLeftMD = EdgeInsets.only(left: TNSizes.spaceMD);

}