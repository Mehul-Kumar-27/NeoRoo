import 'package:image_picker/image_picker.dart';

class AddBabyEvents {}

class AddBabyEvent extends AddBabyEvents {
  final String motherName;
  final String birthDate;
  final XFile? image;
  final String birthTime;
  final String birthWeight;
  final String bodyLength;
  final String headCircumference;
  final int needResuscitation;
  final String familyMemberGroup;
  final String caregiverGroup;
  final String birthDescription;
  AddBabyEvent({
    required this.motherName,
    required this.birthDate,
    required this.image,
    required this.birthTime,
    required this.birthWeight,
    required this.headCircumference,
    required this.bodyLength,
    required this.birthDescription,
    required this.caregiverGroup,
    required this.familyMemberGroup,
    required this.needResuscitation,
  });
}