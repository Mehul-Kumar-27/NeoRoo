import 'package:neoroo_app/exceptions/custom_exception.dart';
import 'package:neoroo_app/models/baby_details_family_member.dart';

class BabyDetailFamilyMemberStates{}

class BabyDetailsFamilyMemberLoading extends BabyDetailFamilyMemberStates{}

class BabyDetailsFamilyMemberLoaded extends BabyDetailFamilyMemberStates{
  final BabyDetailsFamilyMember? babyDetailsFamilyMember;
  final String auth;
  final String baseURL;
  BabyDetailsFamilyMemberLoaded({required this.babyDetailsFamilyMember,required this.auth,required this.baseURL});
}

class BabyDetailsFamilyMemberInitial extends BabyDetailFamilyMemberStates{}

class BabyDetailsFamilyMemberFetchError extends BabyDetailFamilyMemberStates{
  final CustomException exception;
  BabyDetailsFamilyMemberFetchError({required this.exception});
}