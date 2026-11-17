import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

Future<Position?> getCurrentLocation() async {
  try {
    if (!await Geolocator.isLocationServiceEnabled()) {
      throw Exception('Location services are off');
    }
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      throw Exception('Location permission denied');
    }
    return await Geolocator.getCurrentPosition();
  } catch (e) {
    debugPrint('[RideMaxxing] Getting location failed: $e');
    return null;
  }
}
