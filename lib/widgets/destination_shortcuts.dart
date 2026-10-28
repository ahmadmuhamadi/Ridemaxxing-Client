import 'package:flutter/material.dart';

import '../theme/ride_colors.dart';
import 'route_card.dart';

class DestinationShortcuts extends StatelessWidget {
  const DestinationShortcuts({
    required this.selectedPlace,
    required this.onSelected,
    super.key,
  });

  final String? selectedPlace;
  final ValueChanged<String> onSelected;

  static const _destinations = [
    (label: 'Home', icon: Icons.home_outlined),
    (label: 'Park', icon: Icons.park_outlined),
    (label: 'Beach', icon: Icons.beach_access_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Again?',
          style: TextStyle(
            fontFamily: 'Overpass',
            fontSize: 32,
            height: 1.1,
            color: RideColors.asphalt,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            for (var i = 0; i < _destinations.length; i++) ...[
              if (i > 0) const SizedBox(width: 12),
              Expanded(
                child: _DestinationShortcut(
                  label: _destinations[i].label,
                  icon: _destinations[i].icon,
                  selected: selectedPlace == _destinations[i].label,
                  onTap: () => onSelected(_destinations[i].label),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}

class _DestinationShortcut extends StatelessWidget {
  const _DestinationShortcut({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: OutlinedCard(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 4),
          borderColor: selected ? RideColors.rust : RideColors.mustard,
          borderWidth: selected ? 2 : 1,
          backgroundColor: RideColors.desertSand,
          child: Column(
            children: [
              Icon(icon, size: 30, color: RideColors.asphalt),
              const SizedBox(height: 4),
              Text(
                label,
                style: const TextStyle(
                  fontFamily: 'WorkSans',
                  fontSize: 15,
                  color: RideColors.rust,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
