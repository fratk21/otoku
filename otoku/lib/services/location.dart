import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:otoku/provider/locationprovider.dart';
import 'package:provider/provider.dart';

Future<bool> checkLocationPermission() async {
  try {
    final permission = await Geolocator.checkPermission();
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  } catch (e) {
    print("Error checking location permission: $e");
    return false;
  }
}

Future<Map<String, String>?> getUserLocationInfo(BuildContext context) async {
  int retryCount = 3;

  while (retryCount > 0) {
    try {
      final location = await getCurrentLocation();
      if (location != null) {
        final latitude = location.latitude;
        final longitude = location.longitude;

        final placemarks = await placemarkFromCoordinates(latitude, longitude);
        print("Placemarks: $placemarks");

        if (placemarks.isNotEmpty) {
          final placemark = placemarks.first;
          final country = placemark.country ?? "Unknown";
          final city = placemark.locality ?? "Unknown";

          print("Country: $country, City: $city");

          final locationProvider =
              Provider.of<LocationProvider>(context, listen: false);
          locationProvider.setLocation(country, city);

          return {"country": country, "city": city};
        }
      }
    } catch (e) {
      print("Error getting user location: $e");
      retryCount--;
      await Future.delayed(Duration(seconds: 1));
    }
  }

  print("Failed to get user location.");
  return null;
}

Future<Position?> getCurrentLocation() async {
  try {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await Geolocator.openLocationSettings();
      if (!serviceEnabled) {
        return null;
      }
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return null;
      }
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    return position;
  } catch (e) {
    print("Error getting location: $e");
    return null;
  }
}
