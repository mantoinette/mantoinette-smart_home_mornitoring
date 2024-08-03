import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'notification_service.dart';
import 'motion_sensor_service.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class MotionDetectionScreen extends StatefulWidget {
  @override
  _MotionDetectionScreenState createState() => _MotionDetectionScreenState();
}

class _MotionDetectionScreenState extends State<MotionDetectionScreen> {
  final MotionSensorService _motionSensorService = MotionSensorService();
  final NotificationService _notificationService = NotificationService();
  bool _isMeasuringMotion = false;
  List<charts.Series<AccelerometerEvent, int>> _chartData = [];
  List<AccelerometerEvent> _data = [];

  @override
  void initState() {
    super.initState();
    _notificationService.init();
  }

  void _toggleMotionMeasurement() {
    if (_isMeasuringMotion) {
      _motionSensorService.stopListening();
    } else {
      _motionSensorService.startListening((AccelerometerEvent event) {
        setState(() {
          _data.add(event);
          _chartData = _createChartData(_data);
        });

        if (event.x.abs() > 2 || event.y.abs() > 2 || event.z.abs() > 2) {
          _notificationService.showNotification("Motion Detected", "Significant motion detected!");
        }
      });
    }
    setState(() {
      _isMeasuringMotion = !_isMeasuringMotion;
    });
  }

  List<charts.Series<AccelerometerEvent, int>> _createChartData(List<AccelerometerEvent> data) {
    return [
      charts.Series<AccelerometerEvent, int>(
        id: 'X',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (AccelerometerEvent event, int? index) => index!,
        measureFn: (AccelerometerEvent event, int? index) => event.x.toInt(),
        data: data,
      ),
      charts.Series<AccelerometerEvent, int>(
        id: 'Y',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (AccelerometerEvent event, int? index) => index!,
        measureFn: (AccelerometerEvent event, int? index) => event.y.toInt(),
        data: data,
      ),
      charts.Series<AccelerometerEvent, int>(
        id: 'Z',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (AccelerometerEvent event, int? index) => index!,
        measureFn: (AccelerometerEvent event, int? index) => event.z.toInt(),
        data: data,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Motion Detection'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _toggleMotionMeasurement,
              child: Text(_isMeasuringMotion ? 'Stop Motion Measurement' : 'Start Motion Measurement'),
            ),
            SizedBox(height: 20),
            if (_isMeasuringMotion)
              Expanded(
                child: charts.LineChart(
                  _chartData,
                  animate: true,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
