import 'dart:convert';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:neoroo_app/exceptions/custom_exception.dart';
import 'package:neoroo_app/models/profile.dart';
import 'package:neoroo_app/models/tracked_attributes.dart';
import 'package:neoroo_app/network/on_call_doctors_client.dart';
import 'package:neoroo_app/repository/hive_storage_repository.dart';
import 'package:neoroo_app/utils/dhis2_config.dart' as DHIS2Config;

class OnCallDoctorsRepository {
  final HiveStorageRepository hiveStorageRepository;
  final OnCallDoctorsClient onCallDoctorsClient;
  final BuildContext context;

  OnCallDoctorsRepository(
      this.hiveStorageRepository, this.onCallDoctorsClient, this.context);
  getOnCallDoctors() async {
    Profile profile = await hiveStorageRepository.getUserProfile();
    String organizationUnit =
        await hiveStorageRepository.getSelectedOrganisation();
    String serverURL = await hiveStorageRepository.getOrganisationURL();
    String username = profile.username;
    String password = profile.password;
    TrackedAttributes onCallDoctorEntity = await hiveStorageRepository
        .getTarckedAttribute(DHIS2Config.onCallDoctorsProgramsName);
    try {
      var response = await onCallDoctorsClient.getOnCallDoctors(
          username,
          password,
          organizationUnit,
          serverURL,
          onCallDoctorEntity.trackedAttributeId);

      if (response.statusCode == 200) {
        DateTime currentDate = DateTime.now();
        String weekDayName = _getWeekdayName(currentDate);
        Map<String, dynamic> scheduleOfDoctors = jsonDecode(response.body);
        if (scheduleOfDoctors[weekDayName] != null) {
          List<dynamic> todaySchedule = scheduleOfDoctors[weekDayName];
          return todaySchedule;
        } else {
          List<dynamic> todaySchedule = [];
          return todaySchedule;
        }
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
    } catch (e) {
      print(e);
      return FetchDataException(
        AppLocalizations.of(context).errorDuringCommunication,
        null,
      );
    }
  }
}

String _getWeekdayName(DateTime date) {
  switch (date.weekday) {
    case 1:
      return 'Monday';
    case 2:
      return 'Tuesday';
    case 3:
      return 'Wednesday';
    case 4:
      return 'Thurusday';
    case 5:
      return 'Friday';
    case 6:
      return 'Saturday';
    case 7:
      return 'Sunday';
    default:
      return '';
  }
}
