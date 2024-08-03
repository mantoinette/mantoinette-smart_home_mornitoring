import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'location_service.dart';
import 'notification_service.dart';

class LocationTrackingScreen extends StatefulWidget {
  @override
  _LocationTrackingScreenState createState() => _LocationTrackingScreenState();
}

class _LocationTrackingScreenState extends State<LocationTrackingScreen> {
  final LocationService _locationService = LocationService();
  bool _isTracking = false;
  String _locationMessage = 'Location: Unknown';

  @override
  void initState() {
    super.initState();
    _locationService.init(); // Initialize location and geofencing
  }

  void _toggleLocationTracking() {
    setState(() {
      _isTracking = !_isTracking;
      if (_isTracking) {
        _startTracking();
      } else {
        _locationService.stopTracking();
        _locationMessage = 'Location tracking stopped';
      }
    });
  }

  void _startTracking() {
    _locationService.startTracking((Position position) {
      setState(() {
        _locationMessage =
        'Location: ${position.latitude}, ${position.longitude}';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Tracking'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_locationMessage),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _toggleLocationTracking,
              child: Text(_isTracking ? 'Stop Tracking' : 'Start Tracking'),
            ),
          ],
        ),
      ),
    );
  }
}
