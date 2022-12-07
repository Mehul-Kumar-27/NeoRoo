import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoroo_app/bloc/learning_resources_bloc/learning_resources_bloc.dart';
import 'package:neoroo_app/bloc/learning_resources_bloc/learning_resources_events.dart';
import 'package:neoroo_app/bloc/learning_resources_bloc/learning_resources_states.dart';
import 'package:neoroo_app/screens/learning_resources/components/video_item.dart';
import 'package:neoroo_app/screens/learning_resources/video_page.dart';
import 'package:neoroo_app/utils/constants.dart';
import 'package:neoroo_app/utils/error_page.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class LearningResourcesPage extends StatefulWidget {
  const LearningResourcesPage({Key? key}) : super(key: key);

  @override
  State<LearningResourcesPage> createState() => _LearningResourcesPageState();
}

class _LearningResourcesPageState extends State<LearningResourcesPage> {
  @override
  void initState() {
    fetchVideos();
    super.initState();
  }

  void fetchVideos() {
    BlocProvider.of<LearningResourcesBloc>(context).add(LoadResourcesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<LearningResourcesBloc, LearningResourcesStates>(
          builder: (context, state) {
            if (state is LearningResourcesLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: primaryBlue,
                ),
              );
            }
            if (state is LearningResourcesError) {
              return ErrorPage();
            }
            if (state is LearningResourcesLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) => VideoItem(
                  videoMetaData: state.videoData[index],
                  auth: state.auth,
                  takeToVideoPage: () {
                    pushNewScreen(
                      context,
                      screen: VideoPlayerPage(
                        auth: state.auth,
                        videoMetaData: state.videoData[index],
                      ),
                    );
                  },
                ),
                itemCount: state.videoData.length,
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
