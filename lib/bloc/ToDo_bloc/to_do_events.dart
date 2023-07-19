// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:neoroo_app/models/to_do.dart';

class ToDoEvent {}

class AddToDoEvent extends ToDoEvent {
  final String toDoId;
  final String toDoTitle;
  final String toDoBody;
  final String dateTime;
  final String toDoTag;
  AddToDoEvent({
    required this.toDoId,
    required this.toDoTitle,
    required this.toDoBody,
    required this.dateTime,
    required this.toDoTag,
  });
}

class UpdateToDoEvent extends ToDoEvent {
  final ToDo toDo;
  UpdateToDoEvent({
    required this.toDo,
  });
}

class DeleteToDoEvent extends ToDoEvent {
  final ToDo toDo;
  DeleteToDoEvent({
    required this.toDo,
  });
}
