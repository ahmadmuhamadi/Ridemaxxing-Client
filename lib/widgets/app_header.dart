import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'glass.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  const AppHeader({
    this.avatar = false,
    this.initials,
    this.onAvatar,
    super.key,
  });

  final bool avatar;
  final String? initials;
  final VoidCallback? onAvatar;

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      color: c.bg,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: Row(
            children: [
              Image.asset('assets/images/Route66.png', width: 30, height: 33),
              const SizedBox(width: 10),
              Glass(
                radius: Radii.pill,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Text('RideMaxxing', style: numStyle(20, c.ink)),
              ),
              const Spacer(),
              if (avatar)
                GestureDetector(
                  onTap: onAvatar,
                  child: Glass(
                    radius: 22,
                    child: SizedBox.square(
                      dimension: 42,
                      child: Center(
                        child: initials == null
                            ? Icon(Icons.person_outline, size: 20, color: c.ink)
                            : Text(
                                initials!,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: c.ink,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
