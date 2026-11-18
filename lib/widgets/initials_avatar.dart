import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class InitialsAvatar extends StatelessWidget {
  const InitialsAvatar(this.initials, {this.size = 36, super.key});

  final String initials;
  final double size;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: c.primarySoft, shape: BoxShape.circle),
      child: Text(
        initials,
        style: TextStyle(
          fontSize: size * 0.36,
          fontWeight: FontWeight.w600,
          color: c.primary,
        ),
      ),
    );
  }
}
