import 'package:flutter/material.dart';
import 'package:tool_nest/core/constants/colors.dart';
import 'package:tool_nest/presentation/styles/spacing_style/padding_style.dart';


class ProgressIndicatorForAll extends StatelessWidget {
  const ProgressIndicatorForAll({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: TNColors.primary,
      padding: TNPaddingStyle.allPadding,
    );
  }
}
