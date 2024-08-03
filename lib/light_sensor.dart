import 'package:flutter/services.dart';

class LightSensor {
  static const MethodChannel _channel = MethodChannel('com.example.light_sensor');

  static Future<double> getLightLevel() async {
    final double lightLevel = await _channel.invokeMethod('getLightLevel');
    return lightLevel;
  }
}
