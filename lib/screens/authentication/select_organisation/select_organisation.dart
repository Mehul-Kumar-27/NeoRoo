import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoroo_app/bloc/authentication/select_organisation_bloc/select_organisation_bloc.dart';
import 'package:neoroo_app/bloc/authentication/select_organisation_bloc/select_organisation_events.dart';
import 'package:neoroo_app/bloc/authentication/select_organisation_bloc/select_organisation_states.dart';
import 'package:neoroo_app/screens/authentication/select_organisation/components/mobile_body_select_organisation.dart';
import 'package:neoroo_app/screens/authentication/select_organisation/components/tablet_body_select_organisation.dart';
import 'package:neoroo_app/screens/temp_screen.dart';
import 'package:neoroo_app/utils/constants.dart';

class SelectOrganisation extends StatefulWidget {
  const SelectOrganisation({Key? key}) : super(key: key);

  @override
  State<SelectOrganisation> createState() => _SelectOrganisationState();
}

class _SelectOrganisationState extends State<SelectOrganisation> {
  int _groupValue = 0;
  void initialise() {
    BlocProvider.of<SelectOrganisationBloc>(context).add(
      RequestOrganisationInfo(),
    );
  }

  @override
  void initState() {
    initialise();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<SelectOrganisationBloc, SelectOrganisationStates>(
        listener: (context, state) {
          if (state is SelectOrganisationComplete) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => TempScreen(),
              ),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          if (state is SelectOrganisationLoading) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: primaryBlue,
                ),
              ),
            );
          }
          else if(state is SelectOrganisationComplete){
            return Container();
          } 
          else {
            List<List<String?>> orgUnitLists =
                (state as SelectOrganisationLoaded).organisationData;
            if (min(MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height) >
                600) {
              return Scaffold(
                body: TabletBodySelectOrganisation(
                  proceed: (String id) {
                    BlocProvider.of<SelectOrganisationBloc>(context).add(
                      SelectOrganisationEvent(
                        organisationId: id,
                      ),
                    );
                  },
                  orgIdList: orgUnitLists[1],
                  orgNameList: orgUnitLists[0],
                  groupValue: _groupValue,
                  onChange: (index) {
                    print(index);
                    setState(() {
                      _groupValue = index!;
                    });
                  },
                ),
              );
            } else {
              return Scaffold(
                body: MobileBodySelectOrganisation(
                  proceed: (String id) {
                    BlocProvider.of<SelectOrganisationBloc>(context).add(
                      SelectOrganisationEvent(
                        organisationId: id,
                      ),
                    );
                  },
                  orgIdList: orgUnitLists[1],
                  orgNameList: orgUnitLists[0],
                  groupValue: _groupValue,
                  onChange: (index) {
                    print(index);
                    setState(() {
                      _groupValue = index!;
                    });
                  },
                ),
              );
            }
          }
        },
      ),
    );
  }
}

/**
if (state is SelectOrganisationLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: primaryBlue,
                ),
              );
            } else {
              List<List<String?>> orgUnitLists =
                  (state as SelectOrganisationLoaded).organisationData;
              if (min(MediaQuery.of(context).size.width,
                      MediaQuery.of(context).size.height) >
                  600) {
                return TabletBodySelectOrganisation(
                  proceed: () {},
                  orgIdList: orgUnitLists[1],
                  orgNameList: orgUnitLists[0],
                  groupValue: _groupValue,
                  onChange: (index) {
                    print(index);
                    setState(() {
                      _groupValue = index!;
                    });
                  },
                );
              } else {
                return MobileBodySelectOrganisation(
                  proceed: () {},
                  orgIdList: orgUnitLists[1],
                  orgNameList: orgUnitLists[0],
                  groupValue: _groupValue,
                  onChange: (index) {
                    print(index);
                    setState(() {
                      _groupValue = index!;
                    });
                  },
                );
              }
            }
 */
/**
Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Text(
                "Choose Organisation",
                style: TextStyle(
                  fontFamily: "Open Sans",
                  fontSize: 22,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: BlocBuilder<SelectOrganisationBloc, SelectOrganisationStates>(
                builder: (context, state) {
                  return ListView.builder(
                    itemBuilder: (context, index) => SelectOrganisationListItem(),
                    itemCount: orgUnitList.length,
                  );
                },
              ),
            ),
            Container(
              width: double.infinity,
              height: 55,
              margin: EdgeInsets.symmetric(
                horizontal: 29,
              ),
              alignment: Alignment.center,
              child: Text(
                "Proceed",
                style: TextStyle(
                  fontFamily: "Open Sans",
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              ),
              decoration: BoxDecoration(
                color: Color(0xff3080ED),
                borderRadius: BorderRadius.circular(
                  10,
                ),
              ),
            ),
            SizedBox(
              height: 10,//mp:30,ml:10
            ),
          ],
        ),
 */

/*
SelectOrganisationLayout(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Text(
                "Choose Organisation",
                style: TextStyle(
                  fontFamily: "Open Sans",
                  fontSize: 22,
                ),
              ),
            ),
            Expanded(
              child: ListView(),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              height: 55,
              margin: EdgeInsets.symmetric(
                horizontal: 29,
              ),
              alignment: Alignment.center,
              child: Text(
                "Proceed",
                style: TextStyle(
                  fontFamily: "Open Sans",
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              ),
              decoration: BoxDecoration(
                color: Color(0xff3080ED),
                borderRadius: BorderRadius.circular(
                  10,
                ),
              ),
            ),
            SizedBox(
              height: 10, //mp:30,ml:10
            ),
          ],
        ),
 */