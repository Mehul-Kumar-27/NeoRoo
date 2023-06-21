import 'package:neoroo_app/exceptions/custom_exception.dart';
import 'package:neoroo_app/models/infant_model.dart';

class FetchBabyStates {}

class FetchBabyInitialState extends FetchBabyStates {}
class FetchInfantFromServerSuccess extends FetchBabyStates {
  final List<Infant> infantList;

  FetchInfantFromServerSuccess(this.infantList);
}

class FetchInfantFromServerError extends FetchBabyStates {
  final String exception;

  FetchInfantFromServerError(this.exception);
}
