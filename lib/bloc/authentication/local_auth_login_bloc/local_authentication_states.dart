import '../../../exceptions/custom_exception.dart';

class LocalAuthStates {}

class LocalAuthInitial extends LocalAuthStates {}

class LocalAuthLoading extends LocalAuthStates {}

class LocalAuthLoaded extends LocalAuthStates {
  final List<String> orgUnits;
  LocalAuthLoaded({required this.orgUnits});
}

class LocalAuthGeneralError extends LocalAuthStates {
  final CustomException exception;
  LocalAuthGeneralError(this.exception);
}
