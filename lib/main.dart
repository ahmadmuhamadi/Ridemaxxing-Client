import 'package:flutter/material.dart';

import 'pages/profile_page.dart';
import 'pages/where_to_page.dart';
import 'theme/ride_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RideMaxxing',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Overpass',
        scaffoldBackgroundColor: RideColors.cream,
        colorScheme: ColorScheme.fromSeed(
          seedColor: RideColors.rust,
          surface: RideColors.cream,
        ),
      ),
      home: const NavigationShell(),
    );
  }
}

class NavigationShell extends StatefulWidget {
  const NavigationShell({super.key});

  @override
  State<NavigationShell> createState() => _NavigationShellState();
}

class _NavigationShellState extends State<NavigationShell> {
  int _selectedPage = 0;
  int _selectedTab = 0;

  void _navigate(int index) {
    if (index < 0 || index > 3) {
      return;
    }
    setState(() {
      _selectedTab = index;
      if (index == 0) _selectedPage = 0;
      if (index == 3) _selectedPage = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: _selectedPage,
      children: [
        WhereToPage(currentIndex: _selectedTab, onNavigate: _navigate),
        ProfilePage(currentIndex: _selectedTab, onNavigate: _navigate),
      ],
    );
  }
}
