import 'package:neoroo_app/models/video_item.dart';

class LearningResourcesStates{}

class LearningResourcesInitial extends LearningResourcesStates{}

class LearningResourcesLoading extends LearningResourcesStates{}

class LearningResourcesLoaded extends LearningResourcesStates{
  final List<VideoMetaData> videoData;
  final String auth;
  LearningResourcesLoaded(this.auth,this.videoData);
}

class LearningResourcesError extends LearningResourcesStates{}