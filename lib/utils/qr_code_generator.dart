// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:neoroo_app/models/infant_model.dart';
import 'package:neoroo_app/models/profile.dart';
import 'package:neoroo_app/models/qr_model.dart';
import 'package:neoroo_app/repository/hive_storage_repository.dart';
import 'package:neoroo_app/repository/secure_storage_repository.dart';
import 'package:neoroo_app/utils/constants.dart';
import 'package:qr_flutter/qr_flutter.dart';

void generateQrCode(BuildContext context, Infant infant) async {
  HiveStorageRepository hiveStorageRepository =
      HiveStorageRepository(SecureStorageRepository);
  Profile profile = await hiveStorageRepository.getUserProfile();
  String username = profile.username;
  String password = profile.password;
  String serverURL = await hiveStorageRepository.getOrganisationURL();
  String organizationUnitID =
      await hiveStorageRepository.getSelectedOrganisation();

  QrModel qrModel = QrModel(
      infant: infant,
      adminUsername: username,
      adminPassword: password,
      serverURL: serverURL,
      organizationUnit: organizationUnitID);

  showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          child: QrScannerDialog(qrModel: qrModel),
        );
      });
}

class QrScannerDialog extends StatefulWidget {
  final QrModel qrModel;
  const QrScannerDialog({
    Key? key,
    required this.qrModel,
  }) : super(key: key);

  @override
  State<QrScannerDialog> createState() => _QrScannerDialogState();
}

class _QrScannerDialogState extends State<QrScannerDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), color: Colors.white),
              child: Center(
                child: QrImageView(
                  data: generateJsonData(widget.qrModel),
                  version: QrVersions.auto,
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
                        "Scan This QR To Register as infant family member",
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
    );
  }
}

String generateJsonData(QrModel qrModel) {
  print(qrModel.toString());
  String qrString = jsonEncode(qrModel);

  return qrString;
}
