import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:neoroo_app/utils/api_config.dart' as APIConfig;

class AuthenticationClient {
  Future<http.Response> loginUser(
      String username, String password, String serverURL) async {
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    return http.Client().get(Uri.parse(serverURL + APIConfig.loginAPI),
        headers: <String, String>{
          'authorization': basicAuth,
        });
  }

  Future<http.Response> getOrganisationName(
      String id, String username, String password, String serverURL) async {
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    return http.Client().get(
        Uri.parse(serverURL + "/api/organisationUnits/" + id),
        headers: <String, String>{
          'authorization': basicAuth,
        });
  }
    Future getUserRoleName(
      String userRoleId, String username, String password, String serverURL) async {
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));

    final response = await http.Client().get(
      Uri.parse(serverURL + '/api/userRoles/$userRoleId'),
      headers: <String, String>{
        'authorization': basicAuth,
      },
    );

    if (response.statusCode == 200) {
      var userRole = json.decode(response.body);
      var userRoleName = userRole['name'];
      print(userRoleName);
      return userRoleName;
    } else {
      print('Failed to fetch user role information: ${response.statusCode}');
    }
  }
}
