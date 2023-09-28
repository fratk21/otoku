import 'package:flutter/src/widgets/framework.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:otoku/provider/locationprovider.dart';
import 'package:provider/provider.dart';

// Konum izni kontrol fonksiyonu
Future<bool> checkLocationPermission() async {
  final permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.always ||
      permission == LocationPermission.whileInUse) {
    // Kullanıcı konum izni vermiş
    return true;
  } else {
    // Kullanıcı konum izni vermemiş
    return false;
  }
}

// Kullanıcı konum bilgisini ülke ve şehir olarak alma fonksiyonu
Future<Map<String, String>?> getUserLocationInfo(BuildContext context) async {
  final location = await getCurrentLocation();
  if (location != null) {
    final latitude = location.latitude;
    final longitude = location.longitude;

    final placemarks = await placemarkFromCoordinates(latitude, longitude);
    if (placemarks.isNotEmpty) {
      final placemark = placemarks.first;
      final country = placemark.country ?? "Bilinmiyor";
      final city = placemark.locality ?? "Bilinmiyor";
      final locationProvider =
          Provider.of<LocationProvider>(context, listen: false);
      locationProvider.setLocation(country, city);
      // Kullanıcıdan alınan konumu burada sakla

      return {"country": country, "city": city};
    }
  }

  return null;
}

Future<Position?> getCurrentLocation() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Konum servisi etkin mi kontrol et
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Konum servisi kapalıysa açılması istenir
    serviceEnabled = await Geolocator.openLocationSettings();
    if (!serviceEnabled) {
      // Kullanıcı konum servisini açmazsa null döner
      return null;
    }
  }

  // Konum izni kontrolü
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    // Konum izni verilmemişse izin istenir
    permission = await Geolocator.requestPermission();
    if (permission != LocationPermission.whileInUse &&
        permission != LocationPermission.always) {
      // Kullanıcı konum izni vermezse null döner
      return null;
    }
  }

  // Konum bilgisini al
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);

  // Konum bilgisini döndür
  return position;
}
