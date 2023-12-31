import 'dart:convert';
import 'package:neoroo_app/models/tracked_attributes.dart';
import 'package:neoroo_app/utils/api_config.dart' as APIConfig;

import 'package:http/http.dart' as http;

class ServerClient {
  Future<http.Response> connectToServer(
      String username, String password, String serverURL) async {
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    return await http.Client().get(Uri.parse(serverURL + APIConfig.loginAPI),
        headers: <String, String>{
          'authorization': basicAuth,
        });
  }

  Future checkForAttribute(
      String username, String password, String serverURL) async {
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));

    String endPoint =
        '$serverURL/api/trackedEntityAttributes.json?paging=false&fields=displayName,shortName,id';

    var response = await http.get(
      Uri.parse(
        endPoint,
      ),
      headers: {
        'Authorization': basicAuth,
      },
    );

    if (response.statusCode != 200) {
      return response;
    }

    List<TrackedAttributes> listOfTrackedAttributesPresent = [];

    final data = jsonDecode(response.body);
    final trackedAttributes = data['trackedEntityAttributes'];

    for (var attribute in trackedAttributes) {
      final displayName = attribute['displayName'];
      final shortName = attribute['shortName'];
      final uid = attribute['id'];

      TrackedAttributes trackedAttributes = TrackedAttributes(
          trackedAttributeId: uid,
          trackedAttributeName: displayName,
          trackedAttributeShortName: shortName);
      listOfTrackedAttributesPresent.add(trackedAttributes);

      print('Display Name: $displayName');
      print('Short Name: $shortName');
      print('UID: $uid');
      print('--------------------');
    }

    return listOfTrackedAttributesPresent;
  }


  Future checkForEntityTypes(
      String username, String password, String serverURL) async {
    String nextPage = '$serverURL/api/trackedEntityTypes?page=1';

    final auth = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    Map<String, String> trackedEntitiesPresent = {};

    while (nextPage != "") {
      var response = await http.get(
        Uri.parse(nextPage),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': auth,
        },
      );
      if (response.statusCode != 200) {
        return response;
      }
      final jsonResponse = jsonDecode(response.body);
      List<dynamic> trackedEntityTypes = jsonResponse["trackedEntityTypes"];
      for (var entity in trackedEntityTypes) {
        String entityName = entity["displayName"];
        String entityID = entity["id"];
        print("$entityName - $entityID");
        print("\n");

        trackedEntitiesPresent.addEntries([MapEntry(entityName, entityID)]);
      }
      String? next = jsonResponse["pager"]["nextPage"];
      if (next == null) {
        nextPage = "";
      } else {
        nextPage = next;
      }

      print(next);
      print(nextPage);
    }
    return trackedEntitiesPresent;
  }

  Future<http.Response> createTrackedEntityAttribute(
      String username,
      String password,
      String serverURL,
      String attributeShortName,
      String attributeName,
      bool isunique) async {
    String endpoint = "$serverURL/api/trackedEntityAttributes";

    final auth = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';
    final requestBody = jsonEncode({
      'name': attributeName,
      'shortName': attributeShortName,
      'valueType': 'TEXT',
      'aggregationType': 'NONE',
      'unique': isunique,
      'confidential': false,
    });

    return await http.post(
      Uri.parse(endpoint),
      headers: {
        'Authorization': auth,
        'Content-Type': 'application/json',
      },
      body: requestBody,
    );
  }

  Future<http.Response> createTrackedEntity(
      String username,
      String password,
      String serverURL,
      List<String> attributeID,
      String trackedEntityName) async {
    String endpoint = '$serverURL/api/trackedEntityTypes?page';
    //String endpoint = '$serverURL/api';
    final auth = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';
    List<Map<String, dynamic>> trackedEntityAttributes = [];

    for (String id in attributeID) {
      final attribute = {
        'trackedEntityAttribute': {
          'id': id,
        },
        'mandatory': false,
        'displayInListNoProgram': true,
        'displayInList': true,
        'searchable': true,
        'sortOrder': 1,
      };

      trackedEntityAttributes.add(attribute);
    }
    final requestBody = {
      'name': trackedEntityName,
      'trackedEntityTypeAttributes': trackedEntityAttributes,
      'trackedEntityTypeDataElements': [],
      'trackedEntityTypeSections': [],
    };
    return await http.post(
      Uri.parse(endpoint),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': auth,
      },
      body: jsonEncode(requestBody),
    );
  }
}
