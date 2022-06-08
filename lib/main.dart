import 'package:flutter/material.dart';
import 'package:battery_plus/battery_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'battry',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _battryLevel = 0;

  void setBatteryLevel() async {
    var battery = Battery();
    var bl = await battery.batteryLevel;
    setState(() {
      _battryLevel = bl;
    });
  }

  Future<int> getBatteryLevel() async {
    var battery = Battery();
    return await battery.batteryLevel;
  }

  void _updateBatteryLevel() async {
    setBatteryLevel();
    var battery = Battery();
    battery.onBatteryStateChanged.listen((BatteryState state) {
      setState(() {
        setBatteryLevel();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$_battryLevel',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _updateBatteryLevel,
        tooltip: 'update',
        child: const Icon(Icons.update),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
