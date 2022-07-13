import 'package:neoroo_app/exceptions/custom_exception.dart';
import 'package:neoroo_app/models/baby_details_family_member.dart';

class BabyDetailStates{}

class BabyDetailsLoading extends BabyDetailStates{}

class BabyDetailsCaregiverLoaded extends BabyDetailStates{}

class BabyDetailsFamilyMemberLoaded extends BabyDetailStates{
  final BabyDetailsFamilyMember? babyDetailsFamilyMember;
  BabyDetailsFamilyMemberLoaded({required this.babyDetailsFamilyMember});
}

class BabyDetailsInitial extends BabyDetailStates{}

class BabyDetailsFetchError extends BabyDetailStates{
  final CustomException exception;
  BabyDetailsFetchError({required this.exception});
}