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
      body: Container(
        color: Colors.blue,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Current light level:',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                '$_luxString lux',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _toggleLightMeasurement,
                child: Text(_isMeasuringLight ? 'Stop Light Measurement' : 'Start Light Measurement'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
