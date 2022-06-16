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
  Profile(
    this.avatarId,
    this.name,
    this.password,
    this.username,
    this.userId
  );
}
