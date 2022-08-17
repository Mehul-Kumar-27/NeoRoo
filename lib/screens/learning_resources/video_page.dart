import 'package:flutter/material.dart';
import 'package:neoroo_app/models/video_item.dart';

class VideoPlayerPage extends StatefulWidget {
  final VideoMetaData videoMetaData;
  final String auth;
  const VideoPlayerPage({Key? key,required this.auth,required this.videoMetaData}) : super(key: key);

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(),
    );
  }
}
