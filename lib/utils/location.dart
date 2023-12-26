// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:location/location.dart';

class LocationHelper {
  late double latitude;
  late double longitude; // paralel ve meridyen konumu alabilmek için

  Future<void> getCurrentLocation() async {
    //konum kordinatı
    Location location = Location();

    bool _serviceEnabled;
    // kordinat kullanma izni kullanıcı tarafından verilmiş mi kontorlü
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    // Location için servis ayakta mı ?
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    // konum izni kontrolü
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      // denied izin verilmemişse
      _permissionGranted == await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    // izinler tamam ise
    _locationData = await location.getLocation();
    latitude = _locationData.latitude!;
    longitude = _locationData.longitude!;
  }

  
}
