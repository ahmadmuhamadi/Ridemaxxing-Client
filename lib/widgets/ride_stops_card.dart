import 'package:flutter/material.dart';

import '../models/ride_detail.dart';
import '../theme/app_theme.dart';
import 'glass.dart';
import 'route_marker.dart';

class RideStopsCard extends StatelessWidget {
  const RideStopsCard({required this.ride, super.key});

  final RideDetail ride;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Glass(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(ride.summary, style: TextStyle(fontSize: 13, color: c.muted)),
          const SizedBox(height: 12),
          IntrinsicHeight(
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 6),
                  child: RouteMarker(),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    children: [
                      _stop(c, ride.pickup),
                      const SizedBox(height: 16),
                      _stop(c, ride.dropoff),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _stop(AppColors c, RideStop s) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 46, child: Text(s.time, style: numStyle(22, c.ink))),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                s.place,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: c.ink,
                ),
              ),
              Text(s.note, style: TextStyle(fontSize: 13, color: c.muted)),
            ],
          ),
        ),
      ],
    );
  }
}
