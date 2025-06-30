import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:toolest/core/constants/sizes.dart';

class SelectImageContainerWithImageCode extends StatelessWidget {
  final Uint8List imageBytes;

  const SelectImageContainerWithImageCode({
    super.key,
    required this.imageBytes,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final maxHeight = constraints.maxHeight;

        return Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(TNSizes.borderRadiusSM),
            child: Image.memory(
              imageBytes,
              fit: BoxFit.contain,
              width: maxWidth,
              height: maxHeight>=500?500: maxHeight,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.broken_image, size: 40, color: Colors.grey);
              },
            ),
          ),
        );
      },
    );
  }
}
