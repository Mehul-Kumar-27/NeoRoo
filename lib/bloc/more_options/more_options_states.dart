import 'package:equatable/equatable.dart';

abstract class MoreOptionsStates extends Equatable{

}

class InitialMoreOptionsState extends MoreOptionsStates{
  @override
  List<Object?> get props => [];
}

class CaregiverUser extends MoreOptionsStates{
  @override
  List<Object?> get props => [];  
}

class FamilyMemberUser extends MoreOptionsStates{
  @override
  List<Object?> get props => [];
}

class UserLoggedOut extends MoreOptionsStates{
  @override
  List<Object?> get props => [];
}
