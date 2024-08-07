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
        title: Text('Smart Home Monitoring', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(color: Colors.white), // Change icon color to white
        actions: [
          IconButton(
            icon: Icon(Icons.clear, color: Colors.white),
            onPressed: () {
              // Add your onPressed code here
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text(
                'Smart Home Monitoring',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Light Detection', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LightDetectionScreen()),
                );
              },
            ),
            ListTile(
              title: Text('Motion Detection', style: TextStyle(color: Colors.blue)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MotionDetectionScreen()),
                );
              },
            ),
            ListTile(
              title: Text('Location Tracking', style: TextStyle(color: Colors.green)),
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
      body: Container(
        color: Colors.blue,
        child: Center(
          child: Text(
            'Welcome to Smart Home Monitoring',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
