import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BluetoothControllerState {}

class BluetoothControllerInitial extends BluetoothControllerState {}

class AskLocationState extends BluetoothControllerState {
  final String locationPermissionStatus;

  AskLocationState(this.locationPermissionStatus);
}

class ScanForNeoDeviceScanningState extends BluetoothControllerState {}

class ScanForNeoDevicesCompletedState extends BluetoothControllerState {
  final List<ScanResult> neoDevicesAvailable;

  ScanForNeoDevicesCompletedState(this.neoDevicesAvailable);
}

class ScanForNeoDevicesErrorState extends BluetoothControllerState {
  final String e;

  ScanForNeoDevicesErrorState(this.e);
}
