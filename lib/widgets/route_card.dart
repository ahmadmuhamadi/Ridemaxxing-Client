import 'package:flutter/material.dart';

import '../theme/ride_colors.dart';

class RouteCard extends StatelessWidget {
  const RouteCard({
    required this.fromLocation,
    required this.toLocation,
    required this.onSwap,
    required this.onRide,
    super.key,
  });

  final String fromLocation;
  final String toLocation;
  final VoidCallback onSwap;
  final VoidCallback onRide;

  @override
  Widget build(BuildContext context) {
    return OutlinedCard(
      padding: const EdgeInsets.all(14),
      radius: 20,
      borderColor: RideColors.mustard,
      child: Column(
        children: [
          _RouteStop(
            label: 'FROM',
            location: fromLocation,
            markerColor: RideColors.turquoise,
            isDestination: false,
          ),
          SizedBox(
            height: 44,
            child: Row(
              children: [
                const SizedBox(
                  width: 18,
                  child: Center(
                    child: SizedBox(
                      height: 40,
                      width: 3,
                      child: CustomPaint(painter: _DashedLinePainter()),
                    ),
                  ),
                ),
                const Spacer(),
                IconButton(
                  tooltip: 'Switch directions',
                  onPressed: onSwap,
                  style: IconButton.styleFrom(
                    foregroundColor: RideColors.asphalt,
                    side: const BorderSide(color: RideColors.asphalt),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  icon: const Icon(Icons.swap_vert),
                ),
              ],
            ),
          ),
          _RouteStop(
            label: 'TO',
            location: toLocation,
            markerColor: RideColors.rust,
            isDestination: true,
          ),
          const SizedBox(height: 14),
          const Row(
            children: [
              Expanded(flex: 3, child: _TripDetail(text: 'Today  -  9:31')),
              SizedBox(width: 12),
              Expanded(flex: 2, child: _TripDetail(text: '2 Seats')),
            ],
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: onRide,
              style: FilledButton.styleFrom(
                backgroundColor: RideColors.rust,
                foregroundColor: RideColors.paper,
                padding: const EdgeInsets.symmetric(vertical: 13),
                side: const BorderSide(color: RideColors.asphalt),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text(
                'RIDE MAXXING',
                style: TextStyle(
                  fontFamily: 'Bungee',
                  fontSize: 20,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RouteStop extends StatelessWidget {
  const _RouteStop({
    required this.label,
    required this.location,
    required this.markerColor,
    required this.isDestination,
  });

  final String label;
  final String location;
  final Color markerColor;
  final bool isDestination;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 18,
          child: Center(
            child: Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: isDestination ? markerColor : Colors.transparent,
                border: Border.all(color: markerColor, width: 2.5),
                borderRadius: BorderRadius.circular(isDestination ? 4 : 20),
              ),
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontFamily: 'WorkSans',
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: RideColors.dustyBrown,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                location,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: 'WorkSans',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: RideColors.asphalt,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TripDetail extends StatelessWidget {
  const _TripDetail({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return OutlinedCard(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
      borderColor: RideColors.dustyBrown,
      backgroundColor: RideColors.desertSand,
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'WorkSans',
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: RideColors.dustyBrown,
          ),
        ),
      ),
    );
  }
}

class OutlinedCard extends StatelessWidget {
  const OutlinedCard({
    required this.child,
    required this.padding,
    this.radius = 13,
    this.borderColor = RideColors.mustard,
    this.borderWidth = 1,
    this.backgroundColor = RideColors.paper,
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radius;
  final Color borderColor;
  final double borderWidth;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: borderColor, width: borderWidth),
      ),
      child: child,
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  const _DashedLinePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = RideColors.mustard
      ..strokeWidth = size.width
      ..strokeCap = StrokeCap.round;
    const dashHeight = 5.0;
    const gap = 5.0;
    for (var y = 0.0; y < size.height; y += dashHeight + gap) {
      canvas.drawLine(
        Offset(size.width / 2, y),
        Offset(size.width / 2, (y + dashHeight).clamp(0, size.height)),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _DashedLinePainter oldDelegate) => false;
}
