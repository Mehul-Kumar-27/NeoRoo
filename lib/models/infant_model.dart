// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';
part 'infant_model.g.dart';

@HiveType(typeId: 4)
class Infant {
  @HiveField(0)
  late String infantId;
  @HiveField(1)
  late String moterName;
  @HiveField(2)
  late String motherUsername;
  @HiveField(3)
  late String dateOfBirth;
  @HiveField(4)
  late String timeOfBirth;
  @HiveField(5)
  late String birthWeight;
  @HiveField(6)
  late String bodyLength;
  @HiveField(7)
  late String headCircumference;
  @HiveField(8)
  late String birthNotes;
  @HiveField(9)
  late String resuscitation;
  @HiveField(10)
  late String neoTemperature;
  @HiveField(11)
  late String neoHeartRate;
  @HiveField(12)
  late String neoRespiratoryRate;
  @HiveField(13)
  late String neoOxygenSaturation;
  @HiveField(14)
  late String neoSTS;
  @HiveField(15)
  late String neoNSTS;
  @HiveField(16)
  late String infantTrackedInstanceID;
  @HiveField(17)
  late String cribNumber;
  @HiveField(18)
  late String wardNumber;
  @HiveField(19)
  late String presentWeight;
  @HiveField(20)
  late String neoDeviceID;
  @HiveField(21)
  late String avatarID;
  @HiveField(22)
  late String goals;

  Infant(
      {required this.infantId,
      required this.moterName,
      required this.motherUsername,
      required this.dateOfBirth,
      required this.timeOfBirth,
      required this.birthWeight,
      required this.bodyLength,
      required this.headCircumference,
      required this.birthNotes,
      required this.resuscitation,
      required this.neoTemperature,
      required this.neoHeartRate,
      required this.neoRespiratoryRate,
      required this.neoOxygenSaturation,
      required this.neoSTS,
      required this.neoNSTS,
      required this.infantTrackedInstanceID,
      required this.cribNumber,
      required this.wardNumber,
      required this.presentWeight,
      required this.neoDeviceID,
      required this.avatarID,
      required this.goals});

  Infant.fromJson(Map<String, dynamic> json) {
    List<dynamic> attributeList = json['attributes'];

    infantTrackedInstanceID = json['trackedEntityInstance'];
    for (var element in attributeList) {
      String displayName = element['displayName'];
      if (displayName == "NeoRoo_Birth_Date") {
        dateOfBirth = element['value'];
      } else if (displayName == "NeoRoo_Birth_Notes") {
        birthNotes = element['value'];
      } else if (displayName == "NeoRoo_Birth_Time") {
        timeOfBirth = element['value'];
      } else if (displayName == "NeoRoo_Birth_Weight") {
        birthWeight = element['value'];
      } else if (displayName == "NeoRoo_Body_Length") {
        bodyLength = element['value'];
      } else if (displayName == "NeoRoo_Crib_Number") {
        cribNumber = element['value'];
      } else if (displayName == "NeoRoo_Device_Id") {
        neoDeviceID = element['value'];
      } else if (displayName == "NeoRoo_Head_Circumference") {
        headCircumference = element['value'];
      } else if (displayName == "NeoRoo_Require_Resuscitation") {
        resuscitation = element['value'];
      } else if (displayName == "NeoRoo_TEI_avatar") {
        avatarID = element['value'];
      } else if (displayName == "NeoRoo_Ward_Number") {
        wardNumber = element['value'];
      } else if (displayName == "NeoRoo_Weight_of_baby_normal") {
        presentWeight = element['value'];
      } else if (displayName == "NeoRoo_mother_name") {
        moterName = element['value'];
      } else if (displayName == "NeoRoo_mother_id") {
        motherUsername = element['value'];
      } else if (displayName == "NeoRoo_STS") {
        neoSTS = element['value'];
      } else if (displayName == "NeoRoo_NSTS") {
        neoNSTS = element['value'];
      } else if (displayName == "NeoRoo_Temperature") {
        neoTemperature = element['value'];
      } else if (displayName == "NeoRoo_HeartRate") {
        neoHeartRate = element['value'];
      } else if (displayName == "NeoRoo_RespiratoryRate") {
        neoRespiratoryRate = element['value'];
      } else if (displayName == "NeoRoo_BloodOxygen") {
        neoOxygenSaturation = element['value'];
      } else if (displayName == "NeoRoo_InfantID") {
        infantId = element['value'];
      } else if (displayName == "NeoRoo_Goals") {
        goals = element['value'];
      } else {
        print("Unknown attribute: $displayName");
      }
    }
  }
}
