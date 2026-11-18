import 'package:flutter/material.dart';

import '../models/trip.dart';
import '../theme/app_theme.dart';
import 'initials_avatar.dart';

class PastTripRow extends StatelessWidget {
  const PastTripRow({
    required this.trip,
    required this.rating,
    required this.onRate,
    super.key,
  });

  final PastTrip trip;
  final int rating;
  final ValueChanged<int> onRate;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final strong = TextStyle(fontWeight: FontWeight.w600, color: c.ink);
    final small = TextStyle(fontSize: 13, color: c.muted);
    final driverFirst = trip.driver.split(' ').first;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              InitialsAvatar(trip.initials, size: 40),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(trip.route, style: strong),
                    Text('${trip.when} with ${trip.driver}', style: small),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Text(trip.price, style: strong),
            ],
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 52),
            child: rating == 0
                ? Row(
                    children: [
                      Text('Rate', style: small),
                      const SizedBox(width: 6),
                      for (var v = 1; v <= 5; v++)
                        GestureDetector(
                          onTap: () => onRate(v),
                          child: SizedBox.square(
                            dimension: 32,
                            child: Center(
                              child: Text(
                                '★',
                                style: TextStyle(fontSize: 22, color: c.line),
                              ),
                            ),
                          ),
                        ),
                    ],
                  )
                : Text.rich(
                    TextSpan(
                      style: const TextStyle(fontSize: 13),
                      children: [
                        TextSpan(
                          text: '★' * rating,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: c.gold,
                          ),
                        ),
                        TextSpan(
                          text: ' You rated $driverFirst',
                          style: TextStyle(color: c.muted),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
