import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:neoroo_app/exceptions/custom_exception.dart';
import 'package:neoroo_app/models/baby_details_caregiver.dart';
import 'package:neoroo_app/models/baby_details_family_member.dart';
import 'package:neoroo_app/network/baby_details_client.dart';
import 'package:neoroo_app/repository/hive_storage_repository.dart';
import 'package:http/http.dart' as http;
import 'package:neoroo_app/utils/dhis2_config.dart' as DHIS2Config;

class BabyDetailsRepository {
  final HiveStorageRepository hiveStorageRepository;
  final BabyDetailsClient babyDetailsClient;
  BabyDetailsRepository(
      {required this.babyDetailsClient, required this.hiveStorageRepository});

  Future<Either<BabyDetailsFamilyMember?, CustomException>>
      fetchDetailsFamilyMember(
          String username,
          String password,
          String organizationUnit,
          String programId,
          String parentGroup,
          String baseURL,
          String groupAttributeId) async {
    try {
      http.Response response = await BabyDetailsClient().fetchBabyByParent(
        username,
        password,
        organizationUnit,
        programId,
        parentGroup,
        baseURL,
        groupAttributeId,
      );
      if (response.statusCode != 200) {
        return Right(
          FetchDataException("", response.statusCode),
        );
      }
      bool isLengthZero =
          jsonDecode(response.body)["trackedEntityInstances"].length == 0
              ? true
              : false;
      if (isLengthZero) {
        Left(null);
      }
      dynamic body = jsonDecode(response.body)["trackedEntityInstances"][0];
      Map<String, dynamic> filteredData = {};
      filteredData["id"] = body["trackedEntityInstance"];
      List<dynamic> attributes = body["attributes"];
      for (var i = 0; i < attributes.length; i++) {
        switch (attributes[i]["attribute"]) {
          case DHIS2Config.birthDate:
            {
              filteredData["birthDate"] = attributes[i]["value"];
            }
            break;
          case DHIS2Config.birthNotes:
            {
              filteredData["birthNotes"] = attributes[i]["value"];
            }
            break;
          case DHIS2Config.birthTime:
            {
              filteredData["birthTime"] = attributes[i]["value"];
            }
            break;
          case DHIS2Config.birthWeight:
            {
              filteredData["birthWeight"] =
                  double.parse(attributes[i]["value"]);
            }
            break;
          case DHIS2Config.bodyLength:
            {
              filteredData["bodyLength"] = double.parse(attributes[i]["value"]);
            }
            break;
          case DHIS2Config.caregiverUserGroup:
            {
              filteredData["caregiverUserGroup"] = attributes[i]["value"];
            }
            break;
          case DHIS2Config.motherName:
            {
              filteredData["motherName"] = attributes[i]["value"];
            }
            break;
          case DHIS2Config.familyMemberUserGroup:
            {
              filteredData["familyMemberUserGroup"] = attributes[i]["value"];
            }
            break;
          case DHIS2Config.headCircumference:
            {
              filteredData["headCircumference"] =
                  double.parse(attributes[i]["value"]);
            }
            break;
          case DHIS2Config.requireResuscitation:
            {
              filteredData["needResuscitation"] =
                  int.parse(attributes[i]["value"]) == 1 ? true : false;
            }
            break;
          case DHIS2Config.caregiverUserGroup:
            {
              filteredData["caregiverUserGroup"] = attributes[i]["value"];
            }
            break;
          case DHIS2Config.avatarIdAttribute:
            {
              filteredData["avatarId"] = attributes[i]["value"];
            }
            break;
        }
      }
      await hiveStorageRepository.storeBabyFamilyMember(
        BabyDetailsFamilyMember(
          birthDate: filteredData["birthDate"],
          birthNotes: filteredData["birthNotes"],
          birthTime: filteredData["birthTime"],
          bodyLength: filteredData["bodyLength"],
          headCircumference: filteredData["headCircumference"],
          id: filteredData["id"],
          motherName: filteredData["motherName"],
          needResuscitation: filteredData["needResuscitation"],
          weight: filteredData["birthWeight"],
          familyMemberGroup: filteredData["familyMemberUserGroup"],
          caregiverGroup: filteredData["caregiverUserGroup"],
          avatarId: filteredData["avatarId"],
        ),
      );
      return Left(
        BabyDetailsFamilyMember(
          birthDate: filteredData["birthDate"],
          birthNotes: filteredData["birthNotes"],
          birthTime: filteredData["birthTime"],
          bodyLength: filteredData["bodyLength"],
          headCircumference: filteredData["headCircumference"],
          id: filteredData["id"],
          motherName: filteredData["motherName"],
          needResuscitation: filteredData["needResuscitation"],
          weight: filteredData["birthWeight"],
          familyMemberGroup: filteredData["familyMemberUserGroup"],
          caregiverGroup: filteredData["caregiverUserGroup"],
          avatarId: filteredData["avatarId"],
        ),
      );
    } catch (e) {
      print(e);
      BabyDetailsFamilyMember? babyDetailsFamilyMember =
          await hiveStorageRepository.getBabyDetailsFamilyMember();
      return Left(babyDetailsFamilyMember);
    }
  }

  Future<Either<List<BabyDetailsCaregiver>?, CustomException>>
      fetchDetailsCaregiver(
    String username,
    String password,
    String organizationUnit,
    String programId,
    String caregiverGroup,
    String baseURL,
    String groupAttributeId,
  ) async {
    try {
      http.Response response = await BabyDetailsClient().fetchBabyFromCaregiver(
        username,
        password,
        organizationUnit,
        programId,
        caregiverGroup,
        baseURL,
        groupAttributeId,
      );
      if (response.statusCode != 200) {
        return Right(
          FetchDataException("", response.statusCode),
        );
      }
      bool isLengthZero =
          jsonDecode(response.body)["trackedEntityInstances"].length == 0
              ? true
              : false;
      if (isLengthZero) {
        print("H");
        return Left(null);
      }
      int l = jsonDecode(response.body)["trackedEntityInstances"].length;
      print(l);
      List<BabyDetailsCaregiver> babyDetailsCaregiver = [];
      for (int k = 0; k < l; k++) {
        dynamic body = jsonDecode(response.body)["trackedEntityInstances"][k];
        Map<String, dynamic> filteredData = {};
        filteredData["id"] = body["trackedEntityInstance"];
        List<dynamic> attributes = body["attributes"];
        for (var i = 0; i < attributes.length; i++) {
          switch (attributes[i]["attribute"]) {
            case DHIS2Config.birthDate:
              {
                filteredData["birthDate"] = attributes[i]["value"];
              }
              break;
            case DHIS2Config.birthNotes:
              {
                filteredData["birthNotes"] = attributes[i]["value"];
              }
              break;
            case DHIS2Config.birthTime:
              {
                filteredData["birthTime"] = attributes[i]["value"];
              }
              break;
            case DHIS2Config.birthWeight:
              {
                filteredData["birthWeight"] =
                    double.parse(attributes[i]["value"]);
              }
              break;
            case DHIS2Config.bodyLength:
              {
                filteredData["bodyLength"] =
                    double.parse(attributes[i]["value"]);
              }
              break;
            case DHIS2Config.caregiverUserGroup:
              {
                filteredData["caregiverUserGroup"] = attributes[i]["value"];
              }
              break;
            case DHIS2Config.motherName:
              {
                filteredData["motherName"] = attributes[i]["value"];
              }
              break;
            case DHIS2Config.familyMemberUserGroup:
              {
                filteredData["familyMemberUserGroup"] = attributes[i]["value"];
              }
              break;
            case DHIS2Config.headCircumference:
              {
                filteredData["headCircumference"] =
                    double.parse(attributes[i]["value"]);
              }
              break;
            case DHIS2Config.requireResuscitation:
              {
                filteredData["needResuscitation"] =
                    int.parse(attributes[i]["value"]) == 1 ? true : false;
              }
              break;
            case DHIS2Config.caregiverUserGroup:
              {
                filteredData["caregiverUserGroup"] = attributes[i]["value"];
              }
              break;
            case DHIS2Config.avatarIdAttribute:
              {
                filteredData["avatarId"] = attributes[i]["value"];
              }
              break;
          }
        }
        babyDetailsCaregiver.add(
          BabyDetailsCaregiver(
            birthDate: filteredData["birthDate"],
            birthNotes: filteredData["birthNotes"],
            birthTime: filteredData["birthTime"],
            bodyLength: filteredData["bodyLength"],
            headCircumference: filteredData["headCircumference"],
            id: filteredData["id"],
            motherName: filteredData["motherName"],
            needResuscitation: filteredData["needResuscitation"],
            weight: filteredData["birthWeight"],
            familyMemberGroup: filteredData["familyMemberUserGroup"],
            caregiverGroup: filteredData["caregiverUserGroup"],
            avatarId: filteredData["avatarId"],
          ),
        );
      }
      await hiveStorageRepository
          .saveBabyDetailsCaregiver(babyDetailsCaregiver);
      return Left(babyDetailsCaregiver);
    } catch (e) {
      print(e);
      List<BabyDetailsCaregiver>? babyDetailsCaregiver =
          await hiveStorageRepository.getBabyDetailsCaregiver();
      return Left(babyDetailsCaregiver);
    }
  }
}
