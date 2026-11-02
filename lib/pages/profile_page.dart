import 'package:flutter/material.dart';

import '../theme/ride_colors.dart';
import '../widgets/profile_action_row.dart';
import '../widgets/profile_saved_place.dart';
import '../widgets/profile_stat_card.dart';
import '../widgets/ride_app_bar.dart';
import '../widgets/ride_bottom_navigation.dart';
import '../widgets/road_icon.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    required this.currentIndex,
    required this.onNavigate,
    super.key,
  });

  final int currentIndex;
  final ValueChanged<int> onNavigate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RideColors.cream,
      appBar: const RideAppBar(showBackArrow: true),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Container(
              color: RideColors.cream,
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
              child: Row(
                children: [
                  Container(
                    width: 70,
                    height: 70,
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
                        fontSize: 18,
                        color: RideColors.asphalt,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Walter W.',
                          style: TextStyle(
                            fontFamily: 'WorkSans',
                            fontSize: 24,
                            height: 1.05,
                            fontWeight: FontWeight.w900,
                            color: RideColors.asphalt,
                          ),
                        ),
                        const Text(
                          'Member since 2021',
                          style: TextStyle(
                            fontFamily: 'WorkSans',
                            fontSize: 14,
                            height: 1.1,
                            fontWeight: FontWeight.w800,
                            color: RideColors.asphalt,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: RideColors.mustard,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.star,
                                size: 16,
                                color: RideColors.paper,
                              ),
                              SizedBox(width: 4),
                              Text(
                                '4.8 Rider Rating',
                                style: TextStyle(
                                  fontFamily: 'WorkSans',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w900,
                                  color: RideColors.paper,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: RideColors.paper,
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: Column(
                  children: [
                    const Row(
                      children: [
                        ProfileStatCard(value: '131', label: 'RIDES'),
                        SizedBox(width: 14),
                        ProfileStatCard(value: '45', label: 'PLACES'),
                        SizedBox(width: 14),
                        ProfileStatCard(value: '3350', label: 'EGP/MON'),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Saved places',
                          style: TextStyle(
                            fontFamily: 'WorkSans',
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: RideColors.asphalt,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: EdgeInsets.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            '+ ADD',
                            style: TextStyle(
                              fontFamily: 'WorkSans',
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                              color: RideColors.asphalt,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Row(
                      children: [
                        ProfileSavedPlace(
                          label: 'Mom',
                          icon: Icons.home_outlined,
                        ),
                        SizedBox(width: 10),
                        ProfileSavedPlace(
                          label: 'Park',
                          icon: Icons.park_outlined,
                        ),
                        SizedBox(width: 10),
                        ProfileSavedPlace(
                          label: 'Beach',
                          icon: Icons.beach_access_outlined,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Expanded(
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
                        child: const Column(
                          children: [
                            ProfileActionRow(
                              leading: RoadIcon(width: 20, height: 22),
                              label: 'RIDES HISTORY',
                              fontSize: 15,
                            ),
                            ProfileActionRow(
                              leading: Icon(
                                Icons.credit_card_rounded,
                                color: RideColors.asphalt,
                                size: 24,
                              ),
                              label: 'Payment Methods',
                              fontSize: 15,
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Expanded(child: SizedBox()),
                                  Divider(
                                    height: 1,
                                    thickness: 1.5,
                                    color: RideColors.mustard,
                                  ),
                                  Expanded(child: SizedBox()),
                                  Divider(
                                    height: 1,
                                    thickness: 1.5,
                                    color: RideColors.mustard,
                                  ),
                                  Expanded(child: SizedBox()),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
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
