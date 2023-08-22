import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neoroo_app/screens/add_baby/add_baby.dart';
import 'package:neoroo_app/screens/home/home.dart';

import 'package:neoroo_app/screens/messaging/messaging_home.dart';
import 'package:neoroo_app/screens/more_options/more_options.dart';
import 'package:neoroo_app/screens/scan_qr_code/scan_qr_code.dart';
import 'package:neoroo_app/screens/skin_to_skin_time/skin_to_skin_time.dart';
import 'package:neoroo_app/screens/vitals/vitals.dart';
import 'package:neoroo_app/utils/constants.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      screens: [
        HomeScreen(),
        SkinToSkinTimeScreen(),
        VitalsPage(),
        ChatHomePage(),
        MoreOptions(),
      ],
      items: [
        PersistentBottomNavBarItem(
          icon: Icon(
            Icons.home,
          ),
          title: AppLocalizations.of(context).home,
          activeColorPrimary: primaryBlue,
          inactiveColorPrimary: outlineGrey,
        ),
        PersistentBottomNavBarItem(
          icon: FaIcon(
            FontAwesomeIcons.baby,
          ),
          title: AppLocalizations.of(context).sts,
          activeColorPrimary: primaryBlue,
          inactiveColorPrimary: outlineGrey,
        ),
        PersistentBottomNavBarItem(
          icon: FaIcon(
            FontAwesomeIcons.heartPulse,
          ),
          title: AppLocalizations.of(context).vitals,
          activeColorPrimary: primaryBlue,
          inactiveColorPrimary: outlineGrey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(
            Icons.chat,
          ),
          title: "Messaging",
          activeColorPrimary: purpleTheme,
          inactiveColorPrimary: outlineGrey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(
            Icons.menu,
          ),
          title: AppLocalizations.of(context).more,
          activeColorPrimary: primaryBlue,
          inactiveColorPrimary: outlineGrey,
        ),
      ],
      confineInSafeArea: true,
      controller: _controller,
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      itemAnimationProperties: ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      hideNavigationBarWhenKeyboardShows: true,
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      navBarStyle: NavBarStyle.simple,
    );
  }
}
