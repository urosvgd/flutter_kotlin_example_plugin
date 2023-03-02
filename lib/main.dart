import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = MethodChannel("com.flutter.epic/epic");
  int _counter = 0;
  late int batteryStatus;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    printy();
    turnOnFlashLight();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: getBatteryStatus,
            tooltip: 'Battery level',
            child: const Icon(Icons.battery_0_bar),
          ),
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  void printy() async {
    late String value;
    try {
      value = await platform.invokeMethod("Printy");
    } catch (e) {
      print(e);
    }
    debugPrint(value);
  }

  void turnOnFlashLight() async {
    late var value;
    try {
      value = await platform.invokeMethod("TurnFlashLightOn");
    } catch (e) {
      print(e);
    }
  }

  void getBatteryStatus() async {
    late var value;
    try {
      value = await platform.invokeMethod("GetBatteryLevel");
    } catch (e) {
      print(e);
    }
  }
}
