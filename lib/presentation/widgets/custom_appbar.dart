
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {super.key, required this.title,
        this.backgroundColor = Colors.transparent,
        this.isCenterTitle = true,
        this.isLeadingIcon = false,
        this.textColorTheme, this.iconThemeData,
      });

  final String title;
  final Color backgroundColor;
  final IconThemeData? iconThemeData;
  final bool isCenterTitle;
  final TextStyle? textColorTheme;
  final bool isLeadingIcon;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: isCenterTitle,
      automaticallyImplyLeading: isLeadingIcon,
      title: Text(
        title,
        style: textColorTheme  ?? Theme.of(context).textTheme.headlineLarge!.copyWith(color:Theme.of(context).colorScheme.primary),
      ),
      backgroundColor: backgroundColor,
      elevation: 0,
      iconTheme: iconThemeData,

    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}