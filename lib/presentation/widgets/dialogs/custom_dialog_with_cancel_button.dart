import 'package:flutter/material.dart';
import 'package:tool_nest/core/constants/colors.dart';
import 'package:tool_nest/core/constants/text_strings.dart';

class CustomDialogWithCancelButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String message;
  final String confirmText;
  final String cancelText;

  const CustomDialogWithCancelButton({
    super.key,
    required this.onPressed,
    required this.message,
    required this.confirmText,
    this.cancelText = TNTextStrings.cancel,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AlertDialog(
      backgroundColor: TNColors.white,
      contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      content: Text(
        message,
        style: textTheme.titleMedium?.copyWith(
          color: TNColors.textPrimary,
          fontWeight: FontWeight.w500,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            cancelText,
            style: textTheme.labelLarge?.copyWith(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close dialog first
            onPressed(); // Execute passed logout/action
          },
          child: Text(
            confirmText,
            style: textTheme.labelLarge?.copyWith(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
