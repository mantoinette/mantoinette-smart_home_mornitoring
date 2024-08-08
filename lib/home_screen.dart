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
        iconTheme: IconThemeData(color: Colors.white),
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
              title: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LightDetectionScreen()),
                  );
                },
                icon: Icon(Icons.lightbulb_outline, color: Colors.red),
                label: Text('Light Detection'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black, backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  textStyle: TextStyle(fontSize: 16),
                  alignment: Alignment.centerLeft,
                ),
              ),
            ),
            ListTile(
              title: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MotionDetectionScreen()),
                  );
                },
                icon: Icon(Icons.directions_run, color: Colors.blue),
                label: Text('Motion Detection'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black, backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  textStyle: TextStyle(fontSize: 16),
                  alignment: Alignment.centerLeft,
                ),
              ),
            ),
            ListTile(
              title: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LocationTrackingScreen()),
                  );
                },
                icon: Icon(Icons.location_on, color: Colors.green),
                label: Text('Location Tracking'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black, backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  textStyle: TextStyle(fontSize: 16),
                  alignment: Alignment.centerLeft,
                ),
              ),
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
