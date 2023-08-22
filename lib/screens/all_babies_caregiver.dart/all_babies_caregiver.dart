import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoroo_app/bloc/all_babies_bloc/all_babies_bloc.dart';
import 'package:neoroo_app/bloc/all_babies_bloc/all_babies_events.dart';
import 'package:neoroo_app/bloc/all_babies_bloc/all_babies_states.dart';
import 'package:neoroo_app/models/baby_details_caregiver.dart';
import 'package:neoroo_app/screens/add_baby/add_baby.dart';
import 'package:neoroo_app/screens/all_babies_caregiver.dart/components/all_babies_caregiver_title.dart';
import 'package:neoroo_app/screens/all_babies_caregiver.dart/components/baby_item.dart';
import 'package:neoroo_app/utils/constants.dart';
import 'package:neoroo_app/utils/empty_baby_page.dart';
import 'package:neoroo_app/utils/error_page.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class AllBabiesList extends StatefulWidget {
  const AllBabiesList({Key? key}) : super(key: key);

  @override
  State<AllBabiesList> createState() => _AllBabiesListState();
}

class _AllBabiesListState extends State<AllBabiesList> {
  @override
  void initState() {
    BlocProvider.of<BabyDetailsCaregiverBloc>(context)
        .add(LoadAllBabiesCaregiver());
    super.initState();
  }

  void takeToUpdatePage(BabyDetailsCaregiver babyDetailsCaregiver, int index) {
    // pushNewScreen(
    //   context,
    //   screen: UpdateBaby(
    //     infant: babyDetailsCaregiver,
    //     index: index,
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AllBabiesCaregiverTitle(),
        body: BlocConsumer<BabyDetailsCaregiverBloc, BabyDetailCaregiverStates>(
          builder: (context, state) {
            if (state is BabyDetailsCaregiverFetchError) {
              return ErrorPage();
            }
            if (state is BabyDetailsCaregiverLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: primaryBlue,
                ),
              );
            }
            if (state is BabyDetailsCaregiverLoaded) {
              if (state.babyDetailsCaregiver == null) {
                return EmptyBabyPage();
              }
              return Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(
                        height: 10,
                      ),
                      itemBuilder: (context, index) => BabyItem(
                        takeToUpdate: takeToUpdatePage,
                        birthWeight: state.babyDetailsCaregiver![index].weight,
                        dateOfBirth:
                            state.babyDetailsCaregiver![index].birthDate,
                        auth: state.auth,
                        mothersName:
                            state.babyDetailsCaregiver![index].motherName,
                        timeOfBirth:
                            state.babyDetailsCaregiver![index].birthTime,
                        imageURL: state.babyDetailsCaregiver![index].avatarId ==
                                null
                            ? null
                            : state.baseURL +
                                "/api/fileResources/" +
                                state.babyDetailsCaregiver![index].avatarId! +
                                "/data",
                        babyDetailsCaregiver:
                            state.babyDetailsCaregiver![index],
                        index: index,
                      ),
                      itemCount: state.babyDetailsCaregiver!.length,
                    ),
                  ),
                ],
              );
            }
            return Container();
          },
          listener: (context, state) {},
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await pushNewScreen(
              context,
              screen: AddBaby(),
            );
            BlocProvider.of<BabyDetailsCaregiverBloc>(context)
                .add(LoadAllBabiesCaregiver());
          },
          backgroundColor: primaryBlue,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
