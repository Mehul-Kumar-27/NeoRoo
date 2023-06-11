import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:neoroo_app/models/baby_details_caregiver.dart';
import 'package:neoroo_app/models/baby_details_family_member.dart';
import 'package:neoroo_app/models/profile.dart';
import 'package:neoroo_app/models/tracked_attributes.dart';


class HiveStorageRepository {
  static final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  HiveStorageRepository(SecureStorageRepository);
  static Future<List<int>> getKey() async {
    if (await secureStorage.containsKey(key: "key")) {
      return base64Url.decode((await secureStorage.read(key: 'key'))!);
    }
    List<int> key = Hive.generateSecureKey();
    await secureStorage.write(
      key: 'key',
      value: base64Encode(key),
    );
    return key;
  }

  static Future<bool> checkUserLoggedIn() async {
    List<int> key = await getKey();
    Box box = await Hive.openBox(
      "users",
      encryptionCipher: HiveAesCipher(key),
    );
    bool isUserLoggedIn = false;
    if (box.containsKey("loggedIn")) {
      isUserLoggedIn = box.get("loggedIn");
    }
    print(box.containsKey("loggedIn"));
    //return box.containsKey("user") && box.containsKey("selectedOrg");
    return isUserLoggedIn;
  }

  saveLoginInformation() async {
    List<int> key = await getKey();
    Box box = await Hive.openBox(
      "users",
      encryptionCipher: HiveAesCipher(key),
    );
    await box.put("loggedIn", true);
  }

  Future<void> saveTrackedAttribute(TrackedAttributes trackedAttribute) async {
    List<int> key = await getKey();
    Box box =
        await Hive.openBox("attributes", encryptionCipher: HiveAesCipher(key));
    await box.put(trackedAttribute.trackedAttributeShortName, trackedAttribute);
  }

  Future<TrackedAttributes> getTarckedAttribute(
      String trackedAttributeShortName) async {
    List<int> key = await getKey();
    Box box = await Hive.openBox(
      "attributes",
      encryptionCipher: HiveAesCipher(
        key,
      ),
    );

    return await box.get(trackedAttributeShortName);
  }

  Future<void> saveUserProfile(Profile profile) async {
    List<int> key = await getKey();
    Box box = await Hive.openBox(
      "users",
      encryptionCipher: HiveAesCipher(
        key,
      ),
    );
    await box.put("user", profile);
  }

  Future<Profile> getUserProfile() async {
    List<int> key = await getKey();
    Box box = await Hive.openBox(
      "users",
      encryptionCipher: HiveAesCipher(
        key,
      ),
    );
    Profile profile = await box.get("user");
    return profile;
  }

  Future<void> saveOrganisationURL(String url) async {
    List<int> key = await getKey();
    Box box = await Hive.openBox(
      "users",
      encryptionCipher: HiveAesCipher(
        key,
      ),
    );
    await box.put("url", url);
  }

  Future<String> getOrganisationURL() async {
    List<int> key = await getKey();
    Box box = await Hive.openBox(
      "users",
      encryptionCipher: HiveAesCipher(
        key,
      ),
    );
    return box.get("url");
  }

  Future<String?> getSelectedOrgName() async {
    List<int> key = await getKey();
    Box box = await Hive.openBox(
      "users",
      encryptionCipher: HiveAesCipher(
        key,
      ),
    );
    return (await box.get("selectedOrgName"));
  }

  Future<void> saveCredentials(
    String username,
    String password,
    String serverURL,
    String? avatarId,
    String name,
  ) async {
    List<int> key = await getKey();
    Box box = await Hive.openBox(
      "saved",
      encryptionCipher: HiveAesCipher(
        key,
      ),
    );
    print("Save Credentials");
    print(username);
    print(password);
    print(serverURL);
    await box.put(
        username,
        avatarId == null
            ? [password, serverURL, name]
            : [password, serverURL, name, avatarId]);
  }

  Future<Map<String, List<String>>> getSavedCredentials() async {
    List<int> key = await getKey();
    Box box = await Hive.openBox(
      "saved",
      encryptionCipher: HiveAesCipher(
        key,
      ),
    );
    print(box.keys);
    dynamic keys = box.keys.toList();
    Map<String, List<String>> data = {};
    for (int i = 0; i < keys.length; i++) {
      data[keys[i]] = (await box.get(keys[i]));
    }
    return data;
  }

  Future<void> saveOrganisations(List<String> organisationList) async {
    List<int> key = await getKey();
    Box box = await Hive.openBox(
      "users",
      encryptionCipher: HiveAesCipher(
        key,
      ),
    );
    await box.put("orgs", organisationList);
  }

  Future<List<String>> getSavedOrganisations() async {
    List<int> key = await getKey();
    Box box = await Hive.openBox(
      "users",
      encryptionCipher: HiveAesCipher(
        key,
      ),
    );
    return (await box.get("orgs"));
  }

  Future<String> getSelectedOrganisation() async {
    List<int> key = await getKey();
    Box box = await Hive.openBox(
      "users",
      encryptionCipher: HiveAesCipher(
        key,
      ),
    );
    return (await box.get("selectedOrg"));
  }

  Future<void> setIsCareGiver(bool isCareGiver) async {
    List<int> key = await getKey();
    Box box = await Hive.openBox(
      "users",
      encryptionCipher: HiveAesCipher(
        key,
      ),
    );
    await box.put("isCareGiver", isCareGiver);
  }

  Future<bool> getIsCareGiver() async {
    List<int> key = await getKey();
    Box box = await Hive.openBox(
      "users",
      encryptionCipher: HiveAesCipher(
        key,
      ),
    );
    return (await box.get("isCareGiver"));
  }

  Future<void> setUserGroups(List<String> userGroups) async {
    List<int> key = await getKey();
    Box box = await Hive.openBox(
      "users",
      encryptionCipher: HiveAesCipher(
        key,
      ),
    );
    await box.put("userGroups", userGroups);
  }

  Future<List<String>> getUserGroups() async {
    List<int> key = await getKey();
    Box box = await Hive.openBox(
      "users",
      encryptionCipher: HiveAesCipher(
        key,
      ),
    );
    return (await box.get("userGroups"));
  }

  Future<void> logOutUser() async {
    List<int> key = await getKey();
    Box box = await Hive.openBox(
      "users",
      encryptionCipher: HiveAesCipher(
        key,
      ),
    );
    box.clear();
    box = await Hive.openBox("baby");
    await box.clear();
    return;
  }

  Future<void> saveSelectedOrganisation(String id, String? name) async {
    List<int> key = await getKey();
    Box box = await Hive.openBox(
      "users",
      encryptionCipher: HiveAesCipher(
        key,
      ),
    );
    await box.put("selectedOrg", id);
    await box.put("selectedOrgName", name);
  }

  Future<void> storeBabyFamilyMember(
      BabyDetailsFamilyMember babyDetailsFamilyMember) async {
    List<int> key = await getKey();
    Box box = await Hive.openBox(
      "baby",
      encryptionCipher: HiveAesCipher(
        key,
      ),
    );
    await box.put("baby", babyDetailsFamilyMember);
    return;
  }

  Future<BabyDetailsFamilyMember?> getBabyDetailsFamilyMember() async {
    List<int> key = await getKey();
    if (await Hive.boxExists("baby")) {
      Box box = await Hive.openBox(
        "baby",
        encryptionCipher: HiveAesCipher(
          key,
        ),
      );
      if (box.containsKey("baby")) {
        return box.get("baby");
      }
      return null;
    }
    return null;
  }

  Future<List<BabyDetailsCaregiver>?> getBabyDetailsCaregiver() async {
    List<int> key = await getKey();
    if (!await Hive.boxExists("babies")) {
      return null;
    }
    if (!(await Hive.openBox(
      "babies",
      encryptionCipher: HiveAesCipher(
        key,
      ),
    ))
        .containsKey("list_of_babies")) {
      return null;
    }
    Box box = await Hive.openBox(
      "babies",
      encryptionCipher: HiveAesCipher(
        key,
      ),
    );
    List<BabyDetailsCaregiver> listOfBabies =
        List<BabyDetailsCaregiver>.from((await box.get("list_of_babies")));
    if (listOfBabies.isEmpty) {
      return null;
    }
    return listOfBabies;
  }

  Future<void> saveBabyDetailsCaregiver(
      List<BabyDetailsCaregiver>? listOfBabies) async {
    List<int> key = await getKey();
    Box box = await Hive.openBox(
      "babies",
      encryptionCipher: HiveAesCipher(
        key,
      ),
    );
    try {
      await box.put("list_of_babies", listOfBabies);
    } catch (e) {
      print(e);
    }
    print("D");
  }

  Future<void> addBaby(BabyDetailsCaregiver babyDetailsCaregiver) async {
    List<BabyDetailsCaregiver>? babyDetailsCaregiverList;
    if (!await Hive.boxExists("babies")) {
      babyDetailsCaregiverList = [];
    } else if (!(await Hive.openBox("babies")).containsKey("list_of_babies")) {
      babyDetailsCaregiverList = [];
    } else {
      Box box = await Hive.openBox("babies");
      babyDetailsCaregiverList = await box.get("list_of_babies");
    }
    babyDetailsCaregiverList!.add(babyDetailsCaregiver);
    Box box = await Hive.openBox("babies");
    await box.put("list_of_babies", babyDetailsCaregiverList);
  }

  Future<void> updateBaby(
    String birthDate,
    String birthTime,
    String motherName,
    double birthWeight,
    double bodyLength,
    double headCircumference,
    String familyMemberGroup,
    String caregiverGroup,
    String birthDescription,
    int index,
  ) async {
    List<BabyDetailsCaregiver>? babyDetailsCaregiverList;
    if (!await Hive.boxExists("babies")) {
      babyDetailsCaregiverList = [];
    } else if (!(await Hive.openBox("babies")).containsKey("list_of_babies")) {
      babyDetailsCaregiverList = [];
    } else {
      Box box = await Hive.openBox("babies");
      babyDetailsCaregiverList = await box.get("list_of_babies");
    }
    babyDetailsCaregiverList![index].birthDate = birthDate;
    babyDetailsCaregiverList[index].birthTime = birthTime;
    babyDetailsCaregiverList[index].motherName = motherName;
    babyDetailsCaregiverList[index].bodyLength = bodyLength;
    babyDetailsCaregiverList[index].weight = birthWeight;
    babyDetailsCaregiverList[index].headCircumference = headCircumference;
    babyDetailsCaregiverList[index].familyMemberGroup = familyMemberGroup;
    babyDetailsCaregiverList[index].caregiverGroup = caregiverGroup;
    babyDetailsCaregiverList[index].birthNotes = birthDescription;
    Box box = await Hive.openBox("babies");
    await box.put("list_of_babies", babyDetailsCaregiverList);
    print("Update done");
  }
}
