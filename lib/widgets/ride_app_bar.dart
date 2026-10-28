import 'package:flutter/material.dart';

import '../theme/ride_colors.dart';

class RideAppBar extends StatelessWidget implements PreferredSizeWidget {
  const RideAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(76);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: preferredSize.height,
      backgroundColor: RideColors.cream,
      leadingWidth: 62,
      leading: Padding(
        padding: const EdgeInsets.all(8),
        child: Image.asset(
          'assets/images/route66.png',
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.broken_image_outlined, color: RideColors.rust),
        ),
      ),
      title: const Text(
        'Ride\nmaxxing',
        style: TextStyle(
          fontFamily: 'Rye',
          fontSize: 19,
          height: 1.05,
          color: RideColors.asphalt,
        ),
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.fromLTRB(4, 0, 16, 0),
          child: CircleAvatar(
            radius: 22,
            backgroundColor: RideColors.turquoise,
            foregroundColor: RideColors.asphalt,
            child: Text(
              'WW',
              style: TextStyle(
                fontFamily: 'Rye',
                fontSize: 14,
                color: RideColors.asphalt,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
