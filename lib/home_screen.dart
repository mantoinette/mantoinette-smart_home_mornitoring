import 'package:flutter/material.dart';
import 'motion_detection_screen.dart';
import 'light_detection_screen.dart';
import 'location_tracking_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Smart Home Monitoring'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text('Smart Home Monitoring', style: TextStyle(fontSize: 24)),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Light Detection'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LightDetectionScreen()),
                );
              },
            ),
            ListTile(
              title: Text('Motion Detection'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MotionDetectionScreen()),
                );
              },
            ),
            ListTile(
              title: Text('Location Tracking'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LocationTrackingScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('Welcome to Smart Home Monitoring'),
      ),
    );
  }
}
