import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'location_service.dart';
import 'notification_service.dart';

class LocationTrackingScreen extends StatefulWidget {
  @override
  _LocationTrackingScreenState createState() => _LocationTrackingScreenState();
}

class _LocationTrackingScreenState extends State<LocationTrackingScreen> {
  final LocationService _locationService = LocationService();
  final NotificationService _notificationService = NotificationService();
  GoogleMapController? _mapController; // Changed to nullable
  bool _isTracking = false;
  LatLng _currentPosition = LatLng(0, 0);
  Set<Marker> _markers = {}; // To manage multiple markers

  @override
  void initState() {
    super.initState();
    _initializeServices();
  }

  Future<void> _initializeServices() async {
    await _notificationService.init();
    await _locationService.init();
  }

  void _toggleTracking() {
    if (_isTracking) {
      print('Stopping location tracking...');
      _locationService.stopTracking();
    } else {
      print('Starting location tracking...');
      _locationService.startTracking((Position position) {
        print('Received location update: Lat: ${position.latitude}, Lng: ${position.longitude}');
        if (_mapController != null) {
          setState(() {
            _currentPosition = LatLng(position.latitude, position.longitude);
            _markers = {
              Marker(
                markerId: MarkerId('currentLocation'),
                position: _currentPosition,
              ),
            };
            _mapController!.animateCamera(
              CameraUpdate.newLatLng(_currentPosition),
            );
            _notificationService.showNotification(
              'Current Location',
              'Lat: ${position.latitude}, Lng: ${position.longitude}',
            );
          });
        } else {
          print('Map controller is not initialized');
        }
      });
    }
    setState(() {
      _isTracking = !_isTracking;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Tracking'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _currentPosition,
                zoom: 15,
              ),
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
                print('Google Map Controller Initialized');
              },
              markers: _markers, // Use markers set
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _toggleTracking,
            child: Text(_isTracking ? 'Stop Tracking' : 'Start Tracking'),
          ),
        ],
      ),
    );
  }
}
