import 'package:neoroo_app/repository/hive_storage_repository.dart';

class MoreOptionsRepository {
  final HiveStorageRepository hiveStorageRepository;
  MoreOptionsRepository({required this.hiveStorageRepository});
  Future<bool> getUserType() async {
    bool isCareGiver = await hiveStorageRepository.getIsCareGiver();
    return isCareGiver;
  }

  Future<void> logoutUser() async {
    await hiveStorageRepository.logOutUser();
    return;
  }
}
