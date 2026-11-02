import 'package:flutter/material.dart';

import '../theme/ride_colors.dart';

class ProfileStatCard extends StatelessWidget {
  const ProfileStatCard({required this.value, required this.label, super.key});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 62,
        decoration: BoxDecoration(
          color: RideColors.rust,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: RideColors.asphalt, width: 2),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Bungee',
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: RideColors.paper,
                height: 1.0,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Bungee',
                fontSize: 10,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.5,
                color: RideColors.paper,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
