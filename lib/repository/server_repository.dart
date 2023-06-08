// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';
import 'package:neoroo_app/models/profile.dart';
import 'package:neoroo_app/models/tracked_attributes.dart';
import 'package:neoroo_app/utils/dhis2_config.dart' as DHIS2Config;
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:neoroo_app/exceptions/custom_exception.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:neoroo_app/network/server_client.dart';
import 'package:neoroo_app/repository/hive_storage_repository.dart';

class ServerRepository {
  final HiveStorageRepository hiveStorageRepository;
  final ServerClient serverClient;
  final BuildContext context;

  ServerRepository(
    this.hiveStorageRepository,
    this.serverClient,
    this.context,
  );

  Future connectToServer() async {
    Profile profile = await hiveStorageRepository.getUserProfile();

    String serverURL = await hiveStorageRepository.getOrganisationURL();
    String username = profile.username;
    String password = profile.password;
    print(username);
    print(password);
    // Write code to connect to the server
    try {
      http.Response response =
          await serverClient.connectToServer(username, password, serverURL);
      if (response.statusCode == 200) {
        return "Sucess";
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

  Future checkForAttributes() async {
    List<String> attributeNameList = DHIS2Config.attributeNameList;
    List<String> attributeToPrepare = [];
    Profile profile = await hiveStorageRepository.getUserProfile();

    String serverURL = await hiveStorageRepository.getOrganisationURL();
    String username = profile.username;
    String password = profile.password;

    // Write code to check for the attributes
    try {
      var response =
          await serverClient.checkForAttribute(username, password, serverURL);
      if (response is Map<String, String>) {
        Map<String, String> attributePresent = response;

        for (var attributeName in attributeNameList) {
          if (!attributePresent.containsKey(attributeName)) {
            print(attributeName);
            attributeToPrepare.add(attributeName);
          } else {
            String attributeId = attributePresent[attributeName]!;
            TrackedAttributes trackedAttributes = TrackedAttributes(
                trackedAttributeNameId: attributeId,
                trackedAttributeName: attributeName);
            await hiveStorageRepository.saveTrackedAttribute(trackedAttributes);
          }
        }

        return attributeToPrepare;
      } else {
        print(response.body);
        print(response.statusCode);
        print('Failed to check tracked entity attribute: ${response.body}');
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

  Future checkForEntityTypes() async {
    List<String> trackedEntityNameList = DHIS2Config.trackedEntityNameList;
    List<String> trackedEntityToPrepare = [];
    Profile profile = await hiveStorageRepository.getUserProfile();
    //String serverURL = "http://10.0.2.2:8080/dhisyoutube";
    String serverURL = await hiveStorageRepository.getOrganisationURL();
    String username = profile.username;
    String password = profile.password;
    try {
      var response =
          await serverClient.checkForEntityTypes(username, password, serverURL);
      if (response is Map<String, String>) {
        Map<String, String> trackedEntitiesPresent = response;

        for (var entityName in trackedEntityNameList) {
          if (!trackedEntitiesPresent.containsKey(entityName)) {
            print(entityName);
            trackedEntityToPrepare.add(entityName);
          } else {
            String entityID = trackedEntitiesPresent[entityName]!;
            TrackedAttributes trackedAttributes = TrackedAttributes(
                trackedAttributeNameId: entityID,
                trackedAttributeName: entityName);
            await hiveStorageRepository.saveTrackedAttribute(trackedAttributes);
          }
        }

        return trackedEntityToPrepare;
      } else {
        print(response.body);
        print(response.statusCode);
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

  Future prepareAttribute(List<String> attributesToPrepare) async {
    Profile profile = await hiveStorageRepository.getUserProfile();

    String serverURL = await hiveStorageRepository.getOrganisationURL();
    String username = profile.username;
    String password = profile.password;
    // Write code to prepare the server
    for (var attribute in attributesToPrepare) {
      String attributeName = attribute;
      bool isunique = false;
      try {
        var response = await serverClient.createTrackedEntityAttribute(
            username, password, serverURL, attributeName, isunique);

        if (response.statusCode == 201) {
          print(response.statusCode);
          print(response.body);

          var jsonResponse = jsonDecode(response.body);
          Map<dynamic, dynamic> attributeInformation = jsonResponse["response"];
          print(attributeInformation["uid"]);
          TrackedAttributes trackedAttributes = TrackedAttributes(
              trackedAttributeNameId: attributeInformation["uid"],
              trackedAttributeName: attributeName);
          await hiveStorageRepository.saveTrackedAttribute(trackedAttributes);
        } else {
          print(response.body);
          print(response.statusCode);
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
    return true;
  }

  getTrackedAttributeId(String attribute) async {
    TrackedAttributes trackedAttributes =
        await hiveStorageRepository.getTarckedAttribute(attribute);
    String id = trackedAttributes.trackedAttributeNameId;
    return id;
  }

  getAttributeId() async {
    List<String> attributeID = [];
    List<String> attributeNameList = DHIS2Config.attributeNameList;

    for (var attributeName in attributeNameList) {
      TrackedAttributes trackedAttributes =
          await hiveStorageRepository.getTarckedAttribute(attributeName);
      attributeID.add(trackedAttributes.trackedAttributeNameId);
    }
    return attributeID;
  }

  Future prepareEntityTypes() async {
    String trackedEntityName = "NeoRoo";
    List<String> attributeID = await getAttributeId();
    Profile profile = await hiveStorageRepository.getUserProfile();

    String serverURL = await hiveStorageRepository.getOrganisationURL();
    String username = profile.username;
    String password = profile.password;
    try {
      var response = await serverClient.createTrackedEntity(
          username, password, serverURL, attributeID, trackedEntityName);

      if (response.statusCode == 201) {
        print(response.body);
        print(response.statusCode);
        var jsonResponse = jsonDecode(response.body);
        Map<dynamic, dynamic> attributeInformation = jsonResponse["response"];
        print(attributeInformation["uid"]);
        TrackedAttributes trackedAttributes = TrackedAttributes(
            trackedAttributeNameId: attributeInformation["uid"],
            trackedAttributeName: trackedEntityName);
        await hiveStorageRepository.saveTrackedAttribute(trackedAttributes);
        return true;
      } else {
        print(response.body);
        print(response.statusCode);
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
}
