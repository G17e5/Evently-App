
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:location/location.dart';

class HomeTapProvider extends ChangeNotifier {
  final Location location = Location();

  String? country;
  String? city;

  HomeTapProvider() {
    getLocation();
  }

  Future<bool> _getLocationPermission() async {
    PermissionStatus permissionStatus;
    permissionStatus = await location.hasPermission();

    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
    }
    return permissionStatus == PermissionStatus.granted;
  }

  Future<bool> _checkLocationServices() async {
    bool serviceEnabled = await location.serviceEnabled();

    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
    }
    return serviceEnabled;
  }

  Future<void> getLocation() async {
    bool permissionGranted = await _getLocationPermission();
    if (!permissionGranted) {
      return;
    }
    bool serviceEnabled = await _checkLocationServices();
    if (!serviceEnabled) {
      return;
    }

    LocationData locationData = await location.getLocation();
    List<geocoding.Placemark> placemarks = await geocoding
        .placemarkFromCoordinates(
          locationData.latitude!,
          locationData.longitude!,
        );
    if (placemarks.isNotEmpty) {
      city = placemarks.first.locality ?? 'cant find country';
      country = placemarks.first.country ?? 'cant find country';

      notifyListeners();
    }
    notifyListeners();
  }


}
