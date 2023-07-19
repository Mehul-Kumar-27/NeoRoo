// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'to_do.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ToDoAdapter extends TypeAdapter<ToDo> {
  @override
  final int typeId = 5;

  @override
  ToDo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ToDo(
      todoTrackedInstanceId: fields[0] as String,
      username: fields[1] as String,
      toDoTitle: fields[2] as String,
      toDoBody: fields[3] as String,
      dateTime: fields[4] as String,
      toDoTag: fields[5] as String,
      todoId: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ToDo obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.todoTrackedInstanceId)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.toDoTitle)
      ..writeByte(3)
      ..write(obj.toDoBody)
      ..writeByte(4)
      ..write(obj.dateTime)
      ..writeByte(5)
      ..write(obj.toDoTag)
      ..writeByte(6)
      ..write(obj.todoId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ToDoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
