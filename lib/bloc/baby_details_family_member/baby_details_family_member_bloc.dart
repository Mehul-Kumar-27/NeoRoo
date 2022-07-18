import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoroo_app/bloc/baby_details_family_member/baby_details_family_member_events.dart';
import 'package:neoroo_app/bloc/baby_details_family_member/baby_details_family_member_states.dart';
import 'package:neoroo_app/exceptions/custom_exception.dart';
import 'package:neoroo_app/models/baby_details_family_member.dart';
import 'package:neoroo_app/models/profile.dart';
import 'package:neoroo_app/repository/baby_details_repository.dart';
import 'package:neoroo_app/repository/hive_storage_repository.dart';
import 'package:neoroo_app/utils/dhis2_config.dart' as DHIS2Config;
import 'dart:convert';

class BabyDetailsFamilyMemberBloc
    extends Bloc<BabyDetailsFamilyMemberEvents, BabyDetailFamilyMemberStates> {
  final HiveStorageRepository hiveStorageRepository;
  final BabyDetailsRepository babyDetailsRepository;
  BabyDetailsFamilyMemberBloc(
      this.babyDetailsRepository, this.hiveStorageRepository)
      : super(BabyDetailsFamilyMemberInitial()) {
    on<LoadBabyDetailsFamilyMemberEvents>(fetchDetails);
  }
  Future<void> fetchDetails(
      LoadBabyDetailsFamilyMemberEvents loadBabyDetailsFamilyMember,
      Emitter<BabyDetailFamilyMemberStates> emitter) async {
    //emitt loading
    emitter(BabyDetailsFamilyMemberLoading());
    await Future.delayed(Duration(
      seconds: 3,
    ));
    Profile userProfile = await hiveStorageRepository.getUserProfile();
    String basicAuth = 'Basic ' +
        base64Encode(
            utf8.encode('${userProfile.username}:${userProfile.password}'));
    String baseURL = await hiveStorageRepository.getOrganisationURL();
    String organizationUnit =
        await hiveStorageRepository.getSelectedOrganisation();
    List<String> userGroups = await hiveStorageRepository.getUserGroups();
    if (userGroups.isEmpty) {
      emitter(
        BabyDetailsFamilyMemberLoaded(
          babyDetailsFamilyMember: null,
          auth: basicAuth,
          baseURL: baseURL,
        ),
      );
      return;
    }
    Either<BabyDetailsFamilyMember?, CustomException> fetchBabyData =
        await babyDetailsRepository.fetchDetailsFamilyMember(
      userProfile.username,
      userProfile.password,
      organizationUnit,
      DHIS2Config.trackerProgramId,
      userGroups[0],
      baseURL,
      DHIS2Config.familyMemberUserGroup,
    );
    fetchBabyData.fold(
      (l) {
        emitter(
          BabyDetailsFamilyMemberLoaded(
            babyDetailsFamilyMember: l,
            auth: basicAuth,
            baseURL: baseURL,
          ),
        );
        print("L" + l.toString());
      },
      (r) {
        print("R" + r.toString());
        emitter(
          BabyDetailsFamilyMemberFetchError(
            exception: r,
          ),
        );
      },
    );
  }
}
