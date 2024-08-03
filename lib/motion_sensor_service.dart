import 'package:sensors_plus/sensors_plus.dart';
import 'dart:async';

class MotionSensorService {
  StreamSubscription<AccelerometerEvent>? _subscription;

  void startListening(Function(AccelerometerEvent) onData) {
    _subscription = accelerometerEvents.listen(onData);
  }

  void stopListening() {
    _subscription?.cancel();
  }
}
