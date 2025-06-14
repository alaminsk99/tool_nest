import 'dart:typed_data';
import 'package:flutter/material.dart';


class SelectImageContainerWithImageCode extends StatelessWidget {
  final Uint8List imageBytes;

  const SelectImageContainerWithImageCode({super.key, required this.imageBytes});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.memory(
          imageBytes,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}