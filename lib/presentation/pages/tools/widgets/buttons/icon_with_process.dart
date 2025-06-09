
import 'package:flutter/material.dart';
import 'package:tool_nest/core/constants/colors.dart';
import 'package:tool_nest/core/constants/text_strings.dart';

class IconWithProcess extends StatelessWidget {
  const IconWithProcess({
    super.key, this.onPressed, required this.title, this.icon,
  });

  final VoidCallback? onPressed;
  final String title;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style:ButtonStyle(
          textStyle: WidgetStateProperty.all(Theme.of(context).textTheme.titleSmall),
          elevation:WidgetStateProperty.all(0),
          shadowColor: WidgetStateProperty.all(TNColors.transparent),
          backgroundColor: WidgetStateProperty.all(TNColors.primary),
          foregroundColor: WidgetStateProperty.all(TNColors.black),
        ),
        icon: icon != null? Icon(icon): null,
        label:  Text(title),
      ),
    );
  }
}