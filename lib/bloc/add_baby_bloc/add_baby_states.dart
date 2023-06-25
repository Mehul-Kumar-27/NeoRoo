import 'package:neoroo_app/exceptions/custom_exception.dart';
import 'package:neoroo_app/models/infant_mother.dart';

class AddBabyStates {}

class InitialAddBabyState extends AddBabyStates {}

class LoadingAddBaby extends AddBabyStates {}

class AddBabySuccess extends AddBabyStates {}

class AddBabyError extends AddBabyStates {
  final CustomException exception;
  AddBabyError({required this.exception});
}

class SearchMotherState extends AddBabyStates {
  final List<Mother> motherList;

  SearchMotherState(this.motherList);
}

class SearchMotherInitialState extends AddBabyStates{}

class AddBabyEmptyField extends AddBabyStates {}


