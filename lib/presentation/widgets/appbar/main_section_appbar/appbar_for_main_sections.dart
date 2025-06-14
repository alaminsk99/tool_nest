

import 'package:flutter/material.dart';
import 'package:tool_nest/core/constants/colors.dart';
import 'package:tool_nest/core/constants/sizes.dart';
import 'package:tool_nest/core/utils/device/device_utility.dart';
import 'package:tool_nest/presentation/widgets/custom_appbar.dart';

class AppbarForMainSections extends StatelessWidget implements PreferredSizeWidget  {
  const AppbarForMainSections({super.key, required this.title, required this.isLeadingIcon, this.widgets});

  final String title;
  final bool isLeadingIcon;
  final List<Widget>? widgets;
  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: title,isLeadingIcon: isLeadingIcon,
      isCenterTitle: false,
      backgroundColor: TNColors.primary, textColorTheme: const TextStyle().copyWith(fontSize: TNSizes.fontSizeXXL,fontWeight: FontWeight.w600,color: TNColors.secondary),
      widgets: widgets,
    );


  }
  @override
  Size get preferredSize => Size.fromHeight(TNDeviceUtility.getAppBarHeight());

}
