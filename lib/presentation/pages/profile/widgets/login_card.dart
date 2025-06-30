import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:tool_nest/core/constants/colors.dart';
import 'package:tool_nest/core/constants/sizes.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/core/utils/helper/helper_functions.dart';
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
            FutureBuilder<bool>(
              future: TNHelperFunctions.isDeviceOnline(),
              builder: (context, snapshot) {
                final isOnline = snapshot.data ?? true;

                return CircleAvatar(
                  radius: 32,
                  backgroundColor: TNColors.white,
                  backgroundImage: (isLoggedIn && photoUrl != null && isOnline)
                      ? NetworkImage(photoUrl!)
                      : null,
                  child: (!isLoggedIn || !isOnline || photoUrl == null)
                      ? const Icon(
                    LucideIcons.user,
                    size: 36,
                    color: TNColors.grey,
                  )
                      : null,
                );
              },
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
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email!,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: TNColors.darkerGrey),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              )
                  : Text(
                TNTextStrings.logInSignUp,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: TNColors.primary,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
