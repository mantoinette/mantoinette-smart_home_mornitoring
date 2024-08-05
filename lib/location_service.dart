import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:async';
import 'notification_service.dart';

class LocationService {
  final NotificationService _notificationService = NotificationService();
  StreamSubscription<Position>? _positionStreamSubscription;

  Future<void> init() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Location services are disabled.');
      return Future.error('Location services are disabled.');
    }

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
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    await _notificationService.init();
    print('Location service initialized successfully.');
  }

  Future<void> startTracking(Function(Position) onPositionUpdate) async {
    _positionStreamSubscription = Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    ).listen((Position position) async {
      print('Position update: Lat: ${position.latitude}, Lng: ${position.longitude}');
      onPositionUpdate(position);

      // Reverse geocoding to get the address
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        String address = "${place.name}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
        _notificationService.showNotification(
          'Current Location',
          address,
        );
      }
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
