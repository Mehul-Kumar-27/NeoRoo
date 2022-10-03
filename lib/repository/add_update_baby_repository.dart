import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neoroo_app/exceptions/custom_exception.dart';
import 'package:http/http.dart' as http;
import 'package:neoroo_app/models/baby_details_caregiver.dart';
import 'package:neoroo_app/network/add_update_baby_client.dart';
import 'package:neoroo_app/repository/hive_storage_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddUpdateBabyRepository {
  final HiveStorageRepository hiveStorageRepository;
  final BabyAddUpdateClient babyAddUpdateClient;
  final BuildContext context;
  AddUpdateBabyRepository({
    required this.babyAddUpdateClient,
    required this.hiveStorageRepository,
    required this.context,
  });
  Future<Either<bool, CustomException>> addBaby(
      String birthTime,
      String birthDate,
      double headCircumference,
      double birthWeight,
      String birthNotes,
      String motherName,
      double bodyLength,
      String familyMemberUserGroup,
      String caregiverUserGroup,
      int requireResuscitation,
      XFile? avatarFile,
      String username,
      String password,
      String serverURL,
      String orgId) async {
    String? avatarId;
    try {
      if (avatarFile != null) {
        http.Response imageUploadResponse = await babyAddUpdateClient.uploadImage(
            avatarFile, username, password, serverURL);
        print(imageUploadResponse.statusCode);
        print(imageUploadResponse.body);
        if (imageUploadResponse.statusCode == 401 ||
            imageUploadResponse.statusCode == 403) {
          return Right(
            UnauthorisedException(
              AppLocalizations.of(context).unauthorized,
              imageUploadResponse.statusCode,
            ),
          );
        } else if (imageUploadResponse.statusCode != 200) {
          return Right(
            FetchDataException(
              AppLocalizations.of(context).errorDuringCommunication,
              null,
            ),
          );
        } else {
          avatarId = jsonDecode(imageUploadResponse.body)["response"]
              ["fileResource"]["id"];
        }
      }
      http.Response response = await babyAddUpdateClient.addBaby(
        birthTime,
        birthDate,
        headCircumference,
        birthWeight,
        birthNotes,
        motherName,
        bodyLength,
        familyMemberUserGroup,
        caregiverUserGroup,
        requireResuscitation,
        avatarId,
        username,
        password,
        serverURL,
        orgId,
      );
      print("T" + response.body);
      if (response.statusCode == 200) {
        return Left(true);
      }
      if (response.statusCode == 401 || response.statusCode == 403) {
        return Right(
          UnauthorisedException(
            AppLocalizations.of(context).unauthorized,
            response.statusCode,
          ),
        );
      } else {
        print(response.statusCode);
        return Right(
          FetchDataException(
            AppLocalizations.of(context).errorDuringCommunication,
            null,
          ),
        );
      }
    } catch (e) {
      print(e);
      hiveStorageRepository.addBaby(
        BabyDetailsCaregiver(
          birthDate: birthDate,
          birthNotes: birthNotes,
          birthTime: birthTime,
          bodyLength: bodyLength,
          headCircumference: headCircumference,
          id: null,
          motherName: motherName,
          needResuscitation: requireResuscitation == 1,
          weight: birthWeight,
          avatarId: null,
          caregiverGroup: caregiverUserGroup,
          familyMemberGroup: familyMemberUserGroup,
          imagePath: avatarFile?.path,
        ),
      );
      return Left(true);
    }
  }
}
