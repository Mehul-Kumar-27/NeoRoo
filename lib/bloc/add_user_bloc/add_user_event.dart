// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:neoroo_app/models/infant_model.dart';

class AddUserEvent {}

class AddUserOnServer extends AddUserEvent {
  String firstName;
  String lastName;
  String username;
  String email;
  String password;
  String adminUsername;
  String adminPassword;
  String serverURL;
  String organizationUnit;
  AddUserOnServer({
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.password,
    required this.adminUsername,
    required this.adminPassword,
    required this.serverURL,
    required this.organizationUnit,
  });
}

class InfantObtained extends AddUserEvent {
  String qrModelString;
  InfantObtained({
    required this.qrModelString,
  });
}

class UpdateBabyWithFamilyMember extends AddUserEvent {
  final Infant infant;

  UpdateBabyWithFamilyMember(
    this.infant,
  );
}
