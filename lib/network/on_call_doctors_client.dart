import 'dart:convert';
import 'package:http/http.dart' as http;

class OnCallDoctorsClient {
  Future<http.Response> getOnCallDoctors(
      String username,
      String password,
      String organizationUnit,
      String serverURL,
      String onCallDoctorsTrackedEntityID) async {
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    String endpoint =
        '$serverURL/api/trackedEntityInstances?ou=$organizationUnit&trackedEntityType=$onCallDoctorsTrackedEntityID&fields=trackedEntityInstance,orgUnit,attributes[attribute,value,displayName]';

    var response = await http.get(
      Uri.parse(endpoint),
      headers: {'Authorization': basicAuth, 'Content-Type': 'application/json'},
    );

    print(response.body);
    print(response.statusCode);

    return response;
  }
}
