import 'package:flutter/material.dart';
import 'curved_edge.dart';

class CurvedEdgesWidget extends StatelessWidget {
  final Widget? child;
  final Clip clipBehavior;

  const CurvedEdgesWidget({
    super.key,
    this.child,
    this.clipBehavior = Clip.antiAlias,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomCurvedEdgesWithContainer(),
      clipBehavior: clipBehavior,
      child: child!,
    );
  }
}
