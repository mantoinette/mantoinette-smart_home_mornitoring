import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'notification_service.dart';

class LocationService {
  final NotificationService _notificationService = NotificationService();
  StreamSubscription<Position>? _positionStreamSubscription;

  // Initialize location tracking
  Future<void> init() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, request for the user to enable them
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, request permission again
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle accordingly
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted, and we can continue accessing the position of the device
  }

  // Start tracking the location and checking geofence
  Future<void> startTracking(Function(Position) onPositionUpdate) async {
    _positionStreamSubscription = Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    ).listen((Position position) {
      onPositionUpdate(position);
      _checkGeofence(position);
    });
  }

  // Stop tracking the location
  void stopTracking() {
    _positionStreamSubscription?.cancel();
  }

  // Check if the device is within the geofence
  void _checkGeofence(Position position) {
    const double geofenceLatitude = 37.42796133580664;
    const double geofenceLongitude = -122.085749655962;
    const double geofenceRadius = 100; // Radius in meters

    double distance = Geolocator.distanceBetween(
      position.latitude,
      position.longitude,
      geofenceLatitude,
      geofenceLongitude,
    );

    if (distance <= geofenceRadius) {
      _notificationService.showNotification(
          'Geofence Entry', 'You have entered the geofenced area.');
    } else {
      _notificationService.showNotification(
          'Geofence Exit', 'You have exited the geofenced area.');
    }
  }
}
