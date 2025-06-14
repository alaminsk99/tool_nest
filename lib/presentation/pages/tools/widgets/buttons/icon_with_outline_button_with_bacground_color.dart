import 'package:flutter/material.dart';
import 'package:tool_nest/core/constants/colors.dart';







class IconWithOutlineButtonWithBackgroundColor extends StatelessWidget {
  const IconWithOutlineButtonWithBackgroundColor({super.key, this.onPressed, required this.icon, required this.title,  this.color});



  final VoidCallback? onPressed;
  final IconData icon;
  final String title;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        style:  ButtonStyle(
            textStyle: WidgetStateProperty.all(Theme.of(context).textTheme.titleSmall),
            elevation: WidgetStateProperty.all(0),
            shadowColor: WidgetStateProperty.all(TNColors.transparent),
            backgroundColor: WidgetStateProperty.all(TNColors.transparent),
            foregroundColor: WidgetStateProperty.all(color),
            padding: WidgetStateProperty.all(EdgeInsetsGeometry.symmetric(vertical: 10))
        ),
        label: Text(title),
        icon: Icon(icon),
      ),
    );
  }
}
