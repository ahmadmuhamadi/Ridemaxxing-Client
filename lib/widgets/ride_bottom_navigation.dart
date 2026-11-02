import 'package:flutter/material.dart';

import '../theme/ride_colors.dart';
import 'road_icon.dart';

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
    return Container(
      color: RideColors.cream,
      padding: const EdgeInsets.only(top: 6, bottom: 6),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            _buildItem(
              index: 0,
              icon: Icon(
                Icons.home_outlined,
                size: 28,
                color: currentIndex == 0 ? RideColors.rust : RideColors.asphalt,
              ),
              label: 'Home',
            ),
            _buildItem(
              index: 1,
              icon: RoadIcon(
                width: 24,
                height: 26,
                color: currentIndex == 1 ? RideColors.rust : RideColors.asphalt,
              ),
              label: 'Trip',
            ),
            _buildItem(
              index: 2,
              icon: Icon(
                Icons.settings_outlined,
                size: 28,
                color: currentIndex == 2 ? RideColors.rust : RideColors.asphalt,
              ),
              label: 'Settings',
            ),
            _buildItem(
              index: 3,
              icon: Icon(
                Icons.person_outline,
                size: 28,
                color: currentIndex == 3 ? RideColors.rust : RideColors.asphalt,
              ),
              label: 'profile',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem({
    required int index,
    required Widget icon,
    required String label,
  }) {
    final isSelected = currentIndex == index;
    final color = isSelected ? RideColors.rust : RideColors.asphalt;

    return Expanded(
      child: Semantics(
        button: true,
        selected: isSelected,
        label: label,
        child: InkWell(
          onTap: () => onTap(index),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 28,
                  child: Center(child: icon),
                ),
                const SizedBox(height: 2),
                Text(
                  label,
                  style: TextStyle(
                    fontFamily: 'WorkSans',
                    fontSize: 13,
                    height: 1,
                    fontWeight: FontWeight.w900,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
