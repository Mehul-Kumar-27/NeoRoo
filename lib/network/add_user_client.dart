import 'dart:convert';
import 'package:http/http.dart' as http;

class AddUserCliet {
  Future<http.Response> createUserOnDhis2Server(
      String firstName,
      String lastName,
      String email,
      String username,
      String password,
      String serverURL,
      String adminUsername,
      String adminPassword,
      String organizationUnitID) async {
    final Map<String, dynamic> userData = {
      'firstName': firstName,
      'surname': lastName,
      'email': email,
      "userCredentials": {
        'username': username,
        'password': password,
        'userRoles': [
          {'id': 'XU1iq5y3iqW'}
        ],
      },
      "organisationUnits": [
        {"id": organizationUnitID}
      ],
    };

    String endpoint = "$serverURL/api/users";
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$adminUsername:$adminPassword'));
    final response = await http.post(
      Uri.parse(endpoint),
      headers: {
        'Authorization': basicAuth,
        'Content-Type': 'application/json',
      },
      body: jsonEncode(userData),
    );

    return response;
  }
}
