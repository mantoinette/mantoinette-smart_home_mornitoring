import 'package:flutter/material.dart';
import 'light_sensor_service.dart';
import 'light_controller.dart';
import 'notification_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LightSensorService _lightSensorService = LightSensorService();
  final LightController _lightController = LightController();
  final NotificationService _notificationService = NotificationService();
  bool _isMeasuring = false;

  @override
  void initState() {
    super.initState();
  }

  void _toggleMeasurement() {
    if (_isMeasuring) {
      _lightSensorService.stopListening();
    } else {
      _lightSensorService.startListening((double lightLevel) {
        _lightController.adjustSmartLights(lightLevel);

        String message;
        if (lightLevel < 10) {
          message = "Hello! Your light is low";
        } else if (lightLevel < 100) {
          message = "Hello! Your light is medium";
        } else {
          message = "Hello! Your light is high";
        }

        _notificationService.showNotification("Light Level Changed", message);
      });
    }
    setState(() {
      _isMeasuring = !_isMeasuring;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Smart Home Monitoring'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Monitoring light levels...'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _toggleMeasurement,
              child: Text(_isMeasuring ? 'Stop Measuring' : 'Start Measuring'),
            ),
          ],
        ),
      ),
    );
  }
}
