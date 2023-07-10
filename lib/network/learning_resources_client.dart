import 'dart:convert';
import 'package:neoroo_app/utils/api_config.dart' as APIConfig;
import 'package:http/http.dart' as http;

class LearningResourcesClient{
  Future<http.Response> fetchVideos(String username,String password,String baseURL){
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    return http.Client().get(
      Uri.parse(baseURL),
      headers: {'authorization': basicAuth}
    );
  }
}