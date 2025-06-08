import 'package:flutter/material.dart';

class SnackbarHelper {
  static void showSuccess(BuildContext context, String message, {String? actionLabel, VoidCallback? onAction}) {
    _showSnackbar(
      context,
      message,
      backgroundColor: Colors.green.shade600,
      icon: Icons.check_circle_rounded,
      actionLabel: actionLabel,
      onAction: onAction,
    );
  }

  static void showError(BuildContext context, String message, {String? actionLabel, VoidCallback? onAction}) {
    _showSnackbar(
      context,
      message,
      backgroundColor: Colors.red.shade600,
      icon: Icons.error_outline_rounded,
      actionLabel: actionLabel,
      onAction: onAction,
    );
  }

  static void _showSnackbar(
      BuildContext context,
      String message, {
        required Color backgroundColor,
        required IconData icon,
        String? actionLabel,
        VoidCallback? onAction,
      }) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      elevation: 6,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: backgroundColor.withOpacity(0.95),
      duration: const Duration(seconds: 4),
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      action: (actionLabel != null && onAction != null)
          ? SnackBarAction(
        label: actionLabel,
        onPressed: onAction,
        textColor: Colors.white,
      )
          : null,
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
