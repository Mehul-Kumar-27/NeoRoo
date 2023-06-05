import 'dart:convert';
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

  Future<http.Response> checkForAttribute(
      String username, String password, String serverURL) async {
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));

    String endpoint = '$serverURL/api/trackedEntityAttributes';
    //String endpoint = '$serverURL/api';

    return await http.get(
      Uri.parse(
        endpoint,
      ),
      headers: {
        'Authorization': basicAuth,
      },
    );
  }

  Future<http.Response> checkForEntityTypes(
      String username, String password, String serverURL) async {
    String endpoint = '$serverURL/api/trackedEntityTypes';

    final auth = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    return await http.get(
      Uri.parse(endpoint),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': auth,
      },
    );
  }

  Future<http.Response> createTrackedEntityAttribute(
      String username,
      String password,
      String serverURL,
      String attributeName,
      bool isunique) async {
    String endpoint = "$serverURL/api/trackedEntityAttributes";

    final auth = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';
    final requestBody = jsonEncode({
      'name': attributeName,
      'shortName': attributeName,
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
    String endpoint = '$serverURL/api/trackedEntityTypes';
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
