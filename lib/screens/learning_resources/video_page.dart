import 'dart:math';

import 'package:flutter/material.dart';
import 'package:neoroo_app/models/video_item.dart';
import 'package:neoroo_app/utils/constants.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerPage extends StatefulWidget {
  final VideoMetaData videoMetaData;
  final String auth;
  const VideoPlayerPage(
      {Key? key, required this.auth, required this.videoMetaData})
      : super(key: key);

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late VideoPlayerController _videoController;
  bool _isPlaying = false;
  @override
  void initState() {
    initialiseVideoPlayer();
    super.initState();
  }

  void initialiseVideoPlayer() async {
    try {
      print(widget.videoMetaData.url);
      _videoController = VideoPlayerController.network(
        widget.videoMetaData.url,
        httpHeaders: {"authorization": "${widget.auth}"},
        videoPlayerOptions: VideoPlayerOptions(
          allowBackgroundPlayback: true,
        ),
      )..initialize().then(
          (value) {
            _videoController.play();
            setState(() {
              _isPlaying = true;
            });
          },
        );
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: _videoController.value.aspectRatio,
                  child: VideoPlayer(
                    _videoController,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: VideoProgressIndicator(
                          _videoController,
                          padding: EdgeInsets.only(
                            top: 8,
                          ),
                          allowScrubbing: true,
                          colors: VideoProgressColors(
                            backgroundColor: Colors.white,
                            playedColor: Colors.red,
                            bufferedColor: Colors.grey[300]!,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                left: 5,
                              ),
                              child: GestureDetector(
                                onTap: () async {
                                  if (_videoController.value.isPlaying) {
                                    _videoController.pause();
                                    setState(() {
                                      _isPlaying = false;
                                    });
                                  } else {
                                    _videoController.play();
                                    setState(() {
                                      _isPlaying = true;
                                    });
                                  }
                                },
                                child: Icon(
                                  _isPlaying &&
                                          (_videoController.value.duration !=
                                              _videoController.value.position)
                                      ? Icons.pause
                                      : Icons.play_arrow_rounded,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _videoController.seekTo(
                                  Duration(
                                    seconds: min(
                                      _videoController
                                              .value.position.inSeconds +
                                          10,
                                      _videoController.value.duration.inSeconds,
                                    ),
                                  ),
                                );
                              },
                              child: Icon(
                                Icons.forward_10,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            ValueListenableBuilder(
                              valueListenable: _videoController,
                              builder:
                                  (context, VideoPlayerValue value, child) {
                                return Text(
                                  "${_videoController.value.position.inHours.toString().padLeft(2, '0')}:${(_videoController.value.position.inMinutes % 60).toString().padLeft(2, '0')}:${(_videoController.value.position.inSeconds % 60).toString().padLeft(2, '0')}/${_videoController.value.duration.inHours.toString().padLeft(2, '0')}:${(_videoController.value.duration.inMinutes % 60).toString().padLeft(2, '0')}:${(_videoController.value.duration.inSeconds % 60).toString().padLeft(2, '0')}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: openSans,
                                  ),
                                );
                              },
                            ),
                            Expanded(
                              child: Container(
                                height: 10,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _videoController.seekTo(
                                  Duration(
                                    seconds: max(
                                      _videoController
                                              .value.position.inSeconds -
                                          10,
                                      0,
                                    ),
                                  ),
                                );
                              },
                              child: Icon(
                                Icons.replay_10,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Text(
                widget.videoMetaData.name,
                style: TextStyle(
                  fontFamily: openSans,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 8,
                left: 10,
              ),
              child: Text(
                "${widget.videoMetaData.language}|${widget.videoMetaData.duration}",
                style: TextStyle(
                  fontFamily: openSans,
                  color: outlineGrey,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Text(
                widget.videoMetaData.description,
                style: TextStyle(
                  fontFamily: openSans,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
