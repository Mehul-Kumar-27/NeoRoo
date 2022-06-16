import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/api_config.dart' as APIConfig;

class AuthenticationClient{
  Future<http.Response> loginUser(String username,String password,String serverURL)async{
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    return http.Client().get(
      Uri.parse(serverURL+APIConfig.loginAPI),
      headers: <String,String>{
        'authorization': basicAuth,
      }
    );
  }
  Future<http.Response> getOrganisationName(String id,String username,String password,String serverURL)async{

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    return http.Client().get(
      Uri.parse(serverURL+"/api/organisationUnits/"+id),
      headers: <String,String>{
        'authorization': basicAuth,
      }
    );
  }
}