// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoroo_app/utils/dhis2_config.dart' as DHIS2Config;
import 'package:neoroo_app/bloc/fetch_baby_bloc/fetch_baby_bloc.dart';
import 'package:neoroo_app/bloc/fetch_baby_bloc/fetch_baby_events.dart';
import 'package:neoroo_app/bloc/fetch_baby_bloc/fetch_baby_states.dart';
import 'package:neoroo_app/models/infant_model.dart';
import 'package:neoroo_app/screens/update_baby/update_baby.dart';
import 'package:neoroo_app/utils/text_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<FetchBabyBloc>(context).add(GetInfantsFromServer(context));
    super.initState();
  }

  List<Infant> infantsOnServer = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<FetchBabyBloc, FetchBabyStates>(
          listener: (context, state) {
            print("This is home page");
            print(state);
            if (state is FetchInfantFromServerError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.exception),
                ),
              );
            }
            if (state is FetchInfantFromServerSuccess) {
              if (state.infantList.isEmpty) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("No Data To Show")));
              } else {
                infantsOnServer = state.infantList;
              }
            }
            if (state is SearchInfantList) {
              if (state.infants.isEmpty) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("No Data To Show")));
              } else {
                infantsOnServer = state.infants;
              }
            }
          },
          builder: (context, state) {
            if (state is FetchBabyTriggeredState) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () => getData(),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            onChanged: (String searchQuery) {
                              if (state is FetchInfantFromServerSuccess) {
                                BlocProvider.of<FetchBabyBloc>(context).add(
                                    SearchInfants(
                                        query: searchQuery,
                                        infantList: state.infantList));
                              }
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter your search query',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: infantsOnServer.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UpdateBaby(
                                            infant: infantsOnServer[index],
                                            index: index)));
                              },
                              child:
                                  InfantWidget(infant: infantsOnServer[index]),
                            );
                          })),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> getData() async {
    BlocProvider.of<FetchBabyBloc>(context).add(GetInfantsFromServer(context));
  }
}

class InfantWidget extends StatelessWidget {
  final Infant infant;
  const InfantWidget({super.key, required this.infant});

  @override
  Widget build(BuildContext context) {
  
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        child: Row(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Baby ${infant.moterName}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: CircleAvatar(
                      radius: 45,
                      backgroundImage: NetworkImage(DHIS2Config.babyImageURL),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                    heading: "Date of Birth: ", data: infant.dateOfBirth),
                TextWidget(
                    heading: "Time of Birth: ", data: infant.timeOfBirth),
                TextWidget(
                    heading: "Current Weight: ", data: infant.birthWeight),
                TextWidget(heading: "Ward Number: ", data: infant.wardNumber)
              ],
            )
          ],
        ),
      ),
    );
  }
}

