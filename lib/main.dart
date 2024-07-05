import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:led_notificaciones_smartphone/firebase_options.dart';
import 'package:permission_handler/permission_handler.dart';
import 'control_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
        ).then((_) {
          connection?.close();
          connection = null;
          connectedDevice = null;
          setState(() {});
        });
      });
    } catch(e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          Center(
            child: Text(
              "Dispositivos Bluetooth Conectados",
              style: Theme.of(context).textTheme.headlineSmall,
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
