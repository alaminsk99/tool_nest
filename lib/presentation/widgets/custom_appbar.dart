import 'package:flutter/material.dart';
import 'package:tool_nest/core/constants/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.backgroundColor = Colors.transparent,
    this.isCenterTitle = true,
    this.isLeadingIcon = false,
    this.textColorTheme,
    this.iconThemeData,
    this.leadingTitleSpacing,
    this.widgets,
  });

  final String title;
  final Color backgroundColor;
  final IconThemeData? iconThemeData;
  final bool isCenterTitle;
  final TextStyle? textColorTheme;
  final bool isLeadingIcon;
  final double? leadingTitleSpacing;
  final List<Widget>? widgets;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: isCenterTitle,
      automaticallyImplyLeading: isLeadingIcon,
      title: Text(
        title,
        style: textColorTheme ??
            Theme.of(context).textTheme.headlineLarge!.copyWith(
              color: TNColors.primary,
            ),
      ),
      backgroundColor: backgroundColor,
      elevation: 0,
      iconTheme: iconThemeData,
      titleSpacing: leadingTitleSpacing,
      actions: widgets,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}