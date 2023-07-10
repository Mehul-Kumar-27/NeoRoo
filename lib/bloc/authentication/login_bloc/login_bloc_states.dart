import 'package:equatable/equatable.dart';
import 'package:neoroo_app/exceptions/custom_exception.dart';

abstract class LoginState extends Equatable {}

class LoginInitial extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginLoading extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginLoaded extends LoginState {
  final List<String> orgUnits;
  LoginLoaded({required this.orgUnits});

  @override
  List<Object?> get props => [];
}

class LoginGeneralError extends LoginState {
  final CustomException exception;
  LoginGeneralError(this.exception);

  @override
  List<Object?> get props => [exception.message, exception.statusCode];
}

class LocalAuthSupportError extends LoginState {
  final String message;
  LocalAuthSupportError(this.message);

  @override
  List<Object?> get props => [message];
}

class LocalAuthSuccess extends LoginState {
  final Map<String, List<String>> credentials;
  LocalAuthSuccess(this.credentials);

  @override
  List<Object?> get props => throw UnimplementedError();
}
