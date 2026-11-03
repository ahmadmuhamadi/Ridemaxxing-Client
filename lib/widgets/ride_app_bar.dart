import 'package:flutter/material.dart';

import '../theme/ride_colors.dart';

class RideAppBar extends StatelessWidget implements PreferredSizeWidget {
  const RideAppBar({
    this.showBackArrow = false,
    this.showAction = true,
    super.key,
  });

  final bool showBackArrow;
  final bool showAction;

  @override
  Size get preferredSize => const Size.fromHeight(76);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: preferredSize.height,
      backgroundColor: RideColors.cream,
      elevation: 0,
      scrolledUnderElevation: 0,
      leadingWidth: 62,
      leading: Padding(
        padding: const EdgeInsets.all(8),
        child: Image.asset(
          'assets/images/Route66.png',
          fit: BoxFit.contain,
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
      actions: showAction
          ? [
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 0, 16, 0),
                child: showBackArrow
                    ? const Icon(
                        Icons.arrow_back,
                        size: 28,
                        color: RideColors.asphalt,
                      )
                    : Container(
                        width: 44,
                        height: 44,
                        decoration: const BoxDecoration(
                          color: RideColors.turquoise,
                          shape: BoxShape.circle,
                          border: Border.fromBorderSide(
                            BorderSide(color: RideColors.mustard, width: 3),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'WW',
                          style: TextStyle(
                            fontFamily: 'Rye',
                            fontSize: 14,
                            color: RideColors.asphalt,
                          ),
                        ),
                      ),
              ),
            ]
          : null,
    );
  }
}
