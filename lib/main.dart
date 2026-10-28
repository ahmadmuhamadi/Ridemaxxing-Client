import 'package:flutter/material.dart';

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
      home: const WhereToPage(),
    );
  }
}
