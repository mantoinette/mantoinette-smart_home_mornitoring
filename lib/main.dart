import 'package:flutter/material.dart';
import 'package:light/light.dart';
import 'notification_service.dart';

void main() {
  runApp(SmartHomeMonitoringApp());
}

class SmartHomeMonitoringApp extends StatefulWidget {
  @override
  _SmartHomeMonitoringAppState createState() => _SmartHomeMonitoringAppState();
}

class _SmartHomeMonitoringAppState extends State<SmartHomeMonitoringApp> {
  late Light _light;
  String _luxString = 'Unknown';
  final NotificationService _notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    _light = Light();
    _notificationService.init();
    _light.lightSensorStream.listen(_onData);
  }

  void _onData(int luxValue) {
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Home Monitoring',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Smart Home Monitoring'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Current light level:'),
              Text(
                '$_luxString lux',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
