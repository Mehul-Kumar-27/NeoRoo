import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoroo_app/bloc/more_options/more_options_bloc.dart';
import 'package:neoroo_app/bloc/more_options/more_options_events.dart';
import 'package:neoroo_app/bloc/more_options/more_options_states.dart';
import 'package:neoroo_app/screens/authentication/login/login.dart';
import 'package:neoroo_app/screens/baby_details/baby_details.dart';
import 'package:neoroo_app/screens/more_options/components/more_options_item.dart';
import 'package:neoroo_app/screens/more_options/components/more_options_layout.dart';
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

  void takeToBabyDetails() {
    pushNewScreen(
      context,
      screen: BabyDetails(),
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
      child: Scaffold(
        body: BlocConsumer<MoreOptionsBloc, MoreOptionsStates>(
          listener: (context, state) {
            if (state is UserLoggedOut) {
              takeToLoginScreen();
            }
          },
          builder: (context, state) {
            if (!(state is InitialMoreOptionsState)) {
              return MoreOptionsLayout(
                children: [
                  MoreOptionsItem(
                    onPressed: () {
                      takeToBabyDetails();
                    },
                    title: state is CaregiverUser
                        ? AppLocalizations.of(context).addUpdateDetails
                        : AppLocalizations.of(context).babyBirthDetails,
                  ),
                  MoreOptionsItem(
                    onPressed: () {},
                    title: AppLocalizations.of(context).trainingModules,
                  ),
                  MoreOptionsItem(
                    onPressed: () {},
                    title: AppLocalizations.of(context).bookmarkResources,
                  ),
                  MoreOptionsItem(
                    onPressed: () {},
                    title: AppLocalizations.of(context).dataSync,
                  ),
                  MoreOptionsItem(
                    onPressed: () {},
                    title: AppLocalizations.of(context).helpAndSupport,
                  ),
                  MoreOptionsItem(
                    onPressed: () {},
                    title: AppLocalizations.of(context).clearLocalCache,
                  ),
                  MoreOptionsItem(
                    onPressed: () {
                      BlocProvider.of<MoreOptionsBloc>(context).add(
                        LogoutEvent(),
                      );
                    },
                    title: AppLocalizations.of(context).signOut,
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
