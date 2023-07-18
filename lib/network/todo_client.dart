import 'dart:convert';
import 'package:http/http.dart' as http;

class AddUpdateDeleteToDoClient {
  Future<http.Response> addToDo(
      String username,
      String password,
      String organizationUnitID,
      String serverURL,
      String toDoId,
      String toDoTitle,
      String toDoBody,
      String dateTime,
      String toDoTag,
      Map<String, String> attributesShortNameAndUID) async {
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    List attributes = [
      {"attribute": attributesShortNameAndUID["ToDo Id"]!, "value": toDoId},
      {
        "attribute": attributesShortNameAndUID["ToDo Title"]!,
        "value": toDoTitle
      },
      {"attribute": attributesShortNameAndUID["ToDo body"]!, "value": toDoBody},
      {"attribute": attributesShortNameAndUID["ToDo tag"]!, "value": toDoTag},
      {"attribute": attributesShortNameAndUID["ToDo time"]!, "value": dateTime},
      {"attribute": attributesShortNameAndUID["User Id"]!, "value": username},
    ];

    return http.Client().post(
      Uri.parse("$serverURL/api/trackedEntityInstances"),
      body: jsonEncode({
        "trackedEntityType": attributesShortNameAndUID["ToDo"]!,
        "orgUnit": organizationUnitID,
        "attributes": attributes,
      }),
      headers: {'authorization': basicAuth, "Content-Type": "application/json"},
    );
  }
}
