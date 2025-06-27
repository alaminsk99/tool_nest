import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:tool_nest/config/router/route_paths.dart';
import 'package:tool_nest/core/constants/colors.dart';
import 'package:tool_nest/core/constants/sizes.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/core/utils/device/device_utility.dart';

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      titleSpacing: TNSizes.spaceBetweenItems,
      title: Text(
        TNTextStrings.appName,
        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
          color: TNColors.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: TNSizes.spaceBetweenItems),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 20,
            child: Center(child:  IconButton(onPressed: ()=> context.goNamed(AppRoutes.profile), color: TNColors.primary, icon:Icon(Icons.person,))),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(TNDeviceUtility.getAppBarHeight());
}
