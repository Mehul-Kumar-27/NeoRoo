// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:neoroo_app/bloc/add_user_bloc/add_user_event.dart';
import 'package:neoroo_app/bloc/add_user_bloc/add_user_state.dart';
import 'package:neoroo_app/exceptions/custom_exception.dart';
import 'package:neoroo_app/models/infant_model.dart';
import 'package:neoroo_app/models/qr_model.dart';
import 'package:neoroo_app/repository/add_update_baby_repository.dart';
import 'package:neoroo_app/repository/add_user_repository.dart';

class AddUserBloc extends Bloc<AddUserEvent, AddUserState> {
  final AddUserRepository addUserRepository;
  final AddUpdateBabyRepository addUpdateBabyRepository;
  AddUserBloc(
    this.addUserRepository,
    this.addUpdateBabyRepository,
  ) : super(AddUserInitial()) {
    on<AddUserOnServer>(createUser);
    on<InfantObtained>(infantObtained);
    on<UpdateBabyWithFamilyMember>(updateInfantForFamilyMember);
  }

  createUser(AddUserOnServer event, Emitter<AddUserState> emitter) async {
    emitter(AddUserEventInitial());
    if (event.firstName.isEmpty ||
        event.lastName.isEmpty ||
        event.password.isEmpty ||
        event.username.isEmpty ||
        event.email.isEmpty) {
      CustomException customException =
          CustomException("Please Fill All the details !", 501);
      emitter(AddUserFailed(customException));
    } else {
      Either<bool, CustomException> response =
          await addUserRepository.createUserOnDhis2Server(
              event.firstName,
              event.lastName,
              event.email,
              event.username,
              event.password,
              event.adminUsername,
              event.adminPassword,
              event.organizationUnit,
              event.serverURL);
      response.fold((l) => emitter(AddUserSuccessful()),
          (r) => emitter(AddUserFailed(r)));
    }
  }

  infantObtained(InfantObtained event, Emitter<AddUserState> emitter) async {
    QrModel qrModel = QrModel.fromJson(jsonDecode(event.qrModelString));
    emitter(InfantObtainedState(qrModel: qrModel));
  }

  updateInfantForFamilyMember(
      UpdateBabyWithFamilyMember event, Emitter<AddUserState> emitter) async {
    emitter(UpdateBabyForFamilyMemberProgress());
    try {
      Either<bool, CustomException> updateBabyRespponse =
          await addUpdateBabyRepository.updateBaby(event.infant);
      updateBabyRespponse.fold(
          (l) => emitter(UpdateBabyForFamilyMemberSucess()),
          (r) => emitter(UpdateBabyForFamilyMemberError(exception: r)));
    } catch (e) {
      CustomException customException = CustomException(e.toString(), 501);
      emitter(UpdateBabyForFamilyMemberError(exception: customException));
    }
  }
}
