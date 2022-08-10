import 'package:hive/hive.dart';
part 'baby_details_caregiver.g.dart';

@HiveType(typeId: 2)
class BabyDetailsCaregiver {
  @HiveField(0)
  final String motherName;
  @HiveField(1)
  final String birthDate;
  @HiveField(2)
  final String birthTime;
  @HiveField(3)
  final double weight;
  @HiveField(4)
  final double bodyLength;
  @HiveField(5)
  final double headCircumference;
  @HiveField(6)
  final bool needResuscitation;
  @HiveField(7)
  final String birthNotes;
  @HiveField(8)
  final String? id;
  @HiveField(9)
  final String? avatarId;
  @HiveField(10)
  final String familyMemberGroup;
  @HiveField(11)
  final String caregiverGroup;
  @HiveField(12)
  final String? imagePath;
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
