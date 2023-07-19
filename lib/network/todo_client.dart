import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:neoroo_app/models/to_do.dart';

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

  Future<http.Response> updateToDo(
      String username,
      String password,
      String organizationUnitID,
      String serverURL,
      ToDo toDo,
      Map<String, String> attributesShortNameAndUID) async {
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    List attributes = [
      {
        "attribute": attributesShortNameAndUID["ToDo Id"]!,
        "value": toDo.todoId
      },
      {
        "attribute": attributesShortNameAndUID["ToDo Title"]!,
        "value": toDo.toDoTitle
      },
      {
        "attribute": attributesShortNameAndUID["ToDo body"]!,
        "value": toDo.toDoBody
      },
      {
        "attribute": attributesShortNameAndUID["ToDo tag"]!,
        "value": toDo.toDoTag
      },
      {
        "attribute": attributesShortNameAndUID["ToDo time"]!,
        "value": toDo.toDoTag
      },
      {"attribute": attributesShortNameAndUID["User Id"]!, "value": username},
    ];

    String endpoint =
        "$serverURL/api/trackedEntityInstances/${toDo.todoTrackedInstanceId}";
    Map<String, dynamic> requestBody = {
      "orgUnit": organizationUnitID,
      "attributes": attributes
    };

    final response = await http.put(
      Uri.parse(endpoint),
      headers: {'Authorization': basicAuth, 'Content-Type': 'application/json'},
      body: jsonEncode(requestBody),
    );

    return response;
  }

  Future<http.Response> deleteToDo(String username, String password,
      String organizationUnitID, String serverURL, ToDo toDo) async {
    String endpointUrl =
        '$serverURL/api/33/trackedEntityInstances/${toDo.todoTrackedInstanceId}';
    final authHeader =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';
    return await http.delete(
      Uri.parse(endpointUrl),
      headers: {
        'Authorization': authHeader,
        'Content-Type': 'application/json'
      },
    );
  }
}
