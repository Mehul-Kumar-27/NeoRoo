import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:neoroo_app/bloc/add_baby_bloc/add_baby_events.dart';
import 'package:neoroo_app/bloc/add_baby_bloc/add_baby_states.dart';
import 'package:neoroo_app/exceptions/custom_exception.dart';
import 'package:neoroo_app/models/infant_model.dart';
import 'package:neoroo_app/models/infant_mother.dart';
import 'package:neoroo_app/models/profile.dart';
import 'package:neoroo_app/repository/add_update_baby_repository.dart';
import 'package:neoroo_app/repository/eceb_to_neoroo_repository.dart';
import 'package:neoroo_app/repository/hive_storage_repository.dart';

class AddBabyBloc extends Bloc<AddBabyEvents, AddBabyStates> {
  final HiveStorageRepository hiveStorageRepository;
  final AddUpdateBabyRepository addUpdateBabyRepository;
  final ECEBtoNeoRooRepository eceBtoNeoRooRepository;
  AddBabyBloc(this.hiveStorageRepository, this.addUpdateBabyRepository,
      this.eceBtoNeoRooRepository)
      : super(InitialAddBabyState()) {
    on<AddBabyEvent>(addBaby);
    on<GetMotherEvent>(getMother);
    on<SearchInMotherList>(searchMotherInList);
    on<GetInfantsFromEceb>(getInfantsFromEceb);
    on<EcebInfantSelected>(ecebInfantSelected);
    on<SearchInfantFromECEBList>(searchInfantFromECEB);
  }

  Future<void> getMother(
      GetMotherEvent event, Emitter<AddBabyStates> emitter) async {
    emitter(SearchMotherInitialState());
    Either<List<Mother>, CustomException> response =
        await addUpdateBabyRepository.getMother();

    response.fold(
      (l) => emitter(SearchMotherState(l)),
      (r) => emitter(AddBabyError(exception: r)),
    );
  }

  Future<void> searchMotherInList(
      SearchInMotherList event, Emitter<AddBabyStates> emitter) async {
    List<Mother> searchResultList = [];

    for (var mother in event.motherList) {
      if (mother.motherID
              .toLowerCase()
              .contains(event.motherName.toLowerCase()) ||
          mother.displayName
              .toLowerCase()
              .contains(event.motherName.toLowerCase())) {
        searchResultList.add(mother);
      }
      emitter(SearchMotherState(searchResultList));
    }
  }

  Future<void> searchInfantFromECEB(
      SearchInfantFromECEBList event, Emitter<AddBabyStates> emitter) async {
    List<Infant> searchResultList = [];
    for (var infant in event.ecebInfantSearchList) {
      if (infant.moterName
              .toLowerCase()
              .contains(event.infantData.toLowerCase()) ||
          infant.dateOfBirth
              .toLowerCase()
              .contains(event.infantData.toLowerCase())) {
        searchResultList.add(infant);
      }
    }
    emitter(FetchBabyFromECEBSucess(ecebInfantsOnServer: searchResultList));
  }

  Future<void> addBaby(
      AddBabyEvent addBabyEvent, Emitter<AddBabyStates> emitter) async {
    //check fields
    if (addBabyEvent.birthDate.isEmpty ||
        addBabyEvent.birthNotes.isEmpty ||
        addBabyEvent.birthTime.isEmpty ||
        addBabyEvent.birthWeight.isEmpty ||
        addBabyEvent.bodyLength.isEmpty ||
        addBabyEvent.cribNumber.isEmpty ||
        addBabyEvent.headCircumference.isEmpty ||
        addBabyEvent.needResuscitation.isEmpty ||
        addBabyEvent.wardNumber.isEmpty ||
        addBabyEvent.presentWeight.isEmpty ||
        addBabyEvent.motherName.isEmpty ||
        addBabyEvent.motherId.isEmpty ||
        addBabyEvent.infantId.isEmpty) {
      emitter(
        AddBabyEmptyField(),
      );
    } else {
      emitter(
        LoadingAddBaby(),
      );
      Profile userProfile = await hiveStorageRepository.getUserProfile();
      String baseURL = await hiveStorageRepository.getOrganisationURL();
      String organizationUnitID =
          await hiveStorageRepository.getSelectedOrganisation();

      Either<bool, CustomException> addBabyRequest =
          await addUpdateBabyRepository.addBaby(
              addBabyEvent.birthDate,
              addBabyEvent.birthNotes,
              addBabyEvent.birthTime,
              addBabyEvent.birthWeight,
              addBabyEvent.bodyLength,
              addBabyEvent.cribNumber,
              addBabyEvent.headCircumference,
              addBabyEvent.needResuscitation,
              addBabyEvent.wardNumber,
              addBabyEvent.presentWeight,
              addBabyEvent.motherName,
              addBabyEvent.motherId,
              addBabyEvent.stsTime,
              addBabyEvent.nstsTime,
              addBabyEvent.infantTemperature,
              addBabyEvent.infantHeartRate,
              addBabyEvent.infantRespirationRate,
              addBabyEvent.infantBloodOxygen,
              addBabyEvent.infantId,
              addBabyEvent.image,
              userProfile.username,
              userProfile.password,
              baseURL,
              organizationUnitID);
      addBabyRequest.fold(
        (l) => emitter(
          AddBabySuccess(),
        ),
        (r) => emitter(
          AddBabyError(
            exception: r,
          ),
        ),
      );
    }
  }

  Future<void> getInfantsFromEceb(GetInfantsFromEceb getInfantsFromEceb,
      Emitter<AddBabyStates> emitter) async {
    emitter(FetchInfantFromECEBInitialState());
    Either<List<Infant>, CustomException> fetchBabyFromECEB =
        await eceBtoNeoRooRepository.fetchBabyFromECEB();
    fetchBabyFromECEB.fold(
      (l) => emitter(FetchBabyFromECEBSucess(ecebInfantsOnServer: l)),
      (r) => emitter(
        AddBabyError(
          exception: r,
        ),
      ),
    );
  }

  Future<void> ecebInfantSelected(EcebInfantSelected ecebInfantSelected,
      Emitter<AddBabyStates> emitter) async {
    emitter(EcebInfantSelectedState(infant: ecebInfantSelected.infant));
  }
}
