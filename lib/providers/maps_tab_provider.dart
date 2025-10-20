import 'package:flutter/material.dart';
import 'package:location/location.dart';

class MapsTabProvider extends ChangeNotifier {
  final Location location = Location();
  String locationMessage = '';

  MapsTabProvider() {
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
      locationMessage = 'Permission denied';
      notifyListeners();
      return;
    }
    bool serviceEnabled = await _checkLocationServices();
    if (!serviceEnabled) {
      locationMessage = 'Location Permission disabled';
      notifyListeners();
      return;
    }
    locationMessage = 'Location service enabled and now are getting location';
    notifyListeners();
    LocationData locationData = await location.getLocation();
    locationMessage =
        'Location: ${locationData.latitude} ,${locationData.longitude}';
    notifyListeners();
  }
}

//
//
//   bool serviceEnabled = await _location.serviceEnabled();
//   if (!serviceEnabled) {
//     serviceEnabled = await _location.requestService();
//     if (!serviceEnabled) return;
//   }
//
//   currentLocation = await _location.getLocation();
//   notifyListeners(); // update UI when location changes

//     if (permissionStatus != PermissionStatus.granted) {
//       return false;
//     }
