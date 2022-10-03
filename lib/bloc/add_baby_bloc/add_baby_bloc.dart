import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:neoroo_app/bloc/add_baby_bloc/add_baby_events.dart';
import 'package:neoroo_app/bloc/add_baby_bloc/add_baby_states.dart';
import 'package:neoroo_app/exceptions/custom_exception.dart';
import 'package:neoroo_app/models/profile.dart';
import 'package:neoroo_app/repository/add_update_baby_repository.dart';
import 'package:neoroo_app/repository/hive_storage_repository.dart';

class AddBabyBloc extends Bloc<AddBabyEvents, AddBabyStates> {
  final HiveStorageRepository hiveStorageRepository;
  final AddUpdateBabyRepository addUpdateBabyRepository;
  AddBabyBloc(this.hiveStorageRepository, this.addUpdateBabyRepository)
      : super(InitialAddBabyState()) {
    on<AddBabyEvent>(addBaby);
  }
  Future<void> addBaby(
      AddBabyEvent addBabyEvent, Emitter<AddBabyStates> emitter) async {
    //check fields
    if (addBabyEvent.birthDate.isEmpty ||
        addBabyEvent.birthTime.isEmpty ||
        addBabyEvent.motherName.trim().isEmpty ||
        addBabyEvent.birthWeight.isEmpty ||
        addBabyEvent.bodyLength.isEmpty ||
        addBabyEvent.headCircumference.isEmpty ||
        addBabyEvent.familyMemberGroup.isEmpty ||
        addBabyEvent.caregiverGroup.isEmpty ||
        addBabyEvent.birthDescription.isEmpty) {
      emitter(
        AddBabyEmptyField(),
      );
    }
    emitter(
      LoadingAddBaby(),
    );
    Profile userProfile = await hiveStorageRepository.getUserProfile();
    String baseURL = await hiveStorageRepository.getOrganisationURL();
    String organizationUnit =
        await hiveStorageRepository.getSelectedOrganisation();
    Either<bool, CustomException> addBabyRequest =
        await addUpdateBabyRepository.addBaby(
      addBabyEvent.birthTime,
      addBabyEvent.birthDate,
      double.parse(addBabyEvent.headCircumference),
      double.parse(addBabyEvent.birthWeight),
      addBabyEvent.birthDescription,
      addBabyEvent.motherName,
      double.parse(addBabyEvent.bodyLength),
      addBabyEvent.familyMemberGroup,
      addBabyEvent.caregiverGroup,
      addBabyEvent.needResuscitation,
      addBabyEvent.image,
      userProfile.username,
      userProfile.password,
      baseURL,
      organizationUnit,
    );
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
