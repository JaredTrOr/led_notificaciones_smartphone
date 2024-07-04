import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class ControlScreen extends StatefulWidget {
  final BluetoothDevice device;
  final BluetoothConnection connection;

  const ControlScreen({required this.device, required this.connection, Key? key})
      : super(key: key);

  @override
  _ControlScreenState createState() => _ControlScreenState();
}

class _ControlScreenState extends State<ControlScreen> {
  bool isLedOn = false;

  void toggleLed() {
    if (widget.connection.isConnected) {
      setState(() {
        isLedOn = !isLedOn;
      });
      widget.connection.output.add(Uint8List.fromList([isLedOn ? 49 : 48])); // ASCII: '1' -> 49, '0' -> 48
    } else {
      print("No se puede enviar datos, no está conectado");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isLedOn ? Colors.white : Colors.black,
      appBar: AppBar(
        title: Text(
          'Control de ${widget.device.name}',
          style: TextStyle(color: isLedOn ? Colors.black : Colors.white),
        ),
        backgroundColor: isLedOn ? Colors.white : Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isLedOn ? "ENCENDIDO" : "APAGADO",
              style: TextStyle(
                color: isLedOn ? Colors.black : Colors.white,
                fontSize: 20,
              ),
            ),
            GestureDetector(
              onTap: toggleLed,
              child: Icon(
                Icons.lightbulb,
                color: isLedOn ? Colors.yellow : Colors.grey,
                size: 300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
