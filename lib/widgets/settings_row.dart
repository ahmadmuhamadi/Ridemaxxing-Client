import 'package:flutter/material.dart';

import '../theme/ride_colors.dart';

class SettingsRow extends StatelessWidget {
  const SettingsRow({
    required this.leading,
    required this.label,
    this.textColor = RideColors.asphalt,
    this.showChevron = true,
    this.hasBottomBorder = true,
    this.onTap,
    super.key,
  });

  final Widget leading;
  final String label;
  final Color textColor;
  final bool showChevron;
  final bool hasBottomBorder;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: RideColors.paper,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            border: hasBottomBorder
                ? const Border(
                    bottom: BorderSide(color: RideColors.mustard, width: 1.5),
                  )
                : null,
          ),
          child: Row(
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Center(child: leading),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontFamily: 'Overpass',
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    color: textColor,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
              if (showChevron)
                const Icon(
                  Icons.chevron_right,
                  color: RideColors.asphalt,
                  size: 28,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
