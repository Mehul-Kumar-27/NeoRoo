import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../utils/api_config.dart' as APIConfig;
import 'dart:convert';
import '../utils/dhis2_config.dart' as DHIS2Config;

class BabyAddUpdateClient {
  Future<http.Response> addBaby(
    String birthTime,
    String birthDate,
    double headCircumference,
    double birthWeight,
    String birthNotes,
    String motherName,
    double bodyLength,
    String familyMemberUserGroup,
    String caregiverUserGroup,
    int requireResuscitation,
    String? avatarId,
    String username,
    String password,
    String serverURL,
    String orgId,
  ) async {
    List attributes = [
      {
        "attribute": DHIS2Config.birthTime,
        "value": birthTime,
      },
      {
        "attribute": DHIS2Config.headCircumference,
        "value": headCircumference,
      },
      {
        "attribute": DHIS2Config.birthNotes,
        "value": birthNotes,
      },
      {
        "attribute": DHIS2Config.birthWeight,
        "value": birthWeight,
      },
      {
        "attribute": DHIS2Config.motherName,
        "value": motherName,
      },
      {
        "attribute": DHIS2Config.bodyLength,
        "value": bodyLength,
      },
      {
        "attribute": DHIS2Config.birthDate,
        "value": birthDate,
      },
      {
        "attribute": DHIS2Config.familyMemberUserGroup,
        "value": familyMemberUserGroup,
      },
      {
        "attribute": DHIS2Config.caregiverUserGroup,
        "value": caregiverUserGroup,
      },
      {
        "attribute": DHIS2Config.requireResuscitation,
        "value": requireResuscitation,
      },
    ];
    if (avatarId != null) {
      attributes.add(
        {
          "attribute": DHIS2Config.avatarIdAttribute,
          "value": avatarId,
        },
      );
    }
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    return http.Client().post(
      Uri.parse(serverURL),
      body: jsonEncode(
        {
          "trackedEntityType": DHIS2Config.trackedEntityType,
          "orgUnit": orgId,
          "attributes": attributes,
          "enrollments": [
            {
              "orgUnit": orgId,
              "program": DHIS2Config.trackerProgramId,
            }
          ]
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
}
