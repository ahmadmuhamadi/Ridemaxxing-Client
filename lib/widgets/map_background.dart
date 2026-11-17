import 'package:flutter/material.dart';

class MapBackground extends StatelessWidget {
  const MapBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Image.asset(
      dark ? 'assets/images/map_dark.png' : 'assets/images/map_light.png',
      fit: BoxFit.cover,
      alignment: Alignment.bottomCenter,
    );
  }
}
