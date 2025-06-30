import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:toolest/config/router/route_paths.dart';
import 'package:toolest/core/constants/colors.dart';
import 'package:toolest/core/constants/sizes.dart';
import 'package:toolest/core/constants/text_strings.dart';
import 'package:toolest/core/utils/helper/helper_functions.dart';

class ProfilePage extends StatelessWidget {
  final String? name;
  final String? email;
  final String? photoUrl;


  const ProfilePage({
    super.key,
    required this.name,
    required this.email,
    this.photoUrl,

  });

  @override
  Widget build(BuildContext context) {
    final bool isLoggedIn = name != null && email != null;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: TNColors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: TNSizes.spaceLG,
          vertical: TNSizes.spaceXL,
        ),
        child: isLoggedIn
            ? Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FutureBuilder<bool>(
              future: TNHelperFunctions.isDeviceOnline(),
              builder: (context, snapshot) {
                final isOnline = snapshot.data ?? true;

                return CircleAvatar(
                  radius: 42,
                  backgroundColor: TNColors.lightGrey,
                  backgroundImage:
                  (photoUrl != null && isOnline) ? NetworkImage(photoUrl!) : null,
                  child: (photoUrl == null || !isOnline)
                      ? const Icon(
                    LucideIcons.user,
                    size: 48,
                    color: TNColors.grey,
                  )
                      : null,
                );
              },
            ),
            const Gap(TNSizes.spaceLG),
            Text(
              name!,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Text(
              email!,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: TNColors.darkerGrey),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        )
            : Column(
          mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: (){
                    TNHelperFunctions.navigateToScreenAndBack(context, AppRoutes.loginOptionsPages);
                    context.pop();
                    },
                  child: Center(
                            child: Text(
                  TNTextStrings.logInSignUp,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: TNColors.primary,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                            ),
                          ),
                ),
              ],
            ),
      ),
    );
  }
}
