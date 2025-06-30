


import 'package:flutter/material.dart';
import 'package:toolest/core/constants/colors.dart';

class IconWithFilledButton extends StatelessWidget {
  const IconWithFilledButton({super.key, this.onPressed, required this.icon, required this.title});

  final VoidCallback? onPressed;
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(TNColors.thirdColor),
          foregroundColor: WidgetStateProperty.all(TNColors.white),
        ),
        icon: Icon(icon),
        label: Text(title),
      ),
    );
  }
}
