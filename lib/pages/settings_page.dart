import 'package:flutter/material.dart';

import '../theme/ride_colors.dart';
import '../widgets/ride_app_bar.dart';
import '../widgets/ride_bottom_navigation.dart';
import '../widgets/road_icon.dart';
import '../widgets/settings_row.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    required this.currentIndex,
    required this.onNavigate,
    super.key,
  });

  final int currentIndex;
  final ValueChanged<int> onNavigate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RideColors.paper,
      appBar: const RideAppBar(showAction: false),
      body: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 14),
              child: const Text(
                'Settings',
                style: TextStyle(
                  fontFamily: 'Overpass',
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                  color: RideColors.asphalt,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                child: Container(
                  decoration: BoxDecoration(
                    color: RideColors.paper,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: RideColors.mustard,
                      width: 1.5,
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      Expanded(
                        child: SettingsRow(
                          leading: Image.asset(
                            'assets/images/settings/edit_profile.png',
                            width: 24,
                            height: 24,
                            fit: BoxFit.contain,
                          ),
                          label: 'Edit Profile',
                          onTap: () {},
                        ),
                      ),
                      Expanded(
                        child: SettingsRow(
                          leading: Image.asset(
                            'assets/images/settings/privacy_security.png',
                            width: 24,
                            height: 24,
                            fit: BoxFit.contain,
                          ),
                          label: 'Privacy & Security',
                          onTap: () {},
                        ),
                      ),
                      Expanded(
                        child: SettingsRow(
                          leading: const RoadIcon(
                            width: 22,
                            height: 24,
                            color: RideColors.asphalt,
                          ),
                          label: 'Saved Locations',
                          onTap: () {},
                        ),
                      ),
                      Expanded(
                        child: SettingsRow(
                          leading: Image.asset(
                            'assets/images/settings/languages.png',
                            width: 24,
                            height: 24,
                            fit: BoxFit.contain,
                          ),
                          label: 'Languages',
                          onTap: () {},
                        ),
                      ),
                      Expanded(
                        child: SettingsRow(
                          leading: Image.asset(
                            'assets/images/settings/about.png',
                            width: 24,
                            height: 24,
                            fit: BoxFit.contain,
                          ),
                          label: 'About',
                          onTap: () {},
                        ),
                      ),
                      Expanded(
                        child: SettingsRow(
                          leading: Image.asset(
                            'assets/images/settings/logout.png',
                            width: 24,
                            height: 24,
                            fit: BoxFit.contain,
                          ),
                          label: 'Log out',
                          textColor: RideColors.logout,
                          showChevron: false,
                          hasBottomBorder: false,
                          onTap: () {},
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
      bottomNavigationBar: RideBottomNavigation(
        currentIndex: currentIndex,
        onTap: onNavigate,
      ),
    );
  }
}
