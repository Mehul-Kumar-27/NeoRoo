// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';
part 'to_do.g.dart';
@HiveType(typeId: 5)
class ToDo {
  @HiveField(0)
  late final String todoTrackedInstanceId;
  @HiveField(1)
  late final String username;
  @HiveField(2)
  late final String toDoTitle;
  @HiveField(3)
  late final String toDoBody;
  @HiveField(4)
  late final String dateTime;
  @HiveField(5)
  late final String toDoTag;
  @HiveField(6)
  late final String todoId;
  ToDo(
      {required this.todoTrackedInstanceId,
      required this.username,
      required this.toDoTitle,
      required this.toDoBody,
      required this.dateTime,
      required this.toDoTag,
      required this.todoId});
  ToDo.fromJson(Map<String, dynamic> json) {
    List<dynamic> attributeList = json['attributes'];
    todoTrackedInstanceId = json['trackedEntityInstance'];
    for (var element in attributeList) {
      String displayName = element['displayName'];
      if (displayName == "ToDo Id") {
        todoId = element['value'];
      } else if (displayName == "ToDo Title") {
        toDoTitle = element['value'];
      } else if (displayName == "ToDo body") {
        toDoBody = element["value"];
      } else if (displayName == "ToDo tag") {
        toDoTag = element["value"];
      } else if (displayName == "ToDo time") {
        dateTime = element["value"];
      } else if (displayName == "User Id") {
        username = element["value"];
      } else {
        print("Unknown attribute: $displayName");
      }
    }
  }
}
