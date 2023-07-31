// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:neoroo_app/models/infant_model.dart';
import 'package:neoroo_app/models/profile.dart';
import 'package:neoroo_app/models/tracked_attributes.dart';
import 'package:neoroo_app/network/fetch_from_eceb.dart';
import 'package:neoroo_app/repository/hive_storage_repository.dart';
import 'package:neoroo_app/utils/dhis2_config.dart' as DHIS2Config;

import '../exceptions/custom_exception.dart';

class ECEBtoNeoRooRepository {
  final HiveStorageRepository hiveStorageRepository;
  final FetchBabyFromECEBClient fetchBabyFromECEBClient;
  final BuildContext context;

  ECEBtoNeoRooRepository(
    this.hiveStorageRepository,
    this.fetchBabyFromECEBClient,
    this.context,
  );

  Future<Either<List<Infant>, CustomException>> fetchBabyFromECEB() async {
    Profile profile = await hiveStorageRepository.getUserProfile();
    String organisatioUnit =
        await hiveStorageRepository.getSelectedOrganisation();
    String serverURL = await hiveStorageRepository.getOrganisationURL();
    String username = profile.username;
    String password = profile.password;
    TrackedAttributes ecebTrackedEntity = await hiveStorageRepository
        .getTarckedAttribute(DHIS2Config.ecebEntityName);

    List<Infant> ecebInfantList = [];
    try {
      http.Response response = await fetchBabyFromECEBClient.getInfantsFromECEB(
          username, password, serverURL, organisatioUnit, ecebTrackedEntity.trackedAttributeId);
      if (response.statusCode == 200) {
        Map<String, dynamic> mapData = jsonDecode(response.body);
        List<dynamic> infantList = mapData['trackedEntityInstances'];
        for (var infant in infantList) {
          List<dynamic> attributeList = infant['attributes'];
          String birthNotes = '';
          String motherName = '';
          String wardNumber = '';
          String birthDateTime = '';
          String id = '';
          for (var element in attributeList) {
            String displayName = element['displayName'];
            if (displayName == "ECEB_birth_description_TEI") {
              birthNotes = element['value'];
            } else if (displayName == "ECEB_TEI_Mother_Name") {
              motherName = element['value'];
            } else if (displayName == "ECEB_TEI_Ward_Name") {
              wardNumber = element['value'];
            } else if (displayName == "ECEB_TEI_BirthDate_Time") {
              birthDateTime = element['value'];
            } else if (displayName == "ECEB_TEI_Identifier") {
              id = element['value'];
            }
          }

          Infant ecebInfant = Infant(
              infantId: id,
              moterName: motherName,
              motherUsername: motherName,
              dateOfBirth: birthDateTime,
              timeOfBirth: birthDateTime,
              birthWeight: '',
              bodyLength: '',
              headCircumference: '',
              birthNotes: birthNotes,
              resuscitation: '',
              neoTemperature: 'Dummy',
              neoHeartRate: 'Dummy',
              neoRespiratoryRate: 'Dummy',
              neoOxygenSaturation: 'Dummy',
              neoSTS: 'Dummy',
              neoNSTS: 'Dummy',
              infantTrackedInstanceID: '',
              cribNumber: '',
              wardNumber: wardNumber,
              presentWeight: '',
              neoDeviceID: 'Dummy',
              goals: "",
              avatarID: '');
          ecebInfantList.add(ecebInfant);
        }

        return Left(ecebInfantList);
      }
      if (response.statusCode == 400) {
        return Right(BadRequestException(
          AppLocalizations.of(context).invalidRequest,
          response.statusCode,
        ));
      }
      if (response.statusCode == 401) {
        return Right(UnauthorisedException(
          AppLocalizations.of(context).unauthorized,
          response.statusCode,
        ));
      }
      if (response.statusCode == 403) {
        return Right(UnauthorisedException(
          AppLocalizations.of(context).invalidInput,
          response.statusCode,
        ));
      } else {
        return Right(FetchDataException(
          AppLocalizations.of(context).errorDuringCommunication,
          response.statusCode,
        ));
      }
    } catch (e) {
      return Right(FetchDataException(
        e.toString(),
        404,
      ));
    }
  }
}
