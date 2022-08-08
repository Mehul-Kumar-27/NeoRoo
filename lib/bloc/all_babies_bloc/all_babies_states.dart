import 'package:neoroo_app/exceptions/custom_exception.dart';
import 'package:neoroo_app/models/baby_details_caregiver.dart';

class BabyDetailCaregiverStates {}

class BabyDetailsCaregiverLoading extends BabyDetailCaregiverStates {}

class BabyDetailsCaregiverLoaded extends BabyDetailCaregiverStates {
  final List<BabyDetailsCaregiver>? babyDetailsCaregiver;
  final String auth;
  final String baseURL;
  BabyDetailsCaregiverLoaded(
      {required this.babyDetailsCaregiver,
      required this.auth,
      required this.baseURL});
}

class BabyDetailsCaregiverInitial extends BabyDetailCaregiverStates {}

class BabyDetailsCaregiverFetchError extends BabyDetailCaregiverStates {
  final CustomException exception;
  BabyDetailsCaregiverFetchError({required this.exception});
}
