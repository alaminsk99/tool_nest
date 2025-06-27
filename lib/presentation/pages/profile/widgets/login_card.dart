import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:tool_nest/core/constants/colors.dart';
import 'package:tool_nest/core/constants/sizes.dart';
import 'package:tool_nest/presentation/styles/spacing_style/padding_style.dart';

class LoginCard extends StatelessWidget {
  final VoidCallback onTap;

  const LoginCard({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: TNPaddingStyle.allPadding,
        padding: TNPaddingStyle.allPadding,
        decoration: BoxDecoration(
          color: TNColors.grey,
          borderRadius: BorderRadius.circular(TNSizes.borderRadiusMD),
        ),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 48,
              backgroundColor: TNColors.white,
              child: Icon(
                LucideIcons.user,
                size: 48,
                color: TNColors.grey,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                "LOG IN OR SIGN UP",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
