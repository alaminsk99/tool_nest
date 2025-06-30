// lib/presentation/pages/profile/widgets/login_card.dart
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:tool_nest/core/constants/colors.dart';
import 'package:tool_nest/core/constants/sizes.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/presentation/styles/spacing_style/padding_style.dart';

class AuthCard extends StatelessWidget {
  final VoidCallback onTap;
  final String? userName;
  final String? email;
  final String? photoUrl;

  const AuthCard({
    super.key,
    required this.onTap,
    this.userName,
    this.email,
    this.photoUrl,
  });

  @override
  Widget build(BuildContext context) {
    final bool isLoggedIn = userName != null && email != null;

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
            CircleAvatar(
              radius: 32,
              backgroundColor: TNColors.white,
              backgroundImage: photoUrl != null ? NetworkImage(photoUrl!) : null,
              child: isLoggedIn
                  ? null
                  : const Icon(
                LucideIcons.user,
                size: 36,
                color: TNColors.grey,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: isLoggedIn
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName!,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email!,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(
                      color: TNColors.darkerGrey,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    TNTextStrings.edtProfile,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(
                      color:TNColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
                  : Text(
                TNTextStrings.logInSignUp,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(
                  color: TNColors.primary,
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