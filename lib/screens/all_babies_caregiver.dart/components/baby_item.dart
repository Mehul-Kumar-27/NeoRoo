import 'package:flutter/material.dart';
import 'package:neoroo_app/models/baby_details_caregiver.dart';
import 'package:neoroo_app/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BabyItem extends StatelessWidget {
  final String mothersName;
  final String dateOfBirth;
  final String timeOfBirth;
  final double birthWeight;
  final String? imageURL;
  final String auth;
  final BabyDetailsCaregiver babyDetailsCaregiver;
  final int index;
  final void Function(BabyDetailsCaregiver,int) takeToUpdate;
  const BabyItem({
    Key? key,
    required this.birthWeight,
    required this.dateOfBirth,
    required this.imageURL,
    required this.mothersName,
    required this.timeOfBirth,
    required this.auth,
    required this.takeToUpdate,
    required this.babyDetailsCaregiver,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        takeToUpdate(babyDetailsCaregiver,index);
      },
      child: Container(
        width: double.infinity,
        height: 162,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          margin: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 8,
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 10,
                ),
                child: Text(
                  AppLocalizations.of(context).babyOfMother(mothersName),
                  style: TextStyle(
                    fontFamily: openSans,
                    color: primaryBlue,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: 9,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Row(
                  children: [
                    Container(
                      height: 120,
                      width: 100,
                      color: Colors.transparent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 46,
                            backgroundColor: primaryBlue,
                            child: CircleAvatar(
                              radius: 45,
                              backgroundColor: Colors.white,
                              child: imageURL == null
                                  ? Image.asset(
                                      "assets/baby_placeholder.png",
                                    )
                                  : null,
                              backgroundImage: imageURL == null
                                  ? null
                                  : NetworkImage(
                                      imageURL!,
                                      headers: {
                                        "authorization": auth,
                                      },
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Container(
                        height: 120,
                        color: Colors.transparent,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            RichText(
                              maxLines: 1,
                              text: TextSpan(children: [
                                TextSpan(
                                  text: "Date of Birth: ",
                                  style: TextStyle(
                                    fontFamily: openSans,
                                    color: primaryBlue,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.5,
                                  ),
                                ),
                                TextSpan(
                                  text: dateOfBirth,
                                  style: TextStyle(
                                    fontFamily: openSans,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15.5,
                                  ),
                                ),
                              ]),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            RichText(
                              maxLines: 1,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Time of Birth: ",
                                    style: TextStyle(
                                      fontFamily: openSans,
                                      color: primaryBlue,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15.5,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "$timeOfBirth hrs",
                                    style: TextStyle(
                                      fontFamily: openSans,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            RichText(
                              maxLines: 1,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Birth Weight: ",
                                    style: TextStyle(
                                      fontFamily: openSans,
                                      color: primaryBlue,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15.5,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "$birthWeight g",
                                    style: TextStyle(
                                      fontFamily: openSans,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 10,
        ),
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
      ),
    );
  }
}
