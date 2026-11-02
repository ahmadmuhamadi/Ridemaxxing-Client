import 'package:flutter/material.dart';

import '../theme/ride_colors.dart';

class RoadIcon extends StatelessWidget {
  const RoadIcon({
    this.width = 24,
    this.height = 24,
    this.color = RideColors.asphalt,
    super.key,
  });

  final double width;
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, height),
      painter: _RoadPainter(color),
    );
  }
}

class _RoadPainter extends CustomPainter {
  const _RoadPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final borderPaint = Paint()
      ..color = color
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(size.width * 0.32, 1),
      Offset(size.width * 0.12, size.height - 1),
      borderPaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.68, 1),
      Offset(size.width * 0.88, size.height - 1),
      borderPaint,
    );
    final dashPaint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.square;

    final dashH = (size.height - 6) / 3;
    canvas.drawLine(
      Offset(size.width * 0.5, 2),
      Offset(size.width * 0.5, 2 + dashH),
      dashPaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.5, 4 + 2 * dashH),
      Offset(size.width * 0.5, 4 + 3 * dashH),
      dashPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _RoadPainter oldDelegate) => oldDelegate.color != color;
}
