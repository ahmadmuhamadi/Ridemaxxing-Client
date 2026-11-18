import 'package:flutter/material.dart';

import '../models/trip.dart';
import '../theme/app_theme.dart';
import 'glass.dart';
import 'initials_avatar.dart';
import 'primary_button.dart';
import 'route_marker.dart';

class UpcomingTripCard extends StatelessWidget {
  const UpcomingTripCard({
    required this.trip,
    required this.cancelled,
    required this.onCancel,
    required this.onUndo,
    super.key,
  });

  final UpcomingTrip trip;
  final bool cancelled;
  final VoidCallback onCancel;
  final VoidCallback onUndo;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final strong = TextStyle(fontWeight: FontWeight.w600, color: c.ink);
    final small = TextStyle(fontSize: 13, color: c.muted);
    final (status, statusBg, statusFg) = cancelled
        ? ('Cancelled', c.line, c.muted)
        : trip.confirmed
        ? ('Confirmed', c.primarySoft, c.primary)
        : ('Waiting for driver', c.goldSoft, c.gold);

    return Glass(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              SizedBox(
                width: 56,
                child: Column(
                  children: [
                    Text(trip.time, style: numStyle(28, c.ink)),
                    Text(trip.day, style: small),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: RouteMarker(),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(trip.from, style: strong),
                            const SizedBox(height: 6),
                            Text(trip.to, style: strong),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: statusBg,
                  borderRadius: BorderRadius.circular(Radii.pill),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: statusFg,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(height: 1, color: c.line),
          const SizedBox(height: 12),
          Row(
            children: [
              InitialsAvatar(trip.initials),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: '${trip.driver} ',
                        style: strong,
                        children: [
                          TextSpan(
                            text: '★ ${trip.rating}',
                            style: TextStyle(fontSize: 13, color: c.gold),
                          ),
                        ],
                      ),
                    ),
                    Text('${trip.seats}, ${trip.price}', style: small),
                  ],
                ),
              ),
              if (!cancelled)
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 36,
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: c.primarySoft,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Details',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: c.primary,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          if (!cancelled)
            Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    trip.live ? 'Track ride' : 'Message driver',
                    height: 44,
                    onPressed: () {},
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: onCancel,
                  child: Glass(
                    radius: 14,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SizedBox(
                      height: 44,
                      child: Center(
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: c.danger,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          else
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Booking cancelled. You weren't charged.",
                    style: small,
                  ),
                ),
                GestureDetector(
                  onTap: onUndo,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 6,
                    ),
                    child: Text(
                      'Undo',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: c.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
