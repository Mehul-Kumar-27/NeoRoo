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
    Map<String, String> neoRooShortNameMapRequired =
        DHIS2Config.neoRooRequiredAttributes;
    Map<String, String> ecebShortNameMapRequired =
        DHIS2Config.ecebRequiredAttributeList;
    Map<String, String> onCallDoctorsAttributeList =
        DHIS2Config.onCallDoctorsAttributeList;
    Map<String, String> toDoAttributeList = DHIS2Config.toDoAttributeList;
    List<String> attributeToPrepare = [];
    Profile profile = await hiveStorageRepository.getUserProfile();

    String serverURL = await hiveStorageRepository.getOrganisationURL();
    String username = profile.username;
    String password = profile.password;

    // Write code to check for the attributes
    try {
      // Get all the attributes that are present on the DHIS2 server
      var response =
          await serverClient.checkForAttribute(username, password, serverURL);
      if (response is List<TrackedAttributes>) {
        List<TrackedAttributes> listOfTrackedAttributesPresentOnServer =
            response;
        for (var attributeShortName in neoRooShortNameMapRequired.keys) {
          bool attributeFound = false;
          for (var attribute in listOfTrackedAttributesPresentOnServer) {
            if (attribute.trackedAttributeShortName == attributeShortName) {
              await hiveStorageRepository.saveTrackedAttribute(attribute);
              attributeFound = true;
            }
          }
          if (attributeFound == false) {
            attributeToPrepare.add(attributeShortName);
          }
        }

        ///This section is for attributes for the ECEB Program
        for (var ecebAttributeShortName in ecebShortNameMapRequired.keys) {
          for (var attribute in listOfTrackedAttributesPresentOnServer) {
            if (attribute.trackedAttributeShortName == ecebAttributeShortName) {
              await hiveStorageRepository.saveTrackedAttribute(attribute);
            }
          }
        }

        // This Section is for the On call doctors
        for (var onCallDoctorsShortName in onCallDoctorsAttributeList.keys) {
          for (var attribute in listOfTrackedAttributesPresentOnServer) {
            if (attribute.trackedAttributeShortName == onCallDoctorsShortName) {
              await hiveStorageRepository.saveTrackedAttribute(attribute);
            }
          }
        }

        // This Section is for the todo section of the application.
        for (var toDoAttributeShortName in toDoAttributeList.keys) {
          for (var attribute in listOfTrackedAttributesPresentOnServer) {
            if (attribute.trackedAttributeShortName == toDoAttributeShortName) {
              await hiveStorageRepository.saveTrackedAttribute(attribute);
            }
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
                trackedAttributeId: entityID,
                trackedAttributeName: entityName,
                trackedAttributeShortName: entityName);
            await hiveStorageRepository.saveTrackedAttribute(trackedAttributes);
          }
        }

        /// This section is for the eceb program
        for (var entityName in trackedEntitiesPresent.keys) {
          if (entityName == DHIS2Config.ecebEntityName) {
            String entityID = trackedEntitiesPresent[entityName]!;
            TrackedAttributes trackedAttributes = TrackedAttributes(
                trackedAttributeId: entityID,
                trackedAttributeName: entityName,
                trackedAttributeShortName: entityName);
            await hiveStorageRepository.saveTrackedAttribute(trackedAttributes);
          }
        }

        /// This section is for the on call doctor program
        for (var entityName in trackedEntitiesPresent.keys) {
          if (entityName == DHIS2Config.onCallDoctorsProgramsName) {
            String entityID = trackedEntitiesPresent[entityName]!;
            TrackedAttributes trackedAttributes = TrackedAttributes(
                trackedAttributeId: entityID,
                trackedAttributeName: entityName,
                trackedAttributeShortName: entityName);
            await hiveStorageRepository.saveTrackedAttribute(trackedAttributes);
          }
        }
        // This Section is for the ToDo Section
        for (var entityName in trackedEntitiesPresent.keys) {
          if (entityName == DHIS2Config.toDoEntityName) {
            String entityID = trackedEntitiesPresent[entityName]!;
            TrackedAttributes trackedAttributes = TrackedAttributes(
                trackedAttributeId: entityID,
                trackedAttributeName: entityName,
                trackedAttributeShortName: entityName);
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

  Future prepareAttribute(List<String> attributesShortNamesToPrepare) async {
    Profile profile = await hiveStorageRepository.getUserProfile();
    Map<String, String> neoRooShortNameMapRequired =
        DHIS2Config.neoRooRequiredAttributes;
    String serverURL = await hiveStorageRepository.getOrganisationURL();
    String username = profile.username;
    String password = profile.password;
    // Write code to prepare the server
    for (var attribute in attributesShortNamesToPrepare) {
      String attributeShortName = attribute;
      String attributeName = neoRooShortNameMapRequired[attributeShortName]!;
      bool isunique = false;
      try {
        if (attributeShortName == "infant_ID") {
          isunique = true;
        }
        var response = await serverClient.createTrackedEntityAttribute(username,
            password, serverURL, attributeShortName, attributeName, isunique);

        if (response.statusCode == 201) {
          print(response.statusCode);
          print(response.body);

          var jsonResponse = jsonDecode(response.body);
          Map<dynamic, dynamic> attributeInformation = jsonResponse["response"];
          print(attributeInformation["uid"]);
          TrackedAttributes trackedAttributes = TrackedAttributes(
              trackedAttributeId: attributeInformation["uid"],
              trackedAttributeName: attributeName,
              trackedAttributeShortName: attributeShortName);
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

  getAttributeId() async {
    List<String> attributeID = [];
    List<String> attributeShortNameList = [];

    for (var attributeShortName in DHIS2Config.neoRooRequiredAttributes.keys) {
      attributeShortNameList.add(attributeShortName);
    }
    for (var attributeName in attributeShortNameList) {
      TrackedAttributes trackedAttributes =
          await hiveStorageRepository.getTarckedAttribute(attributeName);
      print(trackedAttributes.trackedAttributeName);
      print(trackedAttributes.trackedAttributeId);
      print("\n");
      attributeID.add(trackedAttributes.trackedAttributeId);
    }
    return attributeID;
  }

  Future prepareEntityTypes() async {
    String trackedEntityName = DHIS2Config.trackedEntityNameList[0];
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
        print(attributeInformation.toString());
        print(attributeInformation["uid"]);
        TrackedAttributes trackedAttributes = TrackedAttributes(
            trackedAttributeId: attributeInformation["uid"],
            trackedAttributeName: trackedEntityName,
            trackedAttributeShortName: trackedEntityName);

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
