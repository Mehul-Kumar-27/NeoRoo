import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:neoroo_app/exceptions/custom_exception.dart';
import 'package:neoroo_app/models/profile.dart';
import 'package:neoroo_app/models/video_item.dart';
import 'package:neoroo_app/network/learning_resources_client.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;
import 'package:neoroo_app/repository/hive_storage_repository.dart';

class LearningResourcesRepository {
  final LearningResourcesClient learningResourcesClient;
  final BuildContext context;
  final HiveStorageRepository hiveStorageRepository;
  LearningResourcesRepository(
    this.learningResourcesClient,
    this.context,
    this.hiveStorageRepository,
  );
  Future<Either<List<VideoMetaData>, CustomException>> fetchVideos() async {
    try {
      final Profile profile = await hiveStorageRepository.getUserProfile();
      final String serverURL = await hiveStorageRepository.getOrganisationURL();
      http.Response response = await learningResourcesClient.fetchVideos(
        profile.username,
        profile.password,
        serverURL,
      );
      print(response.statusCode);
      if (response.statusCode != 200) {
        return Right(
          CustomException(
            AppLocalizations.of(context).errorDuringCommunication,
            null,
          ),
        );
      } else {
        List<VideoMetaData> videoList = [];
        var data = jsonDecode(response.body);
        for (var i = 0; i < data["list_of_videos"].length; i++) {
          videoList.add(
            VideoMetaData(
              description: data["list_of_videos"][i]["description"],
              image: data["list_of_videos"][i]["image"],
              name: data["list_of_videos"][i]["name"],
              url: data["list_of_videos"][i]["url"],
              language: data["list_of_videos"][i]["language"],
              duration: data["list_of_videos"][i]["duration"],
            ),
          );
        }
        return Left(videoList);
      }
    } catch (e) {
      print(e);
      return Right(
        CustomException(
          AppLocalizations.of(context).errorDuringCommunication,
          null,
        ),
      );
    }
  }
}
