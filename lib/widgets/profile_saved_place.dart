import 'package:flutter/material.dart';

import '../theme/ride_colors.dart';

class ProfileSavedPlace extends StatelessWidget {
  const ProfileSavedPlace({
    required this.label,
    required this.icon,
    super.key,
  });

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 38,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: RideColors.mustard,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: RideColors.asphalt, width: 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: RideColors.asphalt, size: 20),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: 'WorkSans',
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                  color: RideColors.asphalt,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
