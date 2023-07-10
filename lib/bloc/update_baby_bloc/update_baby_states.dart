// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:neoroo_app/exceptions/custom_exception.dart';

class UpdateBabyStates{}

class UpdateBabyInitial extends UpdateBabyStates{}

class UpdateBabyInProgress extends UpdateBabyStates{}

class UpdateBabySuccess extends UpdateBabyStates{
   
}

class UpdateBabyError extends UpdateBabyStates {
   final CustomException exception;
  UpdateBabyError({
    required this.exception,
  });
}

class UpdateBabyEmptyField extends UpdateBabyStates{}