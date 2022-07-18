import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoroo_app/bloc/baby_details_family_member/baby_details_family_member_bloc.dart';
import 'package:neoroo_app/bloc/baby_details_family_member/baby_details_family_member_events.dart';
import 'package:neoroo_app/bloc/baby_details_family_member/baby_details_family_member_states.dart';
import 'package:neoroo_app/screens/baby_details_family_member/components/baby_details_family_member_avatar.dart';
import 'package:neoroo_app/screens/baby_details_family_member/components/baby_details_family_member_birth_description.dart';
import 'package:neoroo_app/screens/baby_details_family_member/components/baby_details_family_member_input.dart';
import 'package:neoroo_app/screens/baby_details_family_member/components/baby_details_family_member_title.dart';
import 'package:neoroo_app/utils/constants.dart';
import 'package:neoroo_app/utils/empty_baby_page.dart';
import 'package:neoroo_app/utils/error_page.dart';
import 'package:neoroo_app/utils/vertical_space.dart';

class BabyDetailsFamilyMember extends StatefulWidget {
  const BabyDetailsFamilyMember({Key? key}) : super(key: key);

  @override
  State<BabyDetailsFamilyMember> createState() =>
      _BabyDetailsFamilyMemberState();
}

class _BabyDetailsFamilyMemberState extends State<BabyDetailsFamilyMember> {
  @override
  void initState() {
    initialise();
    super.initState();
  }

  void initialise() {
    BlocProvider.of<BabyDetailsFamilyMemberBloc>(context).add(
      LoadBabyDetailsFamilyMemberEvents(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: BabyDetailsFamilyMemberTitle(),
        body: BlocBuilder<BabyDetailsFamilyMemberBloc,
            BabyDetailFamilyMemberStates>(
          builder: (context, state) {
            if (state is BabyDetailsFamilyMemberFetchError) {
              return ErrorPage();
            }
            if (state is BabyDetailsFamilyMemberLoaded) {
              if (state.babyDetailsFamilyMember == null) {
                return EmptyBabyPage();
              }
              return ListView(
                children: [
                  VerticalSpace(
                    height: 30,
                  ),
                  BabyDetailsAvatar(
                    imageURL: state.baseURL +
                        "/api/fileResources/" +
                        state.babyDetailsFamilyMember!.avatarId! +
                        "/data",
                    auth: state.auth,
                  ),
                  VerticalSpace(
                    height: 20,
                  ),
                  BabyDetailsFamilyMemberMothersName(
                    mothersName: state.babyDetailsFamilyMember!.motherName,
                  ),
                  VerticalSpace(
                    height: 15,
                  ),
                  BabyDetailsFamilyMemberBirthDate(
                    birthDate: state.babyDetailsFamilyMember!.birthDate,
                  ),
                  VerticalSpace(
                    height: 15,
                  ),
                  BabyDetailsFamilyMemberBirthTime(
                    birthTime: state.babyDetailsFamilyMember!.birthTime,
                  ),
                  VerticalSpace(
                    height: 15,
                  ),
                  BabyDetailsFamilyMemberBirthWeight(
                    weight: state.babyDetailsFamilyMember!.weight,
                  ),
                  VerticalSpace(
                    height: 15,
                  ),
                  BabyDetailsFamilyMemberBodyLength(
                    bodyLength: state.babyDetailsFamilyMember!.bodyLength,
                  ),
                  VerticalSpace(
                    height: 15,
                  ),
                  BabyDetailsFamilyMemberHeadCircumference(
                    headCircumference:
                        state.babyDetailsFamilyMember!.headCircumference,
                  ),
                  VerticalSpace(
                    height: 15,
                  ),
                  BabyDetailsFamilyMemberNeedResuscitation(
                    needsResuscitation:
                        state.babyDetailsFamilyMember!.needResuscitation,
                  ),
                  VerticalSpace(
                    height: 20,
                  ),
                  BabyDetailsFamilyMemberParentGroup(
                    parentGroup:
                        state.babyDetailsFamilyMember!.familyMemberGroup,
                  ),
                  VerticalSpace(
                    height: 20,
                  ),
                  BabyDetailsFamilyMemberCaregiverGroup(
                    caregiverGroup:
                        state.babyDetailsFamilyMember!.caregiverGroup,
                  ),
                  VerticalSpace(
                    height: 20,
                  ),
                  BabyDetailsFamilyMemberBirthDescription(
                    description: state.babyDetailsFamilyMember!.birthNotes,
                  ),
                  VerticalSpace(
                    height: 20,
                  ),
                ],
              );
            }
            if (state is BabyDetailsFamilyMemberLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: primaryBlue,
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
