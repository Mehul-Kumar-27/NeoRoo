import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoroo_app/bloc/more_options/more_options_events.dart';
import 'package:neoroo_app/bloc/more_options/more_options_states.dart';
import 'package:neoroo_app/models/profile.dart';
import 'package:neoroo_app/repository/hive_storage_repository.dart';
import 'dart:convert';

class MoreOptionsBloc extends Bloc<MoreOptionsEvents, MoreOptionsStates> {
  final HiveStorageRepository hiveStorageRepository;
  MoreOptionsBloc(this.hiveStorageRepository)
      : super(InitialMoreOptionsState()) {
    on<LoadMoreOptionsEvent>(loadMoreOptions);
    on<LogoutEvent>(logOutUser);
  }
  Future<void> loadMoreOptions(LoadMoreOptionsEvent loadMoreOptionsEvent,
      Emitter<MoreOptionsStates> emitter) async {
    bool isCaregiver = await hiveStorageRepository.getIsCareGiver();
    Profile profile = await hiveStorageRepository.getUserProfile();
    String? orgName = await hiveStorageRepository.getSelectedOrgName();
    String orgId = await hiveStorageRepository.getSelectedOrganisation();
    String organisationURL = await hiveStorageRepository.getOrganisationURL();
    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode('${profile.username}:${profile.password}'));
    if (isCaregiver) {
      emitter(
        CaregiverUser(
          name: profile.name,
          avatarId: profile.avatarId,
          userId: profile.userId,
          orgId: orgId,
          orgName: orgName,
          baseURL: organisationURL,
          authHeaderValue: basicAuth,
        ),
      );
    } else {
      emitter(
        FamilyMemberUser(
          name: profile.name,
          avatarId: profile.avatarId,
          userId: profile.userId,
          orgId: orgId,
          orgName: orgName,
          authHeaderValue: basicAuth,
          baseURL: organisationURL,
        ),
      );
    }
  }

  Future<void> logOutUser(
      LogoutEvent logoutEvent, Emitter<MoreOptionsStates> emitter) async {
    await hiveStorageRepository.logOutUser();
    emitter(UserLoggedOut());
  }
}
/*
final String avatarId;
  final String name;
  final String userId;
  final String orgName;
  final String orgId;
 */
