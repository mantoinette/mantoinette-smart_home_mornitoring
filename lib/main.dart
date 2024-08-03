import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() => runApp(SmartHomeMonitoringApp());

class SmartHomeMonitoringApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Home Monitoring',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
