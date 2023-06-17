import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'dart:convert';

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
    print(attributesShortNameAndUID["Birth_Date"]!);
    print("Birth_Date");
    print(attributesShortNameAndUID["Birth_Notes"]!);
    print("Birth_Notes");
    print(attributesShortNameAndUID["Birth Time"]!);
    print("Birth Time");
    print(attributesShortNameAndUID["Birth Weight"]!);
    print("Birth Weight");

    print(attributesShortNameAndUID["Body Length"]!);
    print("Body Length");
    print(attributesShortNameAndUID["NCN"]!);
    print("NCN");
    print(attributesShortNameAndUID["NeoRoo_Device_Id"]!);
    print("NeoRoo_Device_Id");
    print(attributesShortNameAndUID["Head Circumference"]!);
    print("Head Circumference");
    print(attributesShortNameAndUID["Require Resuscitation"]!);
    print("Require Resuscitation");
    print(attributesShortNameAndUID["Ward Number"]!);
    print("Ward Number");
    print(attributesShortNameAndUID["Present Weight"]!);
    print("Present Weight");
    print(attributesShortNameAndUID["Mother Name"]!);
    print("Mother Name");
    print(attributesShortNameAndUID["Mother Id"]!);
    print("Mother Id");
    print(attributesShortNameAndUID["STS_Time"]!);
    print("STS_Time");
    print(attributesShortNameAndUID["NSTS_Time"]!);
    print("NSTS_Time");
    print(attributesShortNameAndUID["Infant_Temperature"]!);
    print("Infant_Temperature");
    print(attributesShortNameAndUID["Infant_Heart_Rate"]!);
    print("Infant_Heart_Rate");
    print(attributesShortNameAndUID["Infant_Respiration_Rate"]!);
    print("Infant_Respiratory_Rate");
    print(attributesShortNameAndUID["Infant_Blood_Oxygen"]!);
    print("Infant_Blood_Oxygen");
    print(attributesShortNameAndUID["infant_ID"]!);
    print("Infant_Id");
    print(attributesShortNameAndUID["NeoRoo_TEI_avatar"]!);
    print("Avatar_Id");
    print(attributesShortNameAndUID["NeoRoo"]!);
    print("NeoRoo");

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
        "value": "NeoRoo_Device_Id",
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
        "value": stsTime,
      },
      {
        "attribute": attributesShortNameAndUID["NSTS_Time"]!,
        "value": nstsTime,
      },
      {
        "attribute": attributesShortNameAndUID["Infant_Temperature"]!,
        "value": infantTemperature,
      },
      {
        "attribute": attributesShortNameAndUID["Infant_Heart_Rate"]!,
        "value": infantHeartRate,
      },
      {
        "attribute": attributesShortNameAndUID["Infant_Respiration_Rate"]!,
        "value": infantRespiratoryRate,
      },
      {
        "attribute": attributesShortNameAndUID["Infant_Blood_Oxygen"]!,
        "value": infantBloodOxygen,
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

  Future<http.Response> uploadImage(
      XFile image, String username, String password, String serverURL) async {
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    http.MultipartRequest request = http.MultipartRequest(
      'POST',
      Uri.parse(serverURL),
    );
    request.files.add(
      http.MultipartFile.fromBytes(
        'file',
        File(image.path).readAsBytesSync(),
        filename: image.path.split("/").last,
      ),
    );
    request.headers['authorization'] = basicAuth;
    request.fields["domain"] = "USER_AVATAR";
    return http.Response.fromStream(await request.send());
  }

  Future<http.Response> searchMother(
      String username, String password, String serverURL) async {
    print(username);
    print(password);
    print("$serverURL ,bsdvsvbsdkdvbsdkbvskdbvskjddbvkjsvjwgfejkgsfjkgs");
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
}
