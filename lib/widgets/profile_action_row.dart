import 'package:flutter/material.dart';

import '../theme/ride_colors.dart';

class ProfileActionRow extends StatelessWidget {
  const ProfileActionRow({
    required this.leading,
    required this.label,
    this.fontFamily = 'WorkSans',
    this.fontSize = 15,
    this.fontWeight = FontWeight.w800,
    super.key,
  });

  final Widget leading;
  final String label;
  final String fontFamily;
  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: const BoxDecoration(
        color: RideColors.paper,
        border: Border(
          bottom: BorderSide(color: RideColors.mustard, width: 1.5),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: Center(child: leading),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: fontSize,
                fontWeight: fontWeight,
                color: RideColors.asphalt,
                letterSpacing: 0.2,
              ),
            ),
          ),
          const Icon(
            Icons.chevron_right,
            color: RideColors.asphalt,
            size: 28,
          ),
        ],
      ),
    );
  }
}
