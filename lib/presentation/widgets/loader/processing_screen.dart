import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:tool_nest/core/constants/colors.dart';
import 'package:tool_nest/core/constants/image_strings.dart';
import 'package:tool_nest/core/constants/sizes.dart';

class ProcessingScreen extends StatelessWidget {
  const ProcessingScreen({super.key, this.title, this.warningMessage});

  final String? title;
  final String? warningMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TNColors.primaryBackground,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: TNSizes.spaceLG),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// Lottie animation
              Lottie.asset(
                TNImageStrings.loadingAnimation,
                width: 150,
                height: 150,
              ),

              const Gap(TNSizes.spaceLG),
              if (title != null)
                Text(
                  title!,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: TNColors.black),
                ),
              const Gap(TNSizes.spaceSM),
              if (warningMessage != null)
                Text(
                  warningMessage!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: TNColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
