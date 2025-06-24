import 'package:flutter/material.dart';

class CustomCurvedEdgesWithContainer extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // Start from top left
    path.lineTo(0, size.height * 0.65);

    // First smooth curve to center
    path.quadraticBezierTo(
      size.width * 0.25, size.height * 0.95,
      size.width * 0.6, size.height * 0.55,
    );

    // Second smooth curve to right side
    path.quadraticBezierTo(
      size.width * 0.9, size.height * 0.2424,
      size.width, size.height * 0.5,
    );

    // Top-right corner
    path.lineTo(size.width, 0);

    // Close the path
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
