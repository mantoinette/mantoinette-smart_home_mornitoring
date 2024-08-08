import 'package:flutter/material.dart';
import 'package:light/light.dart';
import 'notification_service.dart';

class LightDetectionScreen extends StatefulWidget {
  @override
  _LightDetectionScreenState createState() => _LightDetectionScreenState();
}

class _LightDetectionScreenState extends State<LightDetectionScreen> {
  late Light _light;
  String _luxString = 'Unknown';
  final NotificationService _notificationService = NotificationService();
  bool _isMeasuringLight = false;

  @override
  void initState() {
    super.initState();
    _light = Light();
    _light.lightSensorStream.listen((luxValue) {
      if (_isMeasuringLight) {
        _onLightData(luxValue);
      }
    });
  }

  void _onLightData(int luxValue) {
    setState(() {
      _luxString = luxValue.toString();
    });

    if (luxValue < 100) {
      _notificationService.showNotification('Light Level Low', 'The light level is low: $luxValue lux');
    } else if (luxValue >= 100 && luxValue < 500) {
      _notificationService.showNotification('Light Level Medium', 'The light level is medium: $luxValue lux');
    } else {
      _notificationService.showNotification('Light Level High', 'The light level is high: $luxValue lux');
    }
  }

  void _toggleLightMeasurement() {
    setState(() {
      _isMeasuringLight = !_isMeasuringLight;
      if (_isMeasuringLight) {
        _notificationService.showNotification('Light Measurement Started', 'You are now measuring light levels.');
      } else {
        _notificationService.showNotification('Light Measurement Stopped', 'Light measurement has stopped.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Light Detection'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Image at the top with no space above it
            Image.asset(
              'assets/light.jpg',
              height: 500, // Adjust height if needed
              width: double.infinity, // Make the image fill the width
              fit: BoxFit.cover, // Ensure the image covers the area
            ),
            SizedBox(height: 20), // Space between image and text

            // Text widgets
            Text(
              'Current light level:',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            Text(
              '$_luxString lux',
              style: TextStyle(color: Colors.black, fontSize: 24),
            ),
            SizedBox(height: 20), // Space between light level and button

            // Button
            Center(
              child: ElevatedButton(
                onPressed: _toggleLightMeasurement,
                child: Text(_isMeasuringLight ? 'Stop Light Measurement' : 'Start Light Measurement'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  textStyle: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
