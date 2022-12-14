import 'package:hive/hive.dart';
part 'baby_details_caregiver.g.dart';

@HiveType(typeId: 2)
class BabyDetailsCaregiver {
  @HiveField(0)
  String motherName;
  @HiveField(1)
  String birthDate;
  @HiveField(2)
  String birthTime;
  @HiveField(3)
  double weight;
  @HiveField(4)
  double bodyLength;
  @HiveField(5)
  double headCircumference;
  @HiveField(6)
  bool needResuscitation;
  @HiveField(7)
  String birthNotes;
  @HiveField(8)
  String? id;
  @HiveField(9)
  String? avatarId;
  @HiveField(10)
  String familyMemberGroup;
  @HiveField(11)
  String caregiverGroup;
  @HiveField(12)
  String? imagePath;
  BabyDetailsCaregiver({
    required this.birthDate,
    required this.birthNotes,
    required this.birthTime,
    required this.bodyLength,
    required this.headCircumference,
    required this.id,
    required this.motherName,
    required this.needResuscitation,
    required this.weight,
    required this.avatarId,
    required this.caregiverGroup,
    required this.familyMemberGroup,
    required this.imagePath,
  });
}
