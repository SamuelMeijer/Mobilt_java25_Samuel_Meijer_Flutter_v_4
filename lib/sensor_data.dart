import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'dart:io' as io;

class SensorData extends StatefulWidget {
  const new({super.key});

  @override
  State<SensorData> createState() => _SensorDataState();
}

class _SensorDataState extends State<SensorData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Sensor Data"),
      ),

      body: Center(
        child: Column(mainAxisAlignment: .center, children: [
          getPlatformPage()
        ]),
      ),
    );
  }

  // TODO: IMPLEMENT PLATTFORM CHECK
  // => Visa sensordata om Android
  // => Visa sensordata om möjligt på Webb (funkar det inte så visa text istället)
  // Kan reutrnera vilken Widget som helst
  Widget getPlatformPage() {
    if (kIsWeb) {
      return const Text("WEBB - Sensor Data not supported");
    } else if (io.Platform.isAndroid) {
      return const Text("ANDRODID");
    } else if (io.Platform.isWindows) {
      return const Text("WINDOWS");
    } else if (io.Platform.isIOS) {
      return const Text("IOS APPLE");
    } else if (io.Platform.isMacOS) {
      return const Text("MAC");
    } else if (io.Platform.isLinux) {
      return const Text("LINUX");
    }
    return const Text("Plattform stöds inte");
  }
}
