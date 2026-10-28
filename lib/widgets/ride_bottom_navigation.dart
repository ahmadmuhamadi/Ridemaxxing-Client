import 'package:flutter/material.dart';

import '../theme/ride_colors.dart';

const _navigationLabelStyle = TextStyle(
  fontFamily: 'WorkSans',
  fontWeight: FontWeight.w900,
);

class RideBottomNavigation extends StatelessWidget {
  const RideBottomNavigation({
    required this.currentIndex,
    required this.onTap,
    super.key,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      backgroundColor: RideColors.desertSand,
      selectedItemColor: RideColors.rust,
      unselectedItemColor: RideColors.asphalt,
      selectedLabelStyle: _navigationLabelStyle,
      unselectedLabelStyle: _navigationLabelStyle,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.add_road), label: 'Trip'),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Profile',
        ),
      ],
    );
  }
}
