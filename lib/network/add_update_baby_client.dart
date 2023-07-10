import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'package:neoroo_app/models/infant_model.dart';

class BabyAddUpdateClient {
  Future<http.Response> addBaby(
      String birthDate,
      String birthNotes,
      String birthTime,
      String birthWeight,
      String bodyLength,
      String cribNumber,
      String headCircumference,
      String needResuscitation,
      String wardNumber,
      String presentWeight,
      String motherName,
      String motherId,
      String stsTime,
      String nstsTime,
      String infantTemperature,
      String infantHeartRate,
      String infantRespiratoryRate,
      String infantBloodOxygen,
      String infantId,
      String? avatarID,
      String username,
      String password,
      String serverURL,
      String organisationUnitID,
      Map<String, String> attributesShortNameAndUID) async {
    List attributes = [
      {
        "attribute": attributesShortNameAndUID["Birth_Date"]!,
        "value": birthDate,
      },
      {
        "attribute": attributesShortNameAndUID["Birth_Notes"]!,
        "value": birthNotes,
      },
      {
        "attribute": attributesShortNameAndUID["Birth Time"]!,
        "value": birthTime,
      },
      {
        "attribute": attributesShortNameAndUID["Birth Weight"]!,
        "value": birthWeight,
      },
      {
        "attribute": attributesShortNameAndUID["Body Length"]!,
        "value": bodyLength,
      },
      {
        "attribute": attributesShortNameAndUID["NCN"]!,
        "value": cribNumber,
      },
      {
        "attribute": attributesShortNameAndUID["NeoRoo_Device_Id"]!,
        "value": "Dummy",
      },
      {
        "attribute": attributesShortNameAndUID["Head Circumference"]!,
        "value": headCircumference,
      },
      {
        "attribute": attributesShortNameAndUID["Require Resuscitation"]!,
        "value": needResuscitation,
      },
      {
        "attribute": attributesShortNameAndUID["Ward Number"]!,
        "value": wardNumber,
      },
      {
        "attribute": attributesShortNameAndUID["Present Weight"]!,
        "value": presentWeight,
      },
      {
        "attribute": attributesShortNameAndUID["Mother Name"]!,
        "value": motherName,
      },
      {
        "attribute": attributesShortNameAndUID["Mother Id"]!,
        "value": motherId,
      },
      {
        "attribute": attributesShortNameAndUID["STS_Time"]!,
        "value": "Dummy",
      },
      {
        "attribute": attributesShortNameAndUID["NSTS_Time"]!,
        "value": "Dummy",
      },
      {
        "attribute": attributesShortNameAndUID["Infant_Temperature"]!,
        "value": "Dummy",
      },
      {
        "attribute": attributesShortNameAndUID["Infant_Heart_Rate"]!,
        "value": "Dummy",
      },
      {
        "attribute": attributesShortNameAndUID["Infant_Respiration_Rate"]!,
        "value": "Dummy",
      },
      {
        "attribute": attributesShortNameAndUID["Infant_Blood_Oxygen"]!,
        "value": "Dummy",
      },
      {
        "attribute": attributesShortNameAndUID["infant_ID"]!,
        "value": infantId,
      },
    ];
    if (avatarID != null) {
      attributes.add(
        {
          "attribute": attributesShortNameAndUID["NeoRoo_TEI_avatar"]!,
          "value": avatarID,
        },
      );
    } else {
      attributes.add(
        {
          "attribute": attributesShortNameAndUID["NeoRoo_TEI_avatar"]!,
          "value": "Dummy",
        },
      );
    }
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    return http.Client().post(
      Uri.parse("$serverURL/api/trackedEntityInstances"),
      body: jsonEncode(
        {
          "trackedEntityType": attributesShortNameAndUID["NeoRoo"]!,
          "orgUnit": organisationUnitID,
          "attributes": attributes,
        },
      ),
      headers: {'authorization': basicAuth, "Content-Type": "application/json"},
    );
  }

  Future<http.Response> uploadImageToDhis2(
      XFile image, String username, String password, String serverURL) async {
    String extension = image.path.split(".").last;
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    http.MultipartRequest request = http.MultipartRequest(
      'POST',
      Uri.parse("$serverURL/api/fileResources"),
    );
    request.files.add(
      http.MultipartFile.fromBytes('file', File(image.path).readAsBytesSync(),
          filename: image.path.split("/").last,
          contentType: MediaType('image', extension)),
    );
    request.headers['authorization'] = basicAuth;
    request.fields["domain"] = "USER_AVATAR";

    return http.Response.fromStream(await request.send());
  }

  Future<http.Response> searchMother(
      String username, String password, String serverURL) async {
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    String userRoleName = "Family Member";

    String endpoint =
        "$serverURL/api/users.json?paging=false&filter=userCredentials.userRoles.name:eq:$userRoleName&fields=id,name,userCredentials[username]";
    print(endpoint);
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

  Future<http.Response> updateBaby(
      Infant infant,
      String username,
      String password,
      String organisationUnitID,
      String serverURL,
      Map<String, String> attributesShortNameAndUID) async {
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    String endpoint =
        "$serverURL/api/trackedEntityInstances/${infant.infantTrackedInstanceID}";
    List attributes = [
      {
        "attribute": attributesShortNameAndUID["Birth_Date"]!,
        "value": infant.dateOfBirth,
      },
      {
        "attribute": attributesShortNameAndUID["Birth_Notes"]!,
        "value": infant.birthNotes,
      },
      {
        "attribute": attributesShortNameAndUID["Birth Time"]!,
        "value": infant.timeOfBirth,
      },
      {
        "attribute": attributesShortNameAndUID["Birth Weight"]!,
        "value": infant.birthWeight,
      },
      {
        "attribute": attributesShortNameAndUID["Body Length"]!,
        "value": infant.bodyLength,
      },
      {
        "attribute": attributesShortNameAndUID["NCN"]!,
        "value": infant.cribNumber,
      },
      {
        "attribute": attributesShortNameAndUID["NeoRoo_Device_Id"]!,
        "value": "NeoRoo_Device_Id",
      },
      {
        "attribute": attributesShortNameAndUID["Head Circumference"]!,
        "value": infant.headCircumference,
      },
      {
        "attribute": attributesShortNameAndUID["Require Resuscitation"]!,
        "value": infant.resuscitation,
      },
      {
        "attribute": attributesShortNameAndUID["Ward Number"]!,
        "value": infant.wardNumber,
      },
      {
        "attribute": attributesShortNameAndUID["Present Weight"]!,
        "value": infant.presentWeight,
      },
      {
        "attribute": attributesShortNameAndUID["Mother Name"]!,
        "value": infant.moterName,
      },
      {
        "attribute": attributesShortNameAndUID["Mother Id"]!,
        "value": infant.motherUsername,
      },
      {
        "attribute": attributesShortNameAndUID["STS_Time"]!,
        "value": infant.neoSTS,
      },
      {
        "attribute": attributesShortNameAndUID["NSTS_Time"]!,
        "value": infant.neoNSTS,
      },
      {
        "attribute": attributesShortNameAndUID["Infant_Temperature"]!,
        "value": infant.neoTemperature,
      },
      {
        "attribute": attributesShortNameAndUID["Infant_Heart_Rate"]!,
        "value": infant.neoHeartRate,
      },
      {
        "attribute": attributesShortNameAndUID["Infant_Respiration_Rate"]!,
        "value": infant.neoRespiratoryRate,
      },
      {
        "attribute": attributesShortNameAndUID["Infant_Blood_Oxygen"]!,
        "value": infant.neoOxygenSaturation,
      },
      {
        "attribute": attributesShortNameAndUID["infant_ID"]!,
        "value": infant.infantId,
      },
      {
        "attribute": attributesShortNameAndUID["NeoRoo_TEI_avatar"]!,
        "value": "Dummy",
      },
    ];

    Map<String, dynamic> requestBody = {
      "orgUnit": organisationUnitID,
      "attributes": attributes
    };
    final response = await http.put(
      Uri.parse(endpoint),
      headers: {'Authorization': basicAuth, 'Content-Type': 'application/json'},
      body: jsonEncode(requestBody),
    );

    return response;
  }
}
