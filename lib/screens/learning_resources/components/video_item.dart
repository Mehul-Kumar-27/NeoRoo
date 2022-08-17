import 'package:flutter/material.dart';
import 'package:neoroo_app/models/video_item.dart';
import 'package:neoroo_app/utils/constants.dart';

class VideoItem extends StatelessWidget {
  final VideoMetaData videoMetaData;
  final String auth;
  final VoidCallback takeToVideoPage;
  const VideoItem({
    Key? key,
    required this.videoMetaData,
    required this.auth,
    required this.takeToVideoPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: takeToVideoPage,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        child: Card(
          margin: EdgeInsets.zero,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: (MediaQuery.of(context).size.width - 20) / 2,
                child: Image.network(
                  videoMetaData.image,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Text(
                          videoMetaData.name.substring(0,40),
                          style: TextStyle(
                            fontFamily: openSans,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    PopupMenuButton(
                      child: Icon(
                        Icons.more_horiz,
                      ),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Bookmark",
                              ),
                              Icon(
                                Icons.bookmark_add_outlined,
                              ),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Download for later",
                              ),
                              Icon(
                                Icons.download,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
