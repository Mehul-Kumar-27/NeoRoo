import 'package:hive_flutter/hive_flutter.dart';
import '../models/profile.dart';

class HiveStorageRepository {
  static Future<bool> checkUserLoggedIn() async{
    Box box = await Hive.openBox("users");
    print(box.containsKey("user"));
    return box.containsKey("user")&&box.containsKey("selectedOrg");
  }

  Future<void> saveUserProfile(Profile profile) async {
    try {
      Box box = await Hive.openBox("users");
      await box.put("user", profile);
    } catch (e) {
      print(e);
    }
  }

  Future<Profile> getUserProfile() async {
    Box box = await Hive.openBox("users");
    Profile profile = await box.get("user");
    return profile;
  }

  Future<void> saveOrganisationURL(String url) async {
    Box box = await Hive.openBox("users");
    await box.put("url", url);
  }

  Future<String> getOrganisationURL() async {
    Box box = await Hive.openBox("users");
    return box.get("url");
  }

  Future<void> saveCredentials(
      String username, String password, String serverURL) async {
    Box box = await Hive.openBox("saved");
    await box.put(username, [password, serverURL]);
  }

  Future<Map<String, List<String>>> getSavedCredentials() async {
    Box box = await Hive.openBox("saved");
    print(box.keys);
    dynamic keys=box.keys.toList();
    Map<String,List<String>> data={};
    for(int i=0;i<keys.length;i++){
      data[keys[i]]=(await box.get(keys[i]));
    }
    return data;
  }

  Future<void> saveOrganisations(List<String> organisationList) async {
    Box box = await Hive.openBox("users");
    await box.put("orgs", organisationList);
  }

  Future<List<String>> getSavedOrganisations() async {
    Box box = await Hive.openBox("users");
    return (await box.get("orgs"));
  }
  Future<void> saveSelectedOrganisation(String id)async{
    Box box = await Hive.openBox("users");
    await box.put("selectedOrg",id);
  }
  Future<String> getSelectedOrganisation()async{
    Box box = await Hive.openBox("users");
    return (await box.get("selectedOrg"));
  }
}
