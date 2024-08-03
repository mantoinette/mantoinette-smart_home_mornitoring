import 'package:flutter/material.dart';
import 'LocationTrackingScreen.dart';
import 'light_detection_screen.dart';
import 'motion_detection_screen.dart';
import 'location_service.dart';

void main() {
  runApp(SmartHomeMonitoringApp());
}

class SmartHomeMonitoringApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Home Monitoring',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  final LocationService _locationService = LocationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Smart Home Monitoring'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Smart Home Monitoring'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Light Detection'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LightDetectionScreen()),
                );
              },
            ),
            ListTile(
              title: Text('Motion Detection'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MotionDetectionScreen()),
                );
              },
            ),
            ListTile(
              title: Text('Location Tracking'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LocationTrackingScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('Welcome to Smart Home Monitoring App'),
      ),
    );
  }
}
