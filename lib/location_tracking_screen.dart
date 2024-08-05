import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'location_service.dart';

class LocationTrackingScreen extends StatefulWidget {
  @override
  _LocationTrackingScreenState createState() => _LocationTrackingScreenState();
}

class _LocationTrackingScreenState extends State<LocationTrackingScreen> {
  GoogleMapController? _mapController;
  LatLng _currentPosition = LatLng(0, 0);
  Set<Marker> _markers = {};
  final LocationService _locationService = LocationService();
  bool _isTracking = false;

  @override
  void initState() {
    super.initState();
    _locationService.init();
  }

  void _toggleTracking() {
    if (_isTracking) {
      _locationService.stopTracking();
    } else {
      _locationService.startTracking((Position position) {
        setState(() {
          _currentPosition = LatLng(position.latitude, position.longitude);
          _markers = {
            Marker(
              markerId: MarkerId('currentPosition'),
              position: _currentPosition,
            ),
          };
          _mapController?.animateCamera(
            CameraUpdate.newLatLngZoom(_currentPosition, 15),
          );
        });
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
                _mapController!.animateCamera(
                  CameraUpdate.newLatLngZoom(_currentPosition, 15),
                );
              },
              markers: _markers,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _toggleTracking,
              child: Text(_isTracking ? 'Stop Tracking' : 'Start Tracking'),
            ),
          ),
        ],
      ),
    );
  }
}
