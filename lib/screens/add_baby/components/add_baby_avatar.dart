import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neoroo_app/screens/add_baby/components/add_baby_avatar_methods.dart';
import 'package:neoroo_app/utils/constants.dart';

class BabyDetailsAvatar extends StatefulWidget {
  final Map<String, XFile?> imageData;
  final ImagePicker imagePicker;
  const BabyDetailsAvatar(
      {Key? key, required this.imageData, required this.imagePicker})
      : super(key: key);

  @override
  State<BabyDetailsAvatar> createState() => _BabyDetailsAvatarState();
}

class _BabyDetailsAvatarState extends State<BabyDetailsAvatar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () async {
            await showModalBottomSheet(
              context: context,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    20,
                  ),
                  topRight: Radius.circular(
                    20,
                  ),
                ),
              ),
              builder: (context) {
                return Container(
                  height: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        20,
                      ),
                      topRight: Radius.circular(
                        20,
                      ),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          AddBabyAvatarMethod(
                            icon: Icons.delete,
                            textColor: outlineGrey,
                            methodName: "Remove",
                            onPressed: () {
                              setState(() {
                                widget.imageData["value"] = null;
                              });
                              Navigator.of(context).pop();
                            },
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          AddBabyAvatarMethod(
                            icon: Icons.photo,
                            textColor: outlineGrey,
                            methodName: "Gallery",
                            onPressed: () async {
                              final XFile? image = await widget.imagePicker
                                  .pickImage(source: ImageSource.gallery);
                              setState(() {
                                widget.imageData["value"] = image;
                              });
                              Navigator.of(context).pop();
                            },
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          AddBabyAvatarMethod(
                            icon: Icons.add_a_photo,
                            textColor: outlineGrey,
                            methodName: "Camera",
                            onPressed: () async {
                              final XFile? image =
                                  await widget.imagePicker.pickImage(
                                source: ImageSource.camera,
                              );
                              setState(() {
                                widget.imageData["value"] = image;
                              });
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: CircleAvatar(
            radius: 75,
            backgroundColor: primaryBlue,
            child: CircleAvatar(
              radius: 73,
              backgroundColor: Colors.white,
              child: (widget.imageData["value"] == null)
                  ? Image.asset(
                      "assets/baby_placeholder.png",
                    )
                  : null,
              backgroundImage: widget.imageData["value"] != null
                  ? FileImage(
                      File(
                        widget.imageData["value"]!.path,
                      ),
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}
