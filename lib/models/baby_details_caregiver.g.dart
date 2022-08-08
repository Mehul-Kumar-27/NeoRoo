// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'baby_details_caregiver.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BabyDetailsCaregiverAdapter extends TypeAdapter<BabyDetailsCaregiver> {
  @override
  final int typeId = 2;

  @override
  BabyDetailsCaregiver read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BabyDetailsCaregiver(
      birthDate: fields[1] as String,
      birthNotes: fields[7] as String,
      birthTime: fields[2] as String,
      bodyLength: fields[4] as double,
      headCircumference: fields[5] as double,
      id: fields[8] as String,
      motherName: fields[0] as String,
      needResuscitation: fields[6] as bool,
      weight: fields[3] as double,
      avatarId: fields[9] as String?,
      caregiverGroup: fields[11] as String,
      familyMemberGroup: fields[10] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BabyDetailsCaregiver obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.motherName)
      ..writeByte(1)
      ..write(obj.birthDate)
      ..writeByte(2)
      ..write(obj.birthTime)
      ..writeByte(3)
      ..write(obj.weight)
      ..writeByte(4)
      ..write(obj.bodyLength)
      ..writeByte(5)
      ..write(obj.headCircumference)
      ..writeByte(6)
      ..write(obj.needResuscitation)
      ..writeByte(7)
      ..write(obj.birthNotes)
      ..writeByte(8)
      ..write(obj.id)
      ..writeByte(9)
      ..write(obj.avatarId)
      ..writeByte(10)
      ..write(obj.familyMemberGroup)
      ..writeByte(11)
      ..write(obj.caregiverGroup);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BabyDetailsCaregiverAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
