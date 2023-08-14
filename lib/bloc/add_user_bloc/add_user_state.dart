import 'package:neoroo_app/exceptions/custom_exception.dart';

class AddUserState {}

class AddUserInitial extends AddUserState {}

class AddUserEventInitial extends AddUserState{}

class AddUserSuccessful extends AddUserState {}

class AddUserFailed extends AddUserState {
  final CustomException customException;

  AddUserFailed(this.customException);
}
