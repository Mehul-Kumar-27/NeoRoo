import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoroo_app/bloc/baby_details/baby_details_events.dart';
import 'package:neoroo_app/bloc/baby_details/baby_details_states.dart';
import 'package:neoroo_app/exceptions/custom_exception.dart';
import 'package:neoroo_app/models/baby_details_family_member.dart';
import 'package:neoroo_app/models/profile.dart';
import 'package:neoroo_app/repository/baby_details_repository.dart';
import 'package:neoroo_app/repository/hive_storage_repository.dart';
import 'package:neoroo_app/utils/dhis2_config.dart' as DHIS2Config;

class BabyDetailsBloc extends Bloc<BabyDetailsEvents, BabyDetailStates> {
  final HiveStorageRepository hiveStorageRepository;
  final BabyDetailsRepository babyDetailsRepository;
  BabyDetailsBloc(this.babyDetailsRepository, this.hiveStorageRepository)
      : super(BabyDetailsInitial()) {
    on<LoadBabyDetails>(fetchDetails);
  }
  Future<void> fetchDetails(LoadBabyDetails loadBabyDetails,
      Emitter<BabyDetailStates> emitter) async {
    //emitt loading
    emitter(BabyDetailsLoading());
    await Future.delayed(Duration(seconds: 3,));
    Profile userProfile = await hiveStorageRepository.getUserProfile();
    String baseURL = await hiveStorageRepository.getOrganisationURL();
    String organizationUnit =
        await hiveStorageRepository.getSelectedOrganisation();
    List<String> userGroups = await hiveStorageRepository.getUserGroups();
    if (userGroups.isEmpty) {
      emitter(
        BabyDetailsFamilyMemberLoaded(babyDetailsFamilyMember: null),
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
          BabyDetailsFamilyMemberLoaded(babyDetailsFamilyMember: l),
        );
        print("L" + l.toString());
      },
      (r) {
        print("R" + r.toString());
        emitter(
          BabyDetailsFetchError(
            exception: r,
          ),
        );
      },
    );
  }
}
