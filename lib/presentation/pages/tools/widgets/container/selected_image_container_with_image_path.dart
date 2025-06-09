
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tool_nest/core/constants/sizes.dart';

class SelectedImageContainerWithPath extends StatelessWidget {
  const SelectedImageContainerWithPath({
    super.key,
    required this.height,
    required this.imagePath,
  });

  final double height;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(

      borderRadius: BorderRadius.circular(TNSizes.borderRadiusSM),
      child: SizedBox(
        height: height,
        child: Image.file(
          File(imagePath),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}