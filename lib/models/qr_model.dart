// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:neoroo_app/models/infant_model.dart';

class QrModel {
  Infant? infant;
  String? adminUsername;
  String? adminPassword;
  String? organizationUnit;
  String? serverURL;
  QrModel({
    this.infant,
    this.adminUsername,
    this.adminPassword,
    this.organizationUnit,
    this.serverURL,
  });

  factory QrModel.fromJson(Map<String, dynamic> json) {
    return QrModel(
      infant: json['infant'] != null ? parseInfant(json['infant']) : null,
      adminUsername: json['adminUsername'],
      adminPassword: json['adminPassword'],
      organizationUnit: json['organizationUnit'],
      serverURL: json['serverURL'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'infant': infant != null ? infant!.toJson() : null,
      'adminUsername': adminUsername,
      'adminPassword': adminPassword,
      'organizationUnit': organizationUnit,
      'serverURL': serverURL,
    };
  }
}

Infant parseInfant(Map<String, dynamic> json) {
  return Infant(
    infantId: json['infantId'],
    moterName: json['moterName'],
    motherUsername: json['motherUsername'],
    dateOfBirth: json['dateOfBirth'],
    timeOfBirth: json['timeOfBirth'],
    birthWeight: json['birthWeight'],
    bodyLength: json['bodyLength'],
    headCircumference: json['headCircumference'],
    birthNotes: json['birthNotes'],
    resuscitation: json['resuscitation'],
    neoTemperature: json['neoTemperature'],
    neoHeartRate: json['neoHeartRate'],
    neoRespiratoryRate: json['neoRespiratoryRate'],
    neoOxygenSaturation: json['neoOxygenSaturation'],
    neoSTS: json['neoSTS'],
    neoNSTS: json['neoNSTS'],
    infantTrackedInstanceID: json['infantTrackedInstanceID'],
    cribNumber: json['cribNumber'],
    wardNumber: json['wardNumber'],
    presentWeight: json['presentWeight'],
    neoDeviceID: json['neoDeviceID'],
    avatarID: json['avatarID'],
    goals: json['goals'],
  );
}
