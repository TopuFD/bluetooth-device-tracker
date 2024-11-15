import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? connectedDeviceAddress;

  //==================================================================bluetooth device id tracker method
  Future<void> getConnectedDevices() async {
    try {
      List<BluetoothDevice> devices = await FlutterBluePlus.bondedDevices;

      if (devices.isNotEmpty) {
        BluetoothDevice connectedDevice = devices.first;

        setState(() {
          connectedDeviceAddress = connectedDevice.id.id;
        });
        print(
            "=======================================================$connectedDevice");
      } else {
        print("=========================No Bluetooth device connected");
      }
    } catch (e) {
      print("=========================No Bluetooth device connected");
    }
  }

  @override
  void initState() {
    super.initState();
    getConnectedDevices();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Connected Device"),
      ),
      body: SizedBox(
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            connectedDeviceAddress != null
                ? Text(
                    "Connected Device Address: ${connectedDeviceAddress}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  )
                : Text("No Device Connected"),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  getConnectedDevices();
                },
                child: Text("Scan"))
          ],
        ),
      ),
    );
  }
}
