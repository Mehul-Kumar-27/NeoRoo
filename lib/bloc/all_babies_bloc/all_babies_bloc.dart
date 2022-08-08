import 'package:bloc/bloc.dart';
import 'package:neoroo_app/bloc/all_babies_bloc/all_babies_events.dart';
import 'package:neoroo_app/bloc/all_babies_bloc/all_babies_states.dart';
import 'package:neoroo_app/exceptions/custom_exception.dart';
import 'package:neoroo_app/models/baby_details_caregiver.dart';
import 'package:neoroo_app/models/profile.dart';
import 'package:neoroo_app/repository/baby_details_repository.dart';
import 'package:neoroo_app/repository/hive_storage_repository.dart';
import 'dart:convert';
import 'package:dartz/dartz.dart';
import '../../utils/dhis2_config.dart' as DHIS2Config;

class BabyDetailsCaregiverBloc
    extends Bloc<BabyDetailsCaregiverEvents, BabyDetailCaregiverStates> {
  final HiveStorageRepository hiveStorageRepository;
  final BabyDetailsRepository babyDetailsRepository;
  BabyDetailsCaregiverBloc(
      this.babyDetailsRepository, this.hiveStorageRepository)
      : super(BabyDetailsCaregiverInitial()) {
    on<LoadAllBabiesCaregiver>(fetchAllBabies);
  }
  Future<void> fetchAllBabies(LoadAllBabiesCaregiver loadAllBabies,
      Emitter<BabyDetailCaregiverStates> emitter) async {
    emitter(BabyDetailsCaregiverLoading());
    Profile userProfile = await hiveStorageRepository.getUserProfile();
    String basicAuth = 'Basic ' +
        base64Encode(
            utf8.encode('${userProfile.username}:${userProfile.password}'));
    String baseURL = await hiveStorageRepository.getOrganisationURL();
    String organizationUnit =
        await hiveStorageRepository.getSelectedOrganisation();
    List<String> userGroups = await hiveStorageRepository.getUserGroups();
    print(userGroups);
    if (userGroups.isEmpty) {
      emitter(
        BabyDetailsCaregiverLoaded(
          babyDetailsCaregiver: null,
          auth: basicAuth,
          baseURL: baseURL,
        ),
      );
      return;
    }
    Either<List<BabyDetailsCaregiver>?, CustomException> fetchBabyData =
        await babyDetailsRepository.fetchDetailsCaregiver(
      userProfile.username,
      userProfile.password,
      organizationUnit,
      DHIS2Config.trackerProgramId,
      userGroups.join(';'),
      baseURL,
      DHIS2Config.caregiverUserGroup,
    );
    fetchBabyData.fold(
      (l) {
        emitter(
          BabyDetailsCaregiverLoaded(
            babyDetailsCaregiver: l,
            auth: basicAuth,
            baseURL: baseURL,
          ),
        );
        print("L" + l.toString());
      },
      (r) {
        print("R" + r.toString());
        emitter(
          BabyDetailsCaregiverFetchError(
            exception: r,
          ),
        );
      },
    );
  }
}
