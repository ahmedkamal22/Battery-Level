import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BatteryLevel extends StatefulWidget {
  @override
  State<BatteryLevel> createState() => _BatteryLevelState();
}

class _BatteryLevelState extends State<BatteryLevel> {
  static const platform = MethodChannel('samples.flutter.dev/battery');
  String batteryLevel = 'Unknown battery level.';

  getBatteryLevel() {
    platform.invokeMethod('getBatteryLevel').then((value) {
      setState(() {
        batteryLevel = 'Battery level is $value %';
      });
    }).catchError((error) {
      setState(() {
        batteryLevel = "Failed to get battery level: '${error.message}'.";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: getBatteryLevel,
              child: const Text('Get Battery Level'),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              batteryLevel,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
