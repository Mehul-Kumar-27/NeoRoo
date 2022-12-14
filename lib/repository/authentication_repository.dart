import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:local_auth/local_auth.dart';
import 'package:neoroo_app/exceptions/custom_exception.dart';
import 'package:neoroo_app/models/profile.dart';
import 'package:neoroo_app/network/authentication_client.dart';
import 'package:neoroo_app/repository/hive_storage_repository.dart';
import 'package:http/http.dart' as http;
import 'package:neoroo_app/utils/dhis2_config.dart' as DHIS2Config;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:neoroo_app/utils/dhis2_config.dart';


class AuthenticationRepository {
  final HiveStorageRepository hiveStorageRepository;
  final AuthenticationClient authenticationClient;
  final BuildContext context;
  AuthenticationRepository({
    required this.hiveStorageRepository,
    required this.authenticationClient,
    required this.context,
  });

  Future loginUser(String username, String password, String serverURL) async {
    if (serverURL.trim().isEmpty ||
        password.trim().isEmpty ||
        username.trim().isEmpty) {
      return CustomException(
        AppLocalizations.of(context).emptyFieldsInRequest,
        null,
      );
    }
    try {
      http.Response response =
          await authenticationClient.loginUser(username, password, serverURL);
      if (response.statusCode == 200) {
        Map body = jsonDecode(response.body);
        String? avatarId;
        List<String> organisationUnits = [];
        if (body.containsKey("avatar")) {
          Map<String, dynamic> avatar = body["avatar"];
          if (avatar.containsKey("id")) {
            avatarId = avatar["id"];
          }
        }
        var orgUnitList = body["organisationUnits"];
        for (int i = 0; i < orgUnitList.length; i++) {
          organisationUnits.add(orgUnitList[i]["id"]);
        }
        List<String> userGroups = [];
        bool isCareGiver = false;
        for (int i = 0; i < body["userGroups"].length; i++) {
          if (body["userGroups"][i]["id"] == caregiverGroup) {
            isCareGiver = true;
          } else if (body["userGroups"][i]["id"] ==
              DHIS2Config.familyMemberGroup) {
            isCareGiver = false;
          } else {
            userGroups.add(
              body["userGroups"][i]["id"],
            );
          }
        }
        await hiveStorageRepository.setIsCareGiver(isCareGiver);
        await hiveStorageRepository.setUserGroups(userGroups);
        await hiveStorageRepository.saveUserProfile(
            Profile(avatarId, body["name"], password, username, body["id"]));
        await hiveStorageRepository.saveCredentials(
            username, password, serverURL, avatarId, body["name"]);
        await hiveStorageRepository.saveOrganisationURL(serverURL);
        await hiveStorageRepository.saveOrganisations(organisationUnits);
        return {
          "profile": Profile(
            avatarId,
            body["name"],
            password,
            username,
            body["id"],
          ),
          "orgUnits": organisationUnits
        };
      }
      if (response.statusCode == 400) {
        return BadRequestException(
          AppLocalizations.of(context).invalidRequest,
          response.statusCode,
        );
      }
      if (response.statusCode == 401) {
        return UnauthorisedException(
          AppLocalizations.of(context).unauthorized,
          response.statusCode,
        );
      }
      if (response.statusCode == 403) {
        return UnauthorisedException(
          AppLocalizations.of(context).invalidInput,
          response.statusCode,
        );
      } else {
        return FetchDataException(
          AppLocalizations.of(context).errorDuringCommunication,
          response.statusCode,
        );
      }
    } on SocketException {
      return FetchDataException(
        AppLocalizations.of(context).noInternet,
        null,
      );
    } catch (e) {
      print(e);
      return FetchDataException(
        AppLocalizations.of(context).errorDuringCommunication,
        null,
      );
    }
  }

  Future getOrganisationListDetails() async {
    Profile profile = await hiveStorageRepository.getUserProfile();
    String url = await hiveStorageRepository.getOrganisationURL();
    List<String> organisationUnits =
        await hiveStorageRepository.getSavedOrganisations();
    List<String?> orgNames = [];
    String username = profile.username;
    String password = profile.password;
    for (int i = 0; i < organisationUnits.length; i++) {
      try {
        http.Response response = await authenticationClient.getOrganisationName(
          organisationUnits[i],
          username,
          password,
          url,
        );
        if (response.statusCode != 200) {
          throw CustomException("x", null);
        } else {
          Map<String, dynamic> body = jsonDecode(response.body);
          orgNames.add(body["name"]);
        }
      } catch (e) {
        orgNames.add(null);
      }
    }
    return [orgNames, organisationUnits];
  }

  Future<void> selectOrganisation(String id, String? name) async {
    await hiveStorageRepository.saveSelectedOrganisation(id, name);
  }

  Future<Map<String, dynamic>> isLocalAuthSupported() async {
    final LocalAuthentication auth = LocalAuthentication();
    final bool canAuthenticate =
        (await auth.canCheckBiometrics) || await auth.isDeviceSupported();
    if (!canAuthenticate) {
      return {
        "status": canAuthenticate,
        "message": AppLocalizations.of(context).localAuthNotSupported
      };
    } else {
      return {"status": canAuthenticate};
    }
  }

  Future<Map<String, dynamic>> getSavedCredentials() async {
    Map<String, List<String>> savedCredentials =
        await hiveStorageRepository.getSavedCredentials();
    if (savedCredentials.keys.isEmpty) {
      return {
        "status": false,
        "message": AppLocalizations.of(context).noCredentialsSaved
      };
    } else {
      return {"status": true, "data": savedCredentials};
    }
  }
}
