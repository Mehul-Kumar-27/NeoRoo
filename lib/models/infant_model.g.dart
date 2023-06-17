// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'infant_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InfantAdapter extends TypeAdapter<Infant> {
  @override
  final int typeId = 4;

  @override
  Infant read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Infant(
      infantId: fields[0] as String,
      moterName: fields[1] as String,
      motherUsername: fields[2] as String,
      dateOfBirth: fields[3] as String,
      timeOfBirth: fields[4] as String,
      birthWeight: fields[5] as String,
      bodyLength: fields[6] as String,
      headCircumference: fields[7] as String,
      birthNotes: fields[8] as String,
      resuscitation: fields[9] as String,
      neoTemperature: fields[10] as String,
      neoHeartRate: fields[11] as String,
      neoRespiratoryRate: fields[12] as String,
      neoOxygenSaturation: fields[13] as String,
      neoSTS: fields[14] as String,
      neoNSTS: fields[15] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Infant obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.infantId)
      ..writeByte(1)
      ..write(obj.moterName)
      ..writeByte(2)
      ..write(obj.motherUsername)
      ..writeByte(3)
      ..write(obj.dateOfBirth)
      ..writeByte(4)
      ..write(obj.timeOfBirth)
      ..writeByte(5)
      ..write(obj.birthWeight)
      ..writeByte(6)
      ..write(obj.bodyLength)
      ..writeByte(7)
      ..write(obj.headCircumference)
      ..writeByte(8)
      ..write(obj.birthNotes)
      ..writeByte(9)
      ..write(obj.resuscitation)
      ..writeByte(10)
      ..write(obj.neoTemperature)
      ..writeByte(11)
      ..write(obj.neoHeartRate)
      ..writeByte(12)
      ..write(obj.neoRespiratoryRate)
      ..writeByte(13)
      ..write(obj.neoOxygenSaturation)
      ..writeByte(14)
      ..write(obj.neoSTS)
      ..writeByte(15)
      ..write(obj.neoNSTS);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InfantAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
