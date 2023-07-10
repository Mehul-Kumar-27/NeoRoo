import 'dart:convert';

String loginAPI = "/api/me";
String fetchTEI = "/api/33/trackedEntityInstances";
String fileResources = "/api/fileResources";
String authUtilFunction(String username, String password) {
  String basicAuth =
      'Basic ' + base64Encode(utf8.encode('$username:$password'));
  return basicAuth;
}
