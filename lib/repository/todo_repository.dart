// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:neoroo_app/exceptions/custom_exception.dart';
import 'package:neoroo_app/models/profile.dart';
import 'package:neoroo_app/models/to_do.dart';
import 'package:neoroo_app/models/tracked_attributes.dart';
import 'package:neoroo_app/utils/dhis2_config.dart' as DHIS2Config;
import 'package:neoroo_app/network/todo_client.dart';
import 'package:neoroo_app/repository/hive_storage_repository.dart';
import 'package:http/http.dart' as http;

class ToDoRepository {
  final HiveStorageRepository hiveStorageRepository;
  final AddUpdateDeleteToDoClient addUpdateDeleteToDoClient;
  final BuildContext context;
  ToDoRepository({
    required this.hiveStorageRepository,
    required this.addUpdateDeleteToDoClient,
    required this.context,
  });

  Future<Either<bool, CustomException>> addToDo(
    String toDoId,
    String toDoTitle,
    String toDoBody,
    String dateTime,
    String toDoTag,
  ) async {
    try {
      Profile profile = await hiveStorageRepository.getUserProfile();
      String organizationUnitID =
          await hiveStorageRepository.getSelectedOrganisation();
      String serverURL = await hiveStorageRepository.getOrganisationURL();
      String username = profile.username;
      String password = profile.password;
      Map<String, String> attributesShortNameAndUID =
          await trackedAttributesAndUID();
      http.Response response = await addUpdateDeleteToDoClient.addToDo(
          username,
          password,
          organizationUnitID,
          serverURL,
          toDoId,
          toDoTitle,
          toDoBody,
          dateTime,
          toDoTag,
          attributesShortNameAndUID);
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        print(responseBody);

        return Left(true);
      }
      if (response.statusCode == 401 || response.statusCode == 403) {
        var responseBody = jsonDecode(response.body);
        print(responseBody);
        return Right(
          UnauthorisedException(
            AppLocalizations.of(context).unauthorized,
            response.statusCode,
          ),
        );
      } else {
        var responseBody = jsonDecode(response.body);
        print(responseBody);
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

      return Right(FetchDataException(
        e.toString(),
        404,
      ));
    }
  }

  Future<Either<bool, CustomException>> updateToDo(ToDo toDo) async {
    try {
      Profile profile = await hiveStorageRepository.getUserProfile();
      String organizationUnitID =
          await hiveStorageRepository.getSelectedOrganisation();
      String serverURL = await hiveStorageRepository.getOrganisationURL();
      String username = profile.username;
      String password = profile.password;
      Map<String, String> attributesShortNameAndUID =
          await trackedAttributesAndUID();
      http.Response response = await addUpdateDeleteToDoClient.updateToDo(
          username,
          password,
          organizationUnitID,
          serverURL,
          toDo,
          attributesShortNameAndUID);
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        print(responseBody);

        return Left(true);
      }
      if (response.statusCode == 401 || response.statusCode == 403) {
        var responseBody = jsonDecode(response.body);
        print(responseBody);
        return Right(
          UnauthorisedException(
            AppLocalizations.of(context).unauthorized,
            response.statusCode,
          ),
        );
      } else {
        var responseBody = jsonDecode(response.body);
        print(responseBody);
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

      return Right(FetchDataException(
        e.toString(),
        404,
      ));
    }
  }

  Future<Either<bool, CustomException>> deleteToDo(ToDo toDo) async {
    try {
      Profile profile = await hiveStorageRepository.getUserProfile();
      String organizationUnitID =
          await hiveStorageRepository.getSelectedOrganisation();
      String serverURL = await hiveStorageRepository.getOrganisationURL();
      String username = profile.username;
      String password = profile.password;
      http.Response response = await addUpdateDeleteToDoClient.deleteToDo(
          username, password, organizationUnitID, serverURL, toDo);
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        print(responseBody);

        return Left(true);
      }
      if (response.statusCode == 401 || response.statusCode == 403) {
        var responseBody = jsonDecode(response.body);
        print(responseBody);
        return Right(
          UnauthorisedException(
            AppLocalizations.of(context).unauthorized,
            response.statusCode,
          ),
        );
      } else {
        var responseBody = jsonDecode(response.body);
        print(responseBody);
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

      return Right(FetchDataException(
        e.toString(),
        404,
      ));
    }
  }

  Future<Map<String, String>> trackedAttributesAndUID() async {
    Map<String, String> trackedAttributesAndUID = {};
    Map<String, String> toDoAttributes = DHIS2Config.toDoAttributeList;

    for (var shortName in toDoAttributes.keys) {
      TrackedAttributes trackedAttribute =
          await hiveStorageRepository.getTarckedAttribute(shortName);
      String trackedAttributeUID = trackedAttribute.trackedAttributeId;
      trackedAttributesAndUID
          .addEntries([MapEntry(shortName, trackedAttributeUID)]);
    }
    TrackedAttributes attributes = await hiveStorageRepository
        .getTarckedAttribute(DHIS2Config.toDoEntityName);
    trackedAttributesAndUID.addEntries([
      MapEntry(attributes.trackedAttributeName, attributes.trackedAttributeId)
    ]);

    return trackedAttributesAndUID;
  }
}
