import 'package:flutter/material.dart';

import '../models/ride.dart';
import '../theme/app_theme.dart';
import '../widgets/ride_card.dart';

/// Placeholder until the Ride details screen is designed and built.
class RideDetailsPage extends StatelessWidget {
  const RideDetailsPage({required this.ride, super.key});

  final Ride ride;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: c.bg,
        foregroundColor: c.ink,
        scrolledUnderElevation: 0,
        title: const Text('Ride details'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [RideCard(ride)],
      ),
    );
  }
}
