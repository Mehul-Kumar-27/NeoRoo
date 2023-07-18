// ignore_for_file: public_member_api_docs, sort_constructors_first
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
