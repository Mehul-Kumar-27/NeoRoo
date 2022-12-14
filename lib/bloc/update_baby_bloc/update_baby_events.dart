class UpdateBabyEvents{}

class UpdateBabyEvent extends UpdateBabyEvents{
  final int index;
  final String motherName;
  final String birthDate;
  final String birthTime;
  final String birthWeight;
  final String bodyLength;
  final String headCircumference;
  final int needResuscitation;
  final String familyMemberGroup;
  final String caregiverGroup;
  final String birthDescription;

  UpdateBabyEvent({
    required this.motherName,
    required this.birthDate,
    required this.index,
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