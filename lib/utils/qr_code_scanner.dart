// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoroo_app/bloc/add_user_bloc/add_user_bloc.dart';
import 'package:neoroo_app/bloc/add_user_bloc/add_user_event.dart';
import 'package:neoroo_app/bloc/add_user_bloc/add_user_state.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'constants.dart';

void scanQrCodeDialog(
  BuildContext context,
) {
  showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          child: ScanQrCodeDialog(),
        );
      });
}

class ScanQrCodeDialog extends StatefulWidget {
  const ScanQrCodeDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<ScanQrCodeDialog> createState() => _ScanQrCodeDialogState();
}

class _ScanQrCodeDialogState extends State<ScanQrCodeDialog> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController qrController;
  void _onQRViewCreated(QRViewController controller) {
    this.qrController = controller;
    controller.scannedDataStream.listen((scanData) {
      print(scanData.code);
      BlocProvider.of<AddUserBloc>(context)
          .add(InfantObtained(qrModelString: scanData.code!));
    });
  }

  @override
  void dispose() {
    qrController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddUserBloc, AddUserState>(
      listener: (context, state) {
        if (state is InfantObtainedState) {
          qrController.dispose();
          Navigator.pop(context);
        }
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50), color: purpleTheme),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: purpleTheme),
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white),
                    child: QRView(
                      overlay: QrScannerOverlayShape(
                        borderColor: Colors.red,
                        borderWidth: 10,
                        borderLength: 30,
                        borderRadius: 10,
                        cutOutSize: 300,
                      ),
                      key: qrKey,
                      onQRViewCreated: _onQRViewCreated,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 25),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Scan The QR Provide by CareGiver",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: purpleTheme),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
