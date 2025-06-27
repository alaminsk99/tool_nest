import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:tool_nest/core/constants/image_strings.dart';
import 'package:tool_nest/core/constants/sizes.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/presentation/widgets/buttons/widgets_with_elevated_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            /// Main content centered
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Logo (optional)
                    // Image.asset(TNImageStrings.logo, width: 100, height: 100),

                    Text(
                      TNTextStrings.appName,
                      style: textTheme.headlineLarge,
                    ),
                    Gap(TNSizes.spaceBetweenItems),
                    Text(
                      TNTextStrings.loginSlog,
                      textAlign: TextAlign.center,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Gap(TNSizes.spaceBetweenSections),
                    WidgetsWithElevatedButton(
                      title: TNTextStrings.google,
                      child: Image.asset(
                        TNImageStrings.google,
                        width: 20,
                        height: 20,
                      ),
                      onPressed: onPressed,
                    ),
                  ],
                ),
              ),
            ),

            /// Close icon in top-right
            Positioned(
              top: 16,
              right: 16,
              child: IconButton(
                onPressed: () => context.pop(), // GoRouter pop
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
