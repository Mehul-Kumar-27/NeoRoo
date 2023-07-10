import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoroo_app/bloc/more_options/more_options_bloc.dart';
import 'package:neoroo_app/bloc/more_options/more_options_events.dart';
import 'package:neoroo_app/bloc/more_options/more_options_states.dart';
import 'package:neoroo_app/screens/all_babies_caregiver.dart/all_babies_caregiver.dart';
import 'package:neoroo_app/screens/authentication/login/login.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:neoroo_app/screens/baby_details_family_member/baby_details_family_member.dart';
import 'package:neoroo_app/screens/learning_resources/learning_resources.dart';
import 'package:neoroo_app/screens/more_options/components/change_avatar.dart';
import 'package:neoroo_app/screens/more_options/components/clear_local_cache.dart';
import 'package:neoroo_app/screens/more_options/components/general_list_item.dart';
import 'package:neoroo_app/screens/more_options/components/data_sync.dart';
import 'package:neoroo_app/screens/more_options/components/logout.dart';
import 'package:neoroo_app/screens/more_options/components/manage_baby.dart';
import 'package:neoroo_app/screens/more_options/components/more_options_title.dart';
import 'package:neoroo_app/screens/more_options/components/notifications.dart';
import 'package:neoroo_app/screens/more_options/components/org_name.dart';
import 'package:neoroo_app/screens/more_options/components/switch_organization.dart';
import 'package:neoroo_app/screens/more_options/components/user_info.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class MoreOptions extends StatefulWidget {
  const MoreOptions({Key? key}) : super(key: key);

  @override
  State<MoreOptions> createState() => _MoreOptionsState();
}

class _MoreOptionsState extends State<MoreOptions> {
  void initialise() {
    BlocProvider.of<MoreOptionsBloc>(context).add(
      LoadMoreOptionsEvent(),
    );
  }

  void takeToLoginScreen() {
    Navigator.of(
      context,
      rootNavigator: true,
    ).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
      (route) => false,
    );
  }

  @override
  void initState() {
    initialise();
    super.initState();
  }

  void takeToBabyDetailsFamilyMember() {
    pushNewScreen(
      context,
      screen: BabyDetailsFamilyMember(),
    );
  }

  void takeToBabyDetailsCaregiver() {
    pushNewScreen(
      context,
      screen: AllBabiesList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MoreOptionsTitle(),
        body: BlocConsumer<MoreOptionsBloc, MoreOptionsStates>(
          listener: (context, state) {
            if (state is UserLoggedOut) {
              takeToLoginScreen();
            }
          },
          builder: (context, state) {
            if (state is FamilyMemberUser) {
              return Column(
                children: [
                  UserInfo(
                    name: state.name,
                    avatarId: state.avatarId,
                    id: state.userId,
                    baseURL: state.baseURL,
                    authHeaderValue: state.authHeaderValue,
                  ),
                  OrganisationName(
                    orgId: state.orgId,
                    orgName: state.orgName.toString(),
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        ManageBaby(
                          isCaregiver: false,
                          onTap: takeToBabyDetailsFamilyMember,
                        ),
                        GeneralListItem(
                          icon: Icons.cast_for_education,
                          subtitle: AppLocalizations.of(context)
                              .educationRelatedToChildCare,
                          title: AppLocalizations.of(context).trainingModules,
                          onTap: () {
                            pushNewScreen(
                              context,
                              screen: LearningResourcesPage(),
                            );
                          },
                        ),
                        GeneralListItem(
                          icon: Icons.bookmark,
                          subtitle: AppLocalizations.of(context).saveResources,
                          title: AppLocalizations.of(context).bookmarkResources,
                          onTap: () {},
                        ),
                        NotificationsItem(),
                        DataSync(),
                        ChangeAvatar(),
                        ClearLocalCache(),
                        SwitchOrganization(),
                        GeneralListItem(
                          icon: Icons.support_agent,
                          subtitle: null,
                          title: AppLocalizations.of(context).helpAndSupport,
                          onTap: () {},
                        ),
                        LogOutButton(
                          onTap: () {
                            BlocProvider.of<MoreOptionsBloc>(context).add(
                              LogoutEvent(),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            if (state is CaregiverUser) {
              return Column(
                children: [
                  UserInfo(
                    name: state.name,
                    avatarId: state.avatarId,
                    id: state.userId,
                    baseURL: state.baseURL,
                    authHeaderValue: state.authHeaderValue,
                  ),
                  OrganisationName(
                    orgId: state.orgId,
                    orgName: state.orgName.toString(),
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        ManageBaby(
                          isCaregiver: true,
                          onTap: takeToBabyDetailsCaregiver,
                        ),
                        GeneralListItem(
                          icon: Icons.cast_for_education,
                          subtitle: AppLocalizations.of(context)
                              .educationRelatedToChildCare,
                          title: AppLocalizations.of(context).trainingModules,
                          onTap: () {
                            pushNewScreen(
                              context,
                              screen: LearningResourcesPage(),
                            );
                          },
                        ),
                        GeneralListItem(
                          icon: Icons.bookmark,
                          subtitle: AppLocalizations.of(context).saveResources,
                          title: AppLocalizations.of(context).bookmarkResources,
                          onTap: () {},
                        ),
                        NotificationsItem(),
                        DataSync(),
                        ChangeAvatar(),
                        ClearLocalCache(),
                        SwitchOrganization(),
                        GeneralListItem(
                          icon: Icons.support_agent,
                          subtitle: null,
                          title: AppLocalizations.of(context).helpAndSupport,
                          onTap: () {},
                        ),
                        LogOutButton(
                          onTap: () {
                            BlocProvider.of<MoreOptionsBloc>(context).add(
                              LogoutEvent(),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
