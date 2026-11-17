import 'dart:ui';

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class Glass extends StatelessWidget {
  const Glass({
    required this.child,
    this.radius = Radii.card,
    this.padding = EdgeInsets.zero,
    this.topOnly = false,
    super.key,
  });

  final Widget child;
  final double radius;
  final EdgeInsets padding;
  final bool topOnly;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final r = topOnly
        ? BorderRadius.vertical(top: Radius.circular(radius))
        : BorderRadius.circular(radius);
    return ClipRRect(
      borderRadius: r,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: c.glass,
            borderRadius: r,
            border: Border.all(color: c.edge),
          ),
          child: child,
        ),
      ),
    );
  }
}
