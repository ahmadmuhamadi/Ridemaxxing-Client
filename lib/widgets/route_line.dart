import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class RouteLine extends StatelessWidget {
  const RouteLine({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _RoutePainter(context.colors));
  }
}

class _RoutePainter extends CustomPainter {
  _RoutePainter(this.c);
  final AppColors c;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(size.width / 390, size.height / 220);
    final path = Path()
      ..moveTo(84, 200)
      ..cubicTo(130, 200, 150, 130, 204, 110)
      ..cubicTo(258, 90, 290, 60, 316, 10);
    final line = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(
      path,
      line
        ..color = c.primary
        ..strokeWidth = 6,
    );

    line
      ..color = c.gold
      ..strokeWidth = 2;
    for (final m in path.computeMetrics()) {
      for (var d = 0.0; d < m.length; d += 12) {
        canvas.drawPath(m.extractPath(d, d + 5), line);
      }
    }

    canvas.drawCircle(const Offset(84, 200), 9, Paint()..color = c.surface);
    canvas.drawCircle(
      const Offset(84, 200),
      9,
      Paint()
        ..color = c.primary
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4,
    );
    final end = RRect.fromRectAndRadius(
      const Rect.fromLTWH(306, 0, 20, 20),
      const Radius.circular(5),
    );
    canvas.drawRRect(end, Paint()..color = c.ink);
    canvas.drawRRect(
      end,
      Paint()
        ..color = c.surface
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3,
    );
  }

  @override
  bool shouldRepaint(_RoutePainter old) => old.c != c;
}
