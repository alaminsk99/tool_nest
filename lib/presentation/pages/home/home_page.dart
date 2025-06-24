import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:tool_nest/core/constants/colors.dart';
import 'package:tool_nest/core/constants/sizes.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/presentation/pages/home/widgets/appbar/home_appbar.dart';
import 'package:tool_nest/presentation/styles/spacing_style/padding_style.dart';
import 'package:tool_nest/presentation/widgets/custom_shapes/container/background_container.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TNColors.primaryBackground,
      body: Stack(
        children: [
          /// Background shape
          const BackgroundContainer(),

          /// Foreground: AppBar + Scrollable Content
          Column(
            children: [
              const HomeAppbar(),

              Expanded(
                child: SingleChildScrollView(
                  padding: TNPaddingStyle.allPadding,
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gap(TNSizes.spaceBetweenSections),

                      /// Title Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Recent Files',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: TNColors.textPrimary,
                            ),
                          ),
                        ],
                      ),

                      Gap(TNSizes.spaceBetweenSections),

                      /// Tabs
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          _TabButton(label: "Downloads", selected: true),
                          _TabButton(label: "Opened"),
                          _TabButton(label: "Processed"),
                        ],
                      ),

                      Gap(TNSizes.spaceBetweenSections * 2),

                      /// Placeholder for file cards
                      SizedBox(
                        height: 180,
                        child: Center(
                          child: Text(
                            'No recent files yet.',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: TNColors.textSecondary),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String label;
  final bool selected;

  const _TabButton({required this.label, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      backgroundColor: selected ? TNColors.primary : TNColors.secondary,
      labelStyle: TextStyle(
        color: selected ? TNColors.textWhite : TNColors.textPrimary,
        fontWeight: FontWeight.w500,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }
}
