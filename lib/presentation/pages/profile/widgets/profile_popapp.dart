import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/core/constants/colors.dart';

class ProfilePopUp {
  void showProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black38,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            width: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: TNColors.grey,
                  child: Icon(
                    LucideIcons.user,
                    size: 40,
                    color: TNColors.white,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      LucideIcons.pencil,
                      color: TNColors.primary,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      TNTextStrings.edtProfile,
                      style: const TextStyle(
                        color: TNColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  "William Jason",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                const Text(
                  "williamjason2526@gmail.com",
                  style: TextStyle(fontSize: 14, color: TNColors.darkGrey),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
