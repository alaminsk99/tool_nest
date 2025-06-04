import 'package:flutter/material.dart';
import 'package:tool_nest/presentation/styles/spacing_style/padding_style.dart';

class ToolSectionHeader extends StatelessWidget {
  final String title;
  const ToolSectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:TNPaddingStyle.onlyVerticalSMPadding,
      child: Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }
}
