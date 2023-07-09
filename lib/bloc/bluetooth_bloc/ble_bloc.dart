import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:neoroo_app/bloc/bluetooth_bloc/ble_events.dart';
import 'package:neoroo_app/bloc/bluetooth_bloc/ble_states.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart';

class BluetoothControllerBloc
    extends Bloc<BluetoothControllerEvent, BluetoothControllerState> {
  BluetoothControllerBloc() : super(BluetoothControllerInitial()) {
    on<AskLocationPermissionEvent>(askPermissionStatus);
    on<RequestPermissionStatusEvent>(checkPermissionStatus);
    on<ScanForNeoDevicesEvent>(scanForNeoDevicesAvailableNearby);
  }

  Future<void> askPermissionStatus(AskLocationPermissionEvent event,
      Emitter<BluetoothControllerState> emitter) async {
    final status = await Permission.location.request();

    if (status.isGranted) {
      final serviceEnabled = await checkLocationServices();
      if (serviceEnabled) {
        print('Location services are enabled');
      } else {
        requestLocationServices();
      }
      emitter(AskLocationState("Granted by User"));
    } else {
      emitter(AskLocationState("Denied by User"));
    }
  }

  Future<void> checkPermissionStatus(RequestPermissionStatusEvent event,
      Emitter<BluetoothControllerState> emitter) async {
    final status = await Permission.location.status;

    if (status.isGranted) {
      final serviceEnabled = await checkLocationServices();
      if (serviceEnabled) {
        print('Location services are enabled');
      } else {
        requestLocationServices();
      }
      emitter(AskLocationState("Granted"));
    } else {
      emitter(AskLocationState("Denied"));
    }
  }

  Future<bool> checkLocationServices() async {
    final location = Location();
    final serviceEnabled = await location.serviceEnabled();
    return serviceEnabled;
  }

  Future<void> requestLocationServices() async {
    final location = Location();
    bool serviceEnabled = await checkLocationServices();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
    }
    if (!serviceEnabled) {
      print('Location services not enabled');
    }
  }

  Future<void> scanForNeoDevicesAvailableNearby(ScanForNeoDevicesEvent event,
      Emitter<BluetoothControllerState> emitter) async {
    emitter(ScanForNeoDeviceScanningState());
    List<ScanResult> neoDevicesAvailableNearby = [];
    FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
    try {
      bool isBluetoothOn = await flutterBlue.isOn;
      if (isBluetoothOn == false) {
        try {
          await flutterBlue.turnOn();
          flutterBlue.startScan(timeout: const Duration(seconds: 10));
          flutterBlue.scanResults.listen((results) {
            for (ScanResult r in results) {
              print('${r.device.name} found! rssi: ${r.rssi}');
            }

            neoDevicesAvailableNearby = results;
          });

          await Future.delayed(const Duration(seconds: 13));
          emitter(ScanForNeoDevicesCompletedState(neoDevicesAvailableNearby));
        } catch (e) {
          emitter(ScanForNeoDevicesErrorState("Please Turn On Bluetooth"));
        }
      } else {
        flutterBlue.startScan(timeout: const Duration(seconds: 10));
        flutterBlue.scanResults.listen((results) {
          for (ScanResult r in results) {
            print('${r.device.name} found! rssi: ${r.rssi}');
          }

          neoDevicesAvailableNearby = results;
        });

        await Future.delayed(const Duration(seconds: 13));
        emitter(ScanForNeoDevicesCompletedState(neoDevicesAvailableNearby));
      }
    } catch (e) {
      emitter(ScanForNeoDevicesErrorState("Error Occured"));
    }
  }
}
