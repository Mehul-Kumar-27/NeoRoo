// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

import 'package:neoroo_app/bloc/update_baby_bloc/update_baby_events.dart';
import 'package:neoroo_app/bloc/update_baby_bloc/update_baby_states.dart';
import 'package:neoroo_app/exceptions/custom_exception.dart';
import 'package:neoroo_app/models/infant_model.dart';
import 'package:neoroo_app/repository/add_update_baby_repository.dart';
import 'package:neoroo_app/repository/hive_storage_repository.dart';

class UpdateBabyBloc extends Bloc<UpdateBabyEvents, UpdateBabyStates> {
  final HiveStorageRepository hiveStorageRepository;
  final AddUpdateBabyRepository addUpdateBabyRepository;
  UpdateBabyBloc(
    this.hiveStorageRepository,
    this.addUpdateBabyRepository,
  ) : super(UpdateBabyInitial()) {
    on<UpdateBabyEvent>(updateBaby);
  }
  Future<void> updateBaby(UpdateBabyEvent updateBabyEvent,
      Emitter<UpdateBabyStates> emitter) async {
    if (updateBabyEvent.birthDate.isEmpty ||
        updateBabyEvent.birthNotes.isEmpty ||
        updateBabyEvent.birthTime.isEmpty ||
        updateBabyEvent.birthWeight.isEmpty ||
        updateBabyEvent.bodyLength.isEmpty ||
        updateBabyEvent.cribNumber.isEmpty ||
        updateBabyEvent.headCircumference.isEmpty ||
        updateBabyEvent.needResuscitation.isEmpty ||
        updateBabyEvent.wardNumber.isEmpty ||
        updateBabyEvent.presentWeight.isEmpty ||
        updateBabyEvent.motherName.isEmpty ||
        updateBabyEvent.motherId.isEmpty ||
        updateBabyEvent.infantId.isEmpty) {
      emitter(UpdateBabyEmptyField());
      return;
    }
    emitter(UpdateBabyInProgress());

    Infant infant = Infant(
        infantId: updateBabyEvent.infantId,
        moterName: updateBabyEvent.motherName,
        motherUsername: updateBabyEvent.motherId,
        dateOfBirth: updateBabyEvent.birthDate,
        timeOfBirth: updateBabyEvent.birthTime,
        birthWeight: updateBabyEvent.birthWeight,
        bodyLength: updateBabyEvent.bodyLength,
        headCircumference: updateBabyEvent.headCircumference,
        birthNotes: updateBabyEvent.birthNotes,
        resuscitation: updateBabyEvent.needResuscitation,
        neoTemperature: updateBabyEvent.infantTemperature,
        neoHeartRate: updateBabyEvent.infantHeartRate,
        neoRespiratoryRate: updateBabyEvent.infantRespirationRate,
        neoOxygenSaturation: updateBabyEvent.infantBloodOxygen,
        neoSTS: updateBabyEvent.stsTime,
        neoNSTS: updateBabyEvent.nstsTime,
        infantTrackedInstanceID: updateBabyEvent.infantTrackedInstanceID,
        cribNumber: updateBabyEvent.cribNumber,
        wardNumber: updateBabyEvent.wardNumber,
        presentWeight: updateBabyEvent.presentWeight,
        neoDeviceID: updateBabyEvent.neoDeviceID,
        goals: updateBabyEvent.goals,
        avatarID: updateBabyEvent.avatarID);
    Either<bool, CustomException> updateBabyRespponse =
        await addUpdateBabyRepository.updateBaby(infant);
    updateBabyRespponse.fold((l) => emitter(UpdateBabySuccess()),
        (r) => emitter(UpdateBabyError(exception: r)));
  }
}
