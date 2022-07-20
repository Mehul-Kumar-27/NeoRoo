import 'package:hive_flutter/hive_flutter.dart';
import 'package:neoroo_app/models/baby_details_caregiver.dart';
import 'package:neoroo_app/models/baby_details_family_member.dart';
import 'package:neoroo_app/models/profile.dart';

class HiveStorageRepository {
  static Future<bool> checkUserLoggedIn() async {
    Box box = await Hive.openBox("users");
    print(box.containsKey("user"));
    return box.containsKey("user") && box.containsKey("selectedOrg");
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

  Future<String?> getSelectedOrgName() async {
    Box box = await Hive.openBox("users");
    return (await box.get("selectedOrgName"));
  }

  Future<void> saveCredentials(String username, String password,
      String serverURL, String? avatarId, String name) async {
    Box box = await Hive.openBox("saved");
    await box.put(
        username,
        avatarId == null
            ? [password, serverURL, name]
            : [password, serverURL, name, avatarId]);
  }

  Future<Map<String, List<String>>> getSavedCredentials() async {
    Box box = await Hive.openBox("saved");
    print(box.keys);
    dynamic keys = box.keys.toList();
    Map<String, List<String>> data = {};
    for (int i = 0; i < keys.length; i++) {
      data[keys[i]] = (await box.get(keys[i]));
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

  Future<String> getSelectedOrganisation() async {
    Box box = await Hive.openBox("users");
    return (await box.get("selectedOrg"));
  }

  Future<void> setIsCareGiver(bool isCareGiver) async {
    Box box = await Hive.openBox("users");
    await box.put("isCareGiver", isCareGiver);
  }

  Future<bool> getIsCareGiver() async {
    Box box = await Hive.openBox("users");
    return (await box.get("isCareGiver"));
  }

  Future<void> setUserGroups(List<String> userGroups) async {
    Box box = await Hive.openBox("users");
    await box.put("userGroups", userGroups);
  }

  Future<List<String>> getUserGroups() async {
    Box box = await Hive.openBox("users");
    return (await box.get("userGroups"));
  }

  Future<void> logOutUser() async {
    Box box = await Hive.openBox("users");
    box.clear();
    box = await Hive.openBox("baby");
    await box.clear();
    return;
  }

  Future<void> saveSelectedOrganisation(String id, String? name) async {
    Box box = await Hive.openBox("users");
    await box.put("selectedOrg", id);
    await box.put("selectedOrgName", name);
  }

  Future<void> storeBabyFamilyMember(
      BabyDetailsFamilyMember babyDetailsFamilyMember) async {
    Box box = await Hive.openBox("baby");
    await box.put("baby", babyDetailsFamilyMember);
    return;
  }

  Future<BabyDetailsFamilyMember?> getBabyDetailsFamilyMember() async {
    if (await Hive.boxExists("baby")) {
      Box box = await Hive.openBox("baby");
      if (box.containsKey("baby")) {
        return box.get("baby");
      }
      return null;
    }
    return null;
  }

  Future<List<BabyDetailsCaregiver>?> getBabyDetailsCaregiver() async {
    if (!await Hive.boxExists("babies")) {
      return null;
    }
    if (!(await Hive.openBox("babies")).containsKey("list_of_babies")) {
      return null;
    }
    Box box = await Hive.openBox("babies");
    List<BabyDetailsCaregiver> listOfBabies =
        List<BabyDetailsCaregiver>.from((await box.get("list_of_babies")));
    if (listOfBabies.isEmpty) {
      return null;
    }
    return listOfBabies;
  }

  Future<void> saveBabyDetailsCaregiver(
      List<BabyDetailsCaregiver>? listOfBabies) async {
    Box box = await Hive.openBox("babies");
    try {
      await box.put("list_of_babies", listOfBabies);
    } catch (e) {
      print(e);
    }
    print("D");
  }
}
