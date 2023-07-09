import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:neoroo_app/bloc/bluetooth_bloc/ble_bloc.dart';
import 'package:neoroo_app/bloc/bluetooth_bloc/ble_events.dart';
import 'package:neoroo_app/bloc/bluetooth_bloc/ble_states.dart';
import 'package:neoroo_app/screens/bluethooth_screen/countdown_widget.dart';

class BluethoothScan extends StatefulWidget {
  const BluethoothScan({super.key});

  @override
  State<BluethoothScan> createState() => _BluethoothScanState();
}

class _BluethoothScanState extends State<BluethoothScan> {
  @override
  void initState() {
    BlocProvider.of<BluetoothControllerBloc>(context)
        .add(RequestPermissionStatusEvent());
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(110, 42, 127, 1),
      ),
      body: BlocConsumer<BluetoothControllerBloc, BluetoothControllerState>(
        listener: (context, state) {
          print(state);
          if (state is AskLocationState) {
            if (state.locationPermissionStatus == "Denied") {
              BlocProvider.of<BluetoothControllerBloc>(context)
                  .add(AskLocationPermissionEvent());
            } else if (state.locationPermissionStatus == "Denied by User") {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Please enable location to continue further")));
            }
          }
        },
        builder: (context, state) {
          if (state is ScanForNeoDevicesCompletedState) {
            return Column(
              children: [
                Expanded(
                    child: ListView.builder(
                  itemCount: state.neoDevicesAvailable.length,
                  itemBuilder: (context, index) {
                    ScanResult result = state.neoDevicesAvailable[index];
                    return ListTile(
                      title: Text(result.device.name),
                      subtitle: Text(result.device.id.toString()),
                      trailing: Text(result.rssi.toString()),
                      onTap: () {},
                    );
                  },
                ))
              ],
            );
          } else if (state is AskLocationState &&
              state.locationPermissionStatus == "Denied by User") {
            return Center(
              child: Text("Turn On Location to continue further !!"),
            );
          } else if (state is AskLocationState &&
              (state.locationPermissionStatus == "Granted by User" ||
                  state.locationPermissionStatus == "Granted")) {
            return Center(
              child: Text("Press the button below to scan for devices"),
            );
          } else if (state is ScanForNeoDeviceScanningState) {
            return CountdownTimer();
          } else if (state is ScanForNeoDevicesErrorState) {
            return Center(
              child: Text(state.e),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: Align(
          alignment: Alignment.bottomCenter,
          child: BlocBuilder<BluetoothControllerBloc, BluetoothControllerState>(
              builder: (context, state) {
            if (state is ScanForNeoDeviceScanningState) {
              return SizedBox();
            }
            return InkWell(
                onTap: () {
                  BlocProvider.of<BluetoothControllerBloc>(context)
                      .add(ScanForNeoDevicesEvent());
                },
                child: ScanButton());
          })),
    );
  }
}

class ScanButton extends StatelessWidget {
  const ScanButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 120,
      decoration: BoxDecoration(
          color: Color.fromRGBO(110, 42, 127, 1),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(offset: Offset(0, 3))]),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.bluetooth,
              color: Colors.white,
            ),
            Text(
              "Scan",
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
