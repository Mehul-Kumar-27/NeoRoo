import 'package:equatable/equatable.dart';

abstract class MoreOptionsStates extends Equatable{

}

class InitialMoreOptionsState extends MoreOptionsStates{
  @override
  List<Object?> get props => [];
}

class CaregiverUser extends MoreOptionsStates{
  final String? avatarId;
  final String name;
  final String userId;
  final String? orgName;
  final String baseURL;
  final String orgId;
  final String authHeaderValue;
  CaregiverUser({required this.avatarId,required this.name,required this.userId,required this.orgId,required this.orgName,required this.baseURL,required this.authHeaderValue});
  @override
  List<Object?> get props => [];  
}

class FamilyMemberUser extends MoreOptionsStates{
  final String? avatarId;
  final String name;
  final String userId;
  final String orgId;
  final String baseURL;
  final String? orgName;
  final String authHeaderValue;
  FamilyMemberUser({required this.avatarId,required this.name,required this.userId,required this.orgName,required this.orgId,required this.baseURL,required this.authHeaderValue});
  @override
  List<Object?> get props => [];
}

class UserLoggedOut extends MoreOptionsStates{
  @override
  List<Object?> get props => [];
}