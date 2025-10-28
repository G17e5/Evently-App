import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class PickLocationProvider extends ChangeNotifier {
  final Location location = Location();
  late GoogleMapController googleMapController;

  CameraPosition cameraPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  Set<Marker> markers = {};

  LatLng? eventLocation;
  void setEventLocation(LatLng location) {
    eventLocation = location;
    notifyListeners();
  }
  void clearLocation() {
    eventLocation = null;
    notifyListeners();
  }

  PickLocationProvider() {
    getLocation();
    // setLocationListener();
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
    changeLocationOnMap(locationData);
    notifyListeners();
  }

  void changeLocationOnMap(LocationData locationData) {
    cameraPosition = CameraPosition(
      target: LatLng(locationData.latitude ?? 0, locationData.longitude ?? 0),
      zoom: 14.4746,
    );

    markers.add(
      Marker(
        markerId: MarkerId("1"),
        position: LatLng(
          locationData.latitude ?? 0,
          locationData.longitude ?? 0,
        ),
        infoWindow: InfoWindow(title: "Current Location"),
      ),
    );

    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(cameraPosition),
    );
    notifyListeners();
  }

  void changePickLocation(LatLng latLng) {
    eventLocation = latLng;
    markers.add(
      Marker(
        markerId: MarkerId("2"),
        position: latLng,
        infoWindow: InfoWindow(title: "Event Location"),
      ),
    );
    notifyListeners();
  }
}
