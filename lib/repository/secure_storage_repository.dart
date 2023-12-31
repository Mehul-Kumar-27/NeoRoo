import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageRepository{
  late FlutterSecureStorage storage;
  Future<void> initialiseSecureStorage()async{
    storage=FlutterSecureStorage();
  }
  Future<void> write(String key,String value)async{
    await storage.write(key: key, value: value);
  }
  Future<String?> read(String key)async{
    return storage.read(key: key);
  }
}