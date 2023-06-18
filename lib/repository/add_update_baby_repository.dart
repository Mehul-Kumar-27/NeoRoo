import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neoroo_app/exceptions/custom_exception.dart';
import 'package:http/http.dart' as http;
import 'package:neoroo_app/models/infant_mother.dart';
import 'package:neoroo_app/models/profile.dart';
import 'package:neoroo_app/models/tracked_attributes.dart';
import 'package:neoroo_app/network/add_update_baby_client.dart';
import 'package:neoroo_app/repository/hive_storage_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:neoroo_app/repository/secure_storage_repository.dart';
import 'package:neoroo_app/utils/dhis2_config.dart' as DHIS2Config;

class AddUpdateBabyRepository {
  final HiveStorageRepository hiveStorageRepository;
  final BabyAddUpdateClient babyAddUpdateClient;
  final BuildContext context;
  AddUpdateBabyRepository({
    required this.babyAddUpdateClient,
    required this.hiveStorageRepository,
    required this.context,
  });
  Future<Either<bool, CustomException>> addBaby(
      String birthDate,
      String birthNotes,
      String birthTime,
      String birthWeight,
      String bodyLength,
      String cribNumber,
      String headCircumference,
      String needResudcitation,
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
      XFile? avatarFile,
      String username,
      String password,
      String serverURL,
      String organisationUnitID) async {
    String? avatarId;
    try {
      if (avatarFile != null) {
        http.Response imageUploadResponse = await babyAddUpdateClient
            .uploadImageToDhis2(avatarFile, username, password, serverURL);
        print(imageUploadResponse.statusCode);
        print(imageUploadResponse.body);
        if (imageUploadResponse.statusCode == 401 ||
            imageUploadResponse.statusCode == 403) {
          return Right(
            UnauthorisedException(
              AppLocalizations.of(context).unauthorized,
              imageUploadResponse.statusCode,
            ),
          );
        } else if (imageUploadResponse.statusCode == 200) {
          return Right(
            FetchDataException(
              AppLocalizations.of(context).errorDuringCommunication,
              null,
            ),
          );
        } else {
          avatarId = jsonDecode(imageUploadResponse.body)["response"]
              ["fileResource"]["id"];
          print("\n");
          print(avatarId);
        }
      }

      Map<String, String> attributesShortNameAndUID =
          await trackedAttributesAndUID();

      http.Response response = await babyAddUpdateClient.addBaby(
        birthDate,
        birthNotes,
        birthTime,
        birthWeight,
        bodyLength,
        cribNumber,
        headCircumference,
        needResudcitation,
        wardNumber,
        presentWeight,
        motherName,
        motherId,
        stsTime,
        nstsTime,
        infantTemperature,
        infantHeartRate,
        infantRespiratoryRate,
        infantBloodOxygen,
        infantId,
        avatarId,
        username,
        password,
        serverURL,
        organisationUnitID,
        attributesShortNameAndUID,
      );

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        print(responseBody);

        return Left(true);
      }
      if (response.statusCode == 401 || response.statusCode == 403) {
        return Right(
          UnauthorisedException(
            AppLocalizations.of(context).unauthorized,
            response.statusCode,
          ),
        );
      } else {
        print(response.statusCode);
        return Right(
          FetchDataException(
            AppLocalizations.of(context).errorDuringCommunication,
            null,
          ),
        );
      }
    } catch (e) {
      print(e);

      return Left(true);
    }
  }

  Future<Either<List<Mother>, CustomException>> getMother() async {
    Profile profile = await hiveStorageRepository.getUserProfile();
    String username = profile.username;
    String password = profile.password;
    String serverURL = await hiveStorageRepository.getOrganisationURL();
    List<Mother> motherInServer = [];
    var response =
        await babyAddUpdateClient.searchMother(username, password, serverURL);

    if (response.statusCode == 200) {
      final roleData = jsonDecode(response.body);
      final users = roleData["users"];
      for (var user in users) {
        String displayName = user["name"];
        String motherID = user["id"];
        String motherUserName = user["userCredentials"]["username"];
        Mother mother = Mother(displayName, motherID, motherUserName);
        motherInServer.add(mother);
      }
      return Left(motherInServer);
    } else {
      return Right(
        FetchDataException(
          AppLocalizations.of(context).errorDuringCommunication,
          null,
        ),
      );
    }
  }

  Future<Map<String, String>> trackedAttributesAndUID() async {
    HiveStorageRepository hiveStorageRepository =
        HiveStorageRepository(SecureStorageRepository);
    Map<String, String> trackedAttributesAndUID = {};
    Map<String, String> neoRooAttributes = DHIS2Config.neoRooRequiredAttributes;

    for (var shortName in neoRooAttributes.keys) {
      TrackedAttributes trackedAttribute =
          await hiveStorageRepository.getTarckedAttribute(shortName);
      String trackedAttributeUID = trackedAttribute.trackedAttributeId;
      trackedAttributesAndUID
          .addEntries([MapEntry(shortName, trackedAttributeUID)]);
    }
    TrackedAttributes attributes =
        await hiveStorageRepository.getTarckedAttribute("NeoRoo");
    trackedAttributesAndUID.addEntries([
      MapEntry(attributes.trackedAttributeName, attributes.trackedAttributeId)
    ]);

    return trackedAttributesAndUID;
  }
}
