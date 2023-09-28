import 'package:flutter/foundation.dart';

class LocationProvider with ChangeNotifier {
  String _country = ''; // Ülke bilgisini saklamak için bir değişken
  String _city = ''; // Şehir bilgisini saklamak için bir değişken

  String get country => _country;
  String get city => _city;

  void setLocation(String country, String city) {
    _country = country;
    _city = city;
    notifyListeners(); // Değişiklikleri dinleyen bileşenlere haber verir
  }
}
