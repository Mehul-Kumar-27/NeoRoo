// ignore_for_file: public_member_api_docs, sort_constructors_first
class AddUserEvent {}

class AddUserOnServer extends AddUserEvent{
  String firstName;
  String lastName;
  String username;
  String email;
  String password;
  AddUserOnServer({
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.password,
  });
}
