import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'notification_service.dart';

class LocationService {
  final NotificationService _notificationService = NotificationService();
  StreamSubscription<Position>? _positionStreamSubscription;

  Future<void> init() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Location services are disabled.');
      return Future.error('Location services are disabled.');
    }

    // Check location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied.');
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print('Location permissions are permanently denied.');
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // Initialize the notification service
    await _notificationService.init();
  }

  Future<void> startTracking(Function(Position) onPositionUpdate) async {
    _positionStreamSubscription = Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    ).listen((Position position) {
      print('Position update: Lat: ${position.latitude}, Lng: ${position.longitude}');
      onPositionUpdate(position);
      _notificationService.showNotification(
          'Current Location',
          'Lat: ${position.latitude}, Lng: ${position.longitude}');
    }, onError: (error) {
      print('Error in position stream: $error');
    });
  }

  void stopTracking() {
    _positionStreamSubscription?.cancel();
    _positionStreamSubscription = null;
    print('Location tracking stopped.');
  }
}
