import 'package:flutter/material.dart';

import '../theme/ride_colors.dart';
import '../widgets/destination_shortcuts.dart';
import '../widgets/ride_app_bar.dart';
import '../widgets/ride_bottom_navigation.dart';
import '../widgets/route_card.dart';

class WhereToPage extends StatefulWidget {
  const WhereToPage({super.key});

  @override
  State<WhereToPage> createState() => _WhereToPageState();
}

class _WhereToPageState extends State<WhereToPage> {
  String _fromLocation = 'Home - Sunnyvale';
  String _toLocation = 'Apple Park - Cupertino';
  String? _selectedPlace;
  int _selectedTab = 0;

  void _swapLocations() {
    setState(() {
      final previousFrom = _fromLocation;
      _fromLocation = _toLocation;
      _toLocation = previousFrom;
      _selectedPlace = null;
    });
  }

  void _chooseDestination(String place) {
    const destinations = {
      'Home': 'Home - Sunnyvale',
      'Park': 'Apple Park - Cupertino',
      'Beach': 'Sunnyvale Beach',
    };
    setState(() {
      _selectedPlace = place;
      _toLocation = destinations[place]!;
    });
  }

  void _confirmRide() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Ride to $_toLocation selected.')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const RideAppBar(),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                'Welcome back',
                style: TextStyle(
                  fontFamily: 'WorkSans',
                  fontSize: 40,
                  height: 1.05,
                  fontWeight: FontWeight.w900,
                  color: RideColors.asphalt,
                ),
              ),
            ),
            const Text(
              'Where To?',
              style: TextStyle(
                fontFamily: 'Overpass',
                fontSize: 34,
                height: 1.1,
                color: RideColors.asphalt,
              ),
            ),
            const SizedBox(height: 16),
            RouteCard(
              fromLocation: _fromLocation,
              toLocation: _toLocation,
              onSwap: _swapLocations,
              onRide: _confirmRide,
            ),
            const SizedBox(height: 24),
            DestinationShortcuts(
              selectedPlace: _selectedPlace,
              onSelected: _chooseDestination,
            ),
          ],
        ),
      ),
      bottomNavigationBar: RideBottomNavigation(
        currentIndex: _selectedTab,
        onTap: (index) => setState(() => _selectedTab = index),
      ),
    );
  }
}
