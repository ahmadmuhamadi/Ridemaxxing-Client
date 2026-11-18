import 'package:flutter/material.dart';

import '../models/trip.dart';
import '../theme/app_theme.dart';
import 'glass.dart';
import 'past_trip_row.dart';

/// Month stats card plus past trips grouped by the server's `group` field.
class PastTripsView extends StatelessWidget {
  const PastTripsView({
    required this.stats,
    required this.trips,
    required this.ratings,
    required this.onRate,
    super.key,
  });

  final MonthStats stats;
  final List<PastTrip> trips;
  final Map<String, int> ratings;
  final void Function(String id, int stars) onRate;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final groups = <String, List<PastTrip>>{};
    for (final t in trips) {
      groups.putIfAbsent(t.group, () => []).add(t);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Glass(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: IntrinsicHeight(
            child: Row(
              children: [
                _stat(c, stats.rides, 'Rides this month', c.ink, false),
                _stat(c, stats.spent, 'Spent', c.ink, true),
                _stat(c, stats.saved, 'Saved on gas', c.gold, true),
              ],
            ),
          ),
        ),
        for (final g in groups.entries) ...[
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              g.key,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: c.muted,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Glass(
            radius: 20,
            child: Column(
              children: [
                for (final (i, t) in g.value.indexed) ...[
                  if (i > 0) Container(height: 1, color: c.line),
                  PastTripRow(
                    trip: t,
                    rating: ratings[t.id] ?? t.rated,
                    onRate: (v) => onRate(t.id, v),
                  ),
                ],
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _stat(
    AppColors c,
    String value,
    String label,
    Color color,
    bool line,
  ) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(left: line ? 12 : 0),
        decoration: line
            ? BoxDecoration(
                border: Border(left: BorderSide(color: c.line)),
              )
            : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(value, style: numStyle(28, color)),
            Text(label, style: TextStyle(fontSize: 13, color: c.muted)),
          ],
        ),
      ),
    );
  }
}
