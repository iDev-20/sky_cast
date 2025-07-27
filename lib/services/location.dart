// ignore_for_file: avoid_print, unused_local_variable

import 'package:geolocator/geolocator.dart';

class Location {
  double longitude = 0.0;
  double latitude = 0.0;

  Future<void> getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print('Error fetching latitude and logitude: $e');
    }
  }
}
