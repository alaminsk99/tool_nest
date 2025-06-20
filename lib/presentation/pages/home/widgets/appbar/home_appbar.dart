

import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:tool_nest/core/constants/colors.dart';
import 'package:tool_nest/core/constants/sizes.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/core/utils/device/device_utility.dart';

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget{
  const HomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(TNTextStrings.appName,style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: TNColors.primary,fontWeight: FontWeight.w600),),
        actions: [IconButton(onPressed: (){},icon:  Icon(LucideIcons.settings),),]
    );
  }
  @override
  Size get preferredSize => Size.fromHeight(TNDeviceUtility.getAppBarHeight());
}
