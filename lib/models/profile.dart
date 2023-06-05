// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

part 'profile.g.dart';

@HiveType(typeId: 0)
class Profile {
  @HiveField(0)
  String name;
  @HiveField(1)
  String username;
  @HiveField(2)
  String password;
  @HiveField(3)
  String? avatarId;
  @HiveField(4)
  String userId;
  @HiveField(5)
  String userRole;
  Profile(
    this.name,
    this.username,
    this.password,
    this.avatarId,
    this.userId,
    this.userRole,
  );
}
