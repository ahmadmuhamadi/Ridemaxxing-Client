import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'glass.dart';
import 'road_icon.dart';

class RiderTabBar extends StatelessWidget {
  const RiderTabBar({
    required this.current,
    required this.onTap,
    this.unreadAlerts = 0,
    super.key,
  });

  final int current;
  final ValueChanged<int> onTap;
  final int unreadAlerts;

  static const _labels = ['Find', 'Rides', 'Alerts', 'Profile'];

  Widget _icon(int i, Color color) => switch (i) {
    0 => Icon(Icons.search, size: 22, color: color),
    1 => RoadIcon(width: 22, height: 22, color: color),
    2 => Icon(Icons.notifications_none, size: 22, color: color),
    _ => Icon(Icons.person_outline, size: 22, color: color),
  };

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return SafeArea(
      minimum: const EdgeInsets.fromLTRB(12, 0, 12, 22),
      child: Glass(
        radius: 30,
        padding: const EdgeInsets.all(6),
        child: Row(
          children: [
            for (var i = 0; i < _labels.length; i++)
              Expanded(
                child: GestureDetector(
                  onTap: () => onTap(i),
                  child: Container(
                    height: 54,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: i == current ? c.primarySoft : null,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            _icon(i, i == current ? c.primary : c.muted),
                            if (i == 2 && unreadAlerts > 0)
                              Positioned(
                                top: -5,
                                right: -9,
                                child: _Badge(unreadAlerts),
                              ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _labels[i],
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: i == current ? c.primary : c.muted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge(this.count);

  final int count;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      constraints: const BoxConstraints(minWidth: 17),
      height: 17,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: c.primary,
        borderRadius: BorderRadius.circular(Radii.pill),
        border: Border.all(color: c.surface, width: 2),
      ),
      alignment: Alignment.center,
      child: Text(
        '$count',
        style: TextStyle(
          fontSize: 11,
          height: 1,
          fontWeight: FontWeight.w700,
          color: c.onPrimary,
        ),
      ),
    );
  }
}
