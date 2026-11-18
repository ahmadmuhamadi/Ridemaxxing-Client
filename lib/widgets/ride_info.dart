import 'package:flutter/material.dart';

import '../models/ride_detail.dart';
import '../theme/app_theme.dart';
import 'app_chip.dart';
import 'glass.dart';
import 'ride_stops_card.dart';

/// Driver, trip, car, rules and reviews shown in the ride details sheet.
class RideInfo extends StatelessWidget {
  const RideInfo({required this.ride, super.key});

  final RideDetail ride;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final r = ride;
    final small = TextStyle(fontSize: 13, color: c.muted);
    final strong = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: c.ink,
    );
    final title = small.copyWith(fontWeight: FontWeight.w600);
    final rows = [
      ('Car', r.car, c.ink),
      ('Seats left', r.seatsLeft, c.ink),
      ('Booking', r.booking, r.instant ? c.primary : c.ink),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Container(
              width: 56,
              height: 56,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: c.primarySoft,
                shape: BoxShape.circle,
              ),
              child: Text(
                r.initials,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: c.primary,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    r.driver,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: c.ink,
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      style: small,
                      children: [
                        TextSpan(
                          text: '★ ${r.rating}',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: c.gold,
                          ),
                        ),
                        TextSpan(text: ' from ${r.driverRides} rides'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (r.verified)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: c.goldSoft,
                  borderRadius: BorderRadius.circular(Radii.pill),
                ),
                child: Row(
                  children: [
                    Icon(Icons.check, size: 12, color: c.gold),
                    const SizedBox(width: 4),
                    Text(
                      'ID verified',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: c.gold,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        const SizedBox(height: 16),
        RideStopsCard(ride: r),
        const SizedBox(height: 16),
        Glass(
          radius: 20,
          child: Column(
            children: [
              for (final (i, (label, value, color)) in rows.indexed)
                Container(
                  constraints: const BoxConstraints(minHeight: 54),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: i == 0
                      ? null
                      : BoxDecoration(
                          border: Border(top: BorderSide(color: c.line)),
                        ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(label, style: TextStyle(color: c.muted)),
                      ),
                      Text(value, style: strong.copyWith(color: color)),
                    ],
                  ),
                ),
            ],
          ),
        ),
        if (r.rules.isNotEmpty) ...[
          const SizedBox(height: 16),
          Text("${r.driver.split(' ').first}'s ride rules", style: title),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [for (final rule in r.rules) AppChip(rule)],
          ),
        ],
        if (r.reviews.isNotEmpty) ...[
          const SizedBox(height: 16),
          Text('Recent reviews', style: title),
          for (final rv in r.reviews) ...[
            const SizedBox(height: 8),
            Glass(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      style: small,
                      children: [
                        TextSpan(
                          text: '★' * rv.stars,
                          style: TextStyle(color: c.gold),
                        ),
                        TextSpan(
                          text: ' ${rv.name}',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: c.ink,
                          ),
                        ),
                        TextSpan(text: ' · ${rv.when}'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(rv.text, style: TextStyle(fontSize: 16, color: c.ink)),
                ],
              ),
            ),
          ],
        ],
        const SizedBox(height: 16),
        Text(
          'Free cancellation up to 1 hour before pickup. '
          'Your payment is held until the ride ends.',
          style: small,
        ),
      ],
    );
  }
}
