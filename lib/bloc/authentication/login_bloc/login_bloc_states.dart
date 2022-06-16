import 'package:neoroo_app/exceptions/custom_exception.dart';

abstract class LoginState{}

class LoginInitial extends LoginState{}

class LoginLoading extends LoginState{}

class LoginLoaded extends LoginState{
  final List<String> orgUnits;
  LoginLoaded({required this.orgUnits});
}

class LoginGeneralError extends LoginState{
  final CustomException exception;
  LoginGeneralError(this.exception);
}

class LocalAuthSupportError extends LoginState{
  final String message;
  LocalAuthSupportError(this.message);
}
class LocalAuthSuccess extends LoginState{
  final Map<String, List<String>> credentials;
  LocalAuthSuccess(this.credentials);
}