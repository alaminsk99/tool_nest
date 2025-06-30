import 'package:flutter/material.dart';
import 'package:toolest/core/constants/colors.dart';
import 'package:toolest/presentation/styles/spacing_style/padding_style.dart';

class ProgressIndicatorForAll extends StatelessWidget {
  const ProgressIndicatorForAll({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: TNPaddingStyle.allPadding,
        child: CircularProgressIndicator(
          color: TNColors.primary,
        ),
      ),
    );
  }
}
