import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:neoroo_app/models/infant_model.dart';

class FetchBabyClient {
  Stream<List<Infant>> fetchInfant(String username, String password,
      String serverURL, String trackedEntityId, String organisatioUnit) async* {
    List<Infant> infantOnServer = [];
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    String endpoint =
        '$serverURL/api/trackedEntityInstances?ou=$organisatioUnit&trackedEntityType=$trackedEntityId&fields=trackedEntityInstance,orgUnit,attributes[attribute,value,displayName]';
    var response = await http.get(
      Uri.parse(endpoint),
      headers: {'Authorization': basicAuth, 'Content-Type': 'application/json'},
    );

    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      Map<String, dynamic> mapData = jsonDecode(response.body);
      List<dynamic> infantList = mapData['trackedEntityInstances'];

      for (var infant in infantList) {
        Infant infantModel = Infant.fromJson(infant);
        infantOnServer.add(infantModel);
      }
      yield* Stream.value(infantOnServer);
    } else {
      response = response.statusCode as http.Response;
      print(response.body);
      throw Exception('Failed to load medicines: ${response.body}');
    }
  }
}
