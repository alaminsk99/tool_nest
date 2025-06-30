
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:toolest/core/constants/colors.dart';
import 'package:toolest/core/constants/sizes.dart';

class ResultCard extends StatelessWidget {
  const ResultCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: TNColors.lightContainer,
          borderRadius: BorderRadius.circular(TNSizes.borderRadiusLG),
          boxShadow: [
            BoxShadow(
              color: TNColors.black.withOpacity(0.05),
              blurRadius: 3,
              offset: const Offset(0, 1),
            )
          ],
        ),
        child: const Center(
          child: Icon(LucideIcons.fileText, size: 80, color: TNColors.primary),
        ),
      ),
    );
  }
}