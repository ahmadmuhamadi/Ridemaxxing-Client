import 'package:flutter/material.dart';

import 'pages/home_page.dart';
import 'pages/profile_page.dart';
import 'pages/ride_history_page.dart';
import 'pages/settings_page.dart';
import 'theme/app_theme.dart';
import 'widgets/rider_tab_bar.dart';

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
      theme: appTheme(Brightness.light),
      darkTheme: appTheme(Brightness.dark),
      home: const RiderTabs(),
    );
  }
}

class RiderTabs extends StatefulWidget {
  const RiderTabs({super.key});

  @override
  State<RiderTabs> createState() => _RiderTabsState();
}

class _RiderTabsState extends State<RiderTabs> {
  int _tab = 0;

  void _openSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            SettingsPage(onBack: () => Navigator.pop(context)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: RiderTabBar(
        current: _tab,
        onTap: (i) {
          if (i == 0 || i == 1 || i == 3) setState(() => _tab = i);
        },
      ),
      body: IndexedStack(
        index: switch (_tab) {
          1 => 1,
          3 => 2,
          _ => 0,
        },
        children: [
          const HomePage(),
          const RideHistoryPage(),
          ProfilePage(onOpenSettings: _openSettings),
        ],
      ),
    );
  }
}
