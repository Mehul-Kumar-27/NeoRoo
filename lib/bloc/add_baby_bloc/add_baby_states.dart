import 'package:neoroo_app/exceptions/custom_exception.dart';

class AddBabyStates {}

class InitialAddBabyState extends AddBabyStates {}

class LoadingAddBaby extends AddBabyStates {}

class AddBabySuccess extends AddBabyStates{}

class AddBabyError extends AddBabyStates{
  final CustomException exception;
  AddBabyError({required this.exception});
}

class AddBabyEmptyField extends AddBabyStates{}