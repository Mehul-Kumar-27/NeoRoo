import 'dart:convert';
import 'package:neoroo_app/utils/api_config.dart' as APIConfig;
import 'package:http/http.dart' as http;

class BabyDetailsClient {
  Future<http.Response> fetchBabyByParent(String username,String password,String organizationUnit,String programId,String parentGroup,String baseURL,String groupAttributeId) async {
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    return http.get(
      Uri.parse("$baseURL"+APIConfig.fetchTEI+"/?ou=$organizationUnit&program=$programId&filter=$groupAttributeId:EQ:$parentGroup"),
      headers: <String,String>{
        'authorization': basicAuth,
      }
    );
  }
}
