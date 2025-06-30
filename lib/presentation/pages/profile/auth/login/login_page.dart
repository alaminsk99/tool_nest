
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:tool_nest/core/constants/image_strings.dart';
import 'package:tool_nest/core/constants/sizes.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/presentation/widgets/buttons/widgets_with_elevated_button.dart';

class LoginPage extends StatelessWidget {
  final VoidCallback onGoogleSignIn;

  const LoginPage({
    super.key,
    required this.onGoogleSignIn,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      TNTextStrings.appName,
                      style: textTheme.headlineLarge,
                    ),
                    const Gap(TNSizes.spaceBetweenItems),
                    Text(
                      TNTextStrings.loginSlog,
                      textAlign: TextAlign.center,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Gap(TNSizes.spaceBetweenSections),
                    WidgetsWithElevatedButton(
                      title: TNTextStrings.google,
                      onPressed: onGoogleSignIn,
                      child: Image.asset(
                        TNImageStrings.google,
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 16,
              right: 16,
              child: IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(LucideIcons.x),
                tooltip: "Close",
              ),
            ),
          ],
        ),
      ),
    );
  }
}