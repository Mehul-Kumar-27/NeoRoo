import 'dart:convert';
import 'package:http/http.dart' as http;

class FetchBabyFromECEBClient {
  Future<http.Response> getInfantsFromECEB(String username, String password,
      String serverURL, String organisatioUnit, String trackedEntityId) async {
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    String endpoint =
        '$serverURL/api/trackedEntityInstances?ou=$organisatioUnit&trackedEntityType=$trackedEntityId&fields=trackedEntityInstance,orgUnit,attributes[attribute,value,displayName]';
    var response = await http.get(
      Uri.parse(endpoint),
      headers: {
        'Authorization': basicAuth,
      },
    );

    print(response.statusCode);
    print(response.body);

    return response;
  }
}
