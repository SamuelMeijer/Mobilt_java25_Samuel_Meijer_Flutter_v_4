import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'
    show kIsWeb, defaultTargetPlatform, TargetPlatform;
// Packages
import 'package:sensors_plus/sensors_plus.dart';

class SensorData extends StatefulWidget {
  const new({super.key});

  @override
  State<SensorData> createState() => _SensorDataState();
}

class _SensorDataState extends State<SensorData> {
  // SensorPlus-subscription
  StreamSubscription<GyroscopeEvent>? _gyroscopeSubscription;

  // States
  double _x = 0.0;
  double _y = 0.0;
  double _z = 0.0;
  String? _sensorError;

  // Checking which device or if web is needed (dart:io Platform API doesnt work in Flutter Web)
  bool get isAndroid {
    return !kIsWeb && defaultTargetPlatform == TargetPlatform.android;
  }

  @override
  void initState() {
    super.initState();

    if (isAndroid) {
      _startListeningToGyroscope();
    }
  }

  void _startListeningToGyroscope() {
    _gyroscopeSubscription =
        gyroscopeEventStream(samplingPeriod: SensorInterval.normalInterval)
            .listen(
              (GyroscopeEvent event) {
                // Preventing setState to be called on a page no longer in use, if the user changes viewing page while the async function is waiting for await result to finish
                if (!mounted) return;

                setState(() {
                  _x = event.x;
                  _y = event.y;
                  _z = event.z;
                  _sensorError = null;
                });
              },
              onError: (err) {
                if (!mounted) return;
                setState(() {
                  _sensorError = 'Error: Sensor data is not supported';
                });
              },
              cancelOnError: true,
            );
  }

  @override
  Widget build(BuildContext context) {
    // NOT ANDROID DEVICES
    if (!isAndroid) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("Sensor Data"),
        ),

        body: Center(
          child: Column(
            mainAxisAlignment: .center,
            children: [Text('Sensor data is not supported')],
          ),
        ),
      );
    }

    // IF AN ERROR OCCURS
    if (_sensorError != null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("Sensor Data"),
        ),

        body: Center(
          child: Column(
            mainAxisAlignment: .center,
            children: [Text(_sensorError!)],
          ),
        ),
      );
    }

    // ANDROID DEVICES
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Sensor Data"),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Text('GYROSCOPE DATA:'),
            Text('X: ${_x.toStringAsFixed(2)}'),
            Text('Y: ${_y.toStringAsFixed(2)}'),
            Text('Z: ${_z.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }
}
