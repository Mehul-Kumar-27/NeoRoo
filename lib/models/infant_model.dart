import 'package:hive/hive.dart';

part 'infant_model.g.dart';

@HiveType(typeId: 4)
class Infant {
  @HiveField(0)
  final String infantId;
  @HiveField(1)
  final String moterName;
  @HiveField(2)
  final String motherUsername;
  @HiveField(3)
  final String dateOfBirth;
  @HiveField(4)
  final String timeOfBirth;
  @HiveField(5)
  final String birthWeight;
  @HiveField(6)
  final String bodyLength;
  @HiveField(7)
  final String headCircumference;
  @HiveField(8)
  final String birthNotes;
  @HiveField(9)
  final String resuscitation;
  @HiveField(10)
  final String neoTemperature;
  @HiveField(11)
  final String neoHeartRate;
  @HiveField(12)
  final String neoRespiratoryRate;
  @HiveField(13)
  final String neoOxygenSaturation;
  @HiveField(14)
  final String neoSTS;
  @HiveField(15)
  final String neoNSTS;

  Infant({required this.infantId,
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
    required this.neoNSTS,});
}