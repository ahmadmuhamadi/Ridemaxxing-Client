import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'glass.dart';

class AppChip extends StatelessWidget {
  const AppChip(this.label, {this.icon, this.onTap, super.key});

  final String label;
  final IconData? icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return GestureDetector(
      onTap: onTap,
      child: Glass(
        radius: Radii.pill,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 18, color: c.gold),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: c.ink,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
