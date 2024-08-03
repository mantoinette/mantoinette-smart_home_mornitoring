import 'dart:async';
import 'package:flutter/services.dart';

class LightSensorService {
  static const EventChannel _lightSensorChannel = EventChannel('com.example.smarthome/lightSensor');
  StreamSubscription<dynamic>? _subscription;

  void startListening(Function(double) onData) {
    _subscription = _lightSensorChannel.receiveBroadcastStream().listen((event) {
      final double lightLevel = event;
      onData(lightLevel);
    });
  }

  void stopListening() {
    _subscription?.cancel();
  }
}
