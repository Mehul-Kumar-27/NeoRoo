import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:neoroo_app/bloc/learning_resources_bloc/learning_resources_events.dart';
import 'package:neoroo_app/bloc/learning_resources_bloc/learning_resources_states.dart';
import 'package:neoroo_app/exceptions/custom_exception.dart';
import 'package:neoroo_app/models/profile.dart';
import 'package:neoroo_app/models/video_item.dart';
import 'package:neoroo_app/repository/hive_storage_repository.dart';
import 'package:neoroo_app/repository/learning_resources_repository.dart';
import 'dart:convert';

class LearningResourcesBloc
    extends Bloc<LearningResourcesEvents, LearningResourcesStates> {
  final HiveStorageRepository hiveStorageRepository;
  final LearningResourcesRepository learningResourcesRepository;
  LearningResourcesBloc(
      this.hiveStorageRepository, this.learningResourcesRepository)
      : super(LearningResourcesInitial()) {
    on<LoadResourcesEvent>(loadLearningResources);
  }
  Future<void> loadLearningResources(LoadResourcesEvent loadResourcesEvent,
      Emitter<LearningResourcesStates> emitter) async {
    emitter(
      LearningResourcesLoading(),
    );
    try {
      Either<List<VideoMetaData>, CustomException> learningResources =
          await learningResourcesRepository.fetchVideos();
      final Profile profile = await hiveStorageRepository.getUserProfile();
      String basicAuth = 'Basic ' +
          base64Encode(utf8.encode('${profile.username}:${profile.password}'));
      learningResources.fold(
        (l) => emitter(
          LearningResourcesLoaded(basicAuth, l),
        ),
        (r) => emitter(
          LearningResourcesError(),
        ),
      );
    } catch (e) {
      print(e);
    }
  }
}
