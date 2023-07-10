// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:neoroo_app/exceptions/custom_exception.dart';
import 'package:neoroo_app/models/infant_model.dart';
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

class SearchMotherInitialState extends AddBabyStates {}

class AddBabyEmptyField extends AddBabyStates {}

class FetchInfantFromECEBInitialState extends AddBabyStates {}

class FetchBabyFromECEBSucess extends AddBabyStates {
  final List<Infant> ecebInfantsOnServer;
  FetchBabyFromECEBSucess({
    required this.ecebInfantsOnServer,
  });
}

class EcebInfantSelectedState extends AddBabyStates {
  final Infant infant;
  EcebInfantSelectedState({
    required this.infant,
  });
}
