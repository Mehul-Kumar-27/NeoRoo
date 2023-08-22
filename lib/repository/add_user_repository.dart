// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dartz/dartz.dart';

import 'package:neoroo_app/exceptions/custom_exception.dart';
import 'package:neoroo_app/network/add_user_client.dart';
import 'package:neoroo_app/repository/hive_storage_repository.dart';

class AddUserRepository {
  final HiveStorageRepository hiveStorageRepository;
  final AddUserCliet addUserCliet;
  AddUserRepository({
    required this.hiveStorageRepository,
    required this.addUserCliet,
  });
  Future<Either<String, CustomException>> createUserOnDhis2Server(
      String firstName,
      String lastName,
      String email,
      String username,
      String password,
      String adminUsername,
      String adminPassword,
      String organizationUnitID,
      String serverURL) async {
    try {
      var response = await addUserCliet.createUserOnDhis2Server(
          firstName,
          lastName,
          email,
          username,
          password,
          serverURL,
          adminUsername,
          adminPassword,
          organizationUnitID);
      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(response.body);
        if (response.statusCode == 200) {
          String uid = data['typeReports'][0]['objectReports'][0]['uid'];

          return Left(uid);
        } else {
          String uid = data['response']['uid'];
          return Left(uid);
        }
      } else {
        Right(CustomException(response.body, response.statusCode));
      }
    } catch (e) {
      Right(CustomException(e.toString(), 501));
    }

    return Right(CustomException("Unkown Error Occured !", 501));
  }
}
// {"httpStatus":"Created","httpStatusCode":201,"status":"OK","response":{"responseType":"ObjectReport","klass":"org.hisp.dhis.user.User","uid":"a5bQl008nwm","errorReports":[]}}