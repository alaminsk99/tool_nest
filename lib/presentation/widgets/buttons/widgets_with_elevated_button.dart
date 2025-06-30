import 'package:flutter/material.dart';
import 'package:toolest/core/constants/colors.dart';
import 'package:toolest/core/constants/sizes.dart';

class WidgetsWithElevatedButton extends StatelessWidget {
  const WidgetsWithElevatedButton({
    super.key,
    required this.child,
    required this.title,
    this.onPressed,
  });

  final Widget child;
  final String title;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: child,
      label: Text(
        title,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: TNColors.white,
        foregroundColor: TNColors.black,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(TNSizes.borderRadiusMD),
        ),
        elevation: 2,
        side: const BorderSide(color: TNColors.borderPrimary),
      ),
    );
  }
}
