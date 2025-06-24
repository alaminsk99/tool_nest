import 'package:flutter/material.dart';
import 'package:tool_nest/core/constants/colors.dart';
import 'package:tool_nest/presentation/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';

class BackgroundContainer extends StatelessWidget {
  const BackgroundContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return CurvedEdgesWidget(
      clipBehavior: Clip.antiAlias,
      child: Container(
        height: 240,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: TNColors.cusClipperBack,
        ),
      ),
    );
  }
}
