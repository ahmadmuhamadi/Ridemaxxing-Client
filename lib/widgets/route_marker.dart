import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class RouteMarker extends StatelessWidget {
  const RouteMarker({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return SizedBox(
      width: 14,
      child: Column(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: c.primary, width: 3),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: CustomPaint(
                size: const Size(2, double.infinity),
                painter: _DashPainter(c.gold),
              ),
            ),
          ),
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: c.ink,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        ],
      ),
    );
  }
}

class _DashPainter extends CustomPainter {
  _DashPainter(this.color);
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    for (var y = 0.0; y < size.height; y += 9) {
      canvas.drawRect(
        Rect.fromLTWH(0, y, 2, math.min(5, size.height - y)),
        Paint()..color = color,
      );
    }
  }

  @override
  bool shouldRepaint(_DashPainter old) => old.color != color;
}
