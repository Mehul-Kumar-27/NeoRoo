// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:neoroo_app/exceptions/custom_exception.dart';
import 'package:neoroo_app/models/qr_model.dart';

class AddUserState {}

class AddUserInitial extends AddUserState {}

class AddUserEventInitial extends AddUserState {}

class AddUserSuccessful extends AddUserState {
  final String uidOfUserCreated;

  AddUserSuccessful(this.uidOfUserCreated);
}

class AddUserFailed extends AddUserState {
  final CustomException customException;

  AddUserFailed(this.customException);
}

class InfantObtainedState extends AddUserState {
  final QrModel qrModel;
  InfantObtainedState({
    required this.qrModel,
  });
}

class UpdateBabyForFamilyMemberProgress extends AddUserState {}

class UpdateBabyForFamilyMemberSucess extends AddUserState {}

class UpdateBabyForFamilyMemberError extends AddUserState {
  final CustomException exception;
  UpdateBabyForFamilyMemberError({
    required this.exception,
  });
}
