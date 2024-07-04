import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const FlutterBluetoothApp());
}

class FlutterBluetoothApp extends StatelessWidget {
  const FlutterBluetoothApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Conexión Bluetooth con Arduino',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BluetoothScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class BluetoothScreen extends StatefulWidget {
  const BluetoothScreen({super.key});

  @override
  _BluetoothScreenState createState() => _BluetoothScreenState();
}

class _BluetoothScreenState extends State<BluetoothScreen> {
  FlutterBluetoothSerial bluetooth = FlutterBluetoothSerial.instance;
  BluetoothConnection? connection;
  BluetoothDevice? connectedDevice;
  List<BluetoothDevice> bondedDevices = [];

  @override
  void initState() {
    super.initState();
    checkPermissions();
  }

  void checkPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.bluetoothScan,
      Permission.bluetooth,
      Permission.bluetoothConnect,
      Permission.location,
    ].request();

    if (  
        statuses[Permission.bluetoothScan]?.isGranted == true &&
        statuses[Permission.bluetooth]?.isGranted == true &&
        statuses[Permission.bluetoothConnect]?.isGranted == true &&
        statuses[Permission.location]?.isGranted == true) {
      getBondedDevices();
    } else {
      print("Permissions not granted");
    }
  }

  void getBondedDevices() async {
    bondedDevices = await bluetooth.getBondedDevices();
    setState(() {});
  }

  void connectToDevice(BluetoothDevice device) async {
    try {
      connection = await BluetoothConnection.toAddress(device.address);
      setState(() {
        connectedDevice = device;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ControlScreen(device: connectedDevice!, connection: connection!),
          ),
        );
      });
    } catch(e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dispositivos Bluetooth'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          Center(
            child: Text(
              "Dispositivos Bluetooth Conectados",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          const SizedBox(height: 20),
          ...bondedDevices.map((device) => Card(
            child: ListTile(
              leading: Icon(Icons.bluetooth, color: Colors.blue),
              title: Text(device.name ?? 'Unknown Device'),
              subtitle: Text(device.address),
              trailing: ElevatedButton(
                onPressed: () => connectToDevice(device),
                child: const Text('Conectar'),
              ),
            ),
          )),
        ],
      ),
    );
  }
}

class ControlScreen extends StatefulWidget {
  final BluetoothDevice device;
  final BluetoothConnection connection;

  const ControlScreen({required this.device, required this.connection, Key? key}) : super(key: key);

  @override
  _ControlScreenState createState() => _ControlScreenState();
}

class _ControlScreenState extends State<ControlScreen> {
  bool isLedOn = false;

  void toggleLed() {
    setState(() {
      isLedOn = !isLedOn;
    });
    widget.connection.output.add(Uint8List.fromList([isLedOn ? 1 : 0]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Control de ${widget.device.name}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.lightbulb_outline,
              color: isLedOn ? Colors.yellow : Colors.grey,
              size: 100,
            ),
            const SizedBox(height: 20),
            SwitchListTile(
              title: const Text('Encender/Apagar LED'),
              value: isLedOn,
              onChanged: (value) => toggleLed(),
              activeColor: Colors.blue,
              inactiveThumbColor: Colors.grey,
              inactiveTrackColor: Colors.grey[300],
            ),
          ],
        ),
      ),
    );
  }
}
