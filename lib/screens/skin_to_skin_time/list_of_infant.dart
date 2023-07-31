import 'package:flutter/material.dart';
import 'package:neoroo_app/models/infant_model.dart';
import 'package:neoroo_app/screens/skin_to_skin_time/graph.dart';
import 'package:neoroo_app/screens/skin_to_skin_time/skin_to_skin_screen_for_infant.dart';
import 'package:neoroo_app/utils/constants.dart';
import 'package:neoroo_app/utils/dhis2_config.dart' as DHIS2Config;
import 'package:neoroo_app/utils/text_widget.dart';

class ListOfInfantsOnServer extends StatelessWidget {
  final List<Infant> infantOnServer;
  const ListOfInfantsOnServer({
    Key? key,
    required this.infantOnServer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        Infant infant = infantOnServer[index];
        return Padding(
          padding: const EdgeInsets.only(top: 30.0, left: 40),
          child: SizedBox(
            height: 170,
            width: MediaQuery.of(context).size.width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Baby ${infant.moterName}",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 17.0),
                      child: Center(
                        child: CircleAvatar(
                          backgroundColor: purpleTheme,
                          radius: 45,
                          backgroundImage:
                              NetworkImage(DHIS2Config.babyImageURL),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget(
                        heading: "Date of Birth: ", data: infant.dateOfBirth),
                    TextWidget(
                        heading: "Time of Birth: ", data: infant.timeOfBirth),
                    TextWidget(
                        heading: "Current Weight: ",
                        data: "${infant.birthWeight} gms"),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 45,
                        ),
                        InkWell(
                          onTap: () {
                            List<Data> data1 = [
                              Data(date: '2023-07-23', hours: 8.5),
                              Data(date: '2023-07-24', hours: 14),
                              Data(date: '2023-07-25', hours: 10),
                              Data(date: '2023-07-26', hours: 6),
                              Data(date: '2023-07-27', hours: 12),
                              Data(date: '2023-07-28', hours: 9),
                              Data(date: '2023-07-29', hours: 7),
                            ];
                            List<Data> data2 = [
                              Data(date: '2023-07-23', hours: 12),
                              Data(date: '2023-07-24', hours: 15),
                              Data(date: '2023-07-25', hours: 19),
                              Data(date: '2023-07-26', hours: 7),
                              Data(date: '2023-07-27', hours: 13),
                              Data(date: '2023-07-28', hours: 22),
                              Data(date: '2023-07-29', hours: 24),
                            ];
                            List<List<Data>> mapData = [data1, data2];
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SkinToSkinScreenForInfant(
                                          infant: infant,
                                          mapData: mapData,
                                        )));
                          },
                          child: Container(
                            height: 30,
                            width: 110,
                            decoration: BoxDecoration(color: purpleTheme),
                            child: Center(
                                child: Text(
                              "View STS Activity",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            )),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
      itemCount: infantOnServer.length,
      separatorBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(left: 25, right: 25),
          child: Container(
            height: 1,
            width: 302,
            color: Colors.grey.shade400,
          ),
        );
      },
    );
  }
}
