// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tracked_attributes.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TrackedAttributesAdapter extends TypeAdapter<TrackedAttributes> {
  @override
  final int typeId = 3;

  @override
  TrackedAttributes read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TrackedAttributes(
      trackedAttributeNameId: fields[0] as String,
      trackedAttributeName: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TrackedAttributes obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.trackedAttributeNameId)
      ..writeByte(1)
      ..write(obj.trackedAttributeName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrackedAttributesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
