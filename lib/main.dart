import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:neoroo_app/bloc/add_baby_bloc/add_baby_bloc.dart';
import 'package:neoroo_app/bloc/all_babies_bloc/all_babies_bloc.dart';
import 'package:neoroo_app/bloc/authentication/local_auth_login_bloc/local_authentication_bloc.dart';
import 'package:neoroo_app/bloc/authentication/login_bloc/login_bloc.dart';
import 'package:neoroo_app/bloc/authentication/select_organisation_bloc/select_organisation_bloc.dart';
import 'package:neoroo_app/bloc/baby_details_family_member/baby_details_family_member_bloc.dart';
import 'package:neoroo_app/bloc/more_options/more_options_bloc.dart';
import 'package:neoroo_app/bloc/update_baby_bloc/update_baby_bloc.dart';
import 'package:neoroo_app/models/baby_details_caregiver.dart';
import 'package:neoroo_app/models/baby_details_family_member.dart';
import 'package:neoroo_app/models/profile.dart';
import 'package:neoroo_app/network/add_update_baby_client.dart';
import 'package:neoroo_app/network/authentication_client.dart';
import 'package:neoroo_app/network/baby_details_client.dart';
import 'package:neoroo_app/repository/add_update_baby_repository.dart';
import 'package:neoroo_app/repository/authentication_repository.dart';
import 'package:neoroo_app/repository/baby_details_repository.dart';
import 'package:neoroo_app/repository/hive_storage_repository.dart';
import 'package:neoroo_app/repository/more_options_repository.dart';
import 'package:neoroo_app/screens/authentication/login/login.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:neoroo_app/screens/main_screen/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await registerHive();
  runApp(MyApp());
}

Future<void> registerHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ProfileAdapter());
  Hive.registerAdapter(BabyDetailsFamilyMemberAdapter());
  Hive.registerAdapter(BabyDetailsCaregiverAdapter());
  await Hive.openBox("users");
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggedIn = false;
  final navigatorKey = GlobalKey<NavigatorState>();
  Future<void> checkIfUserLoggedIn() async {
    if (await HiveStorageRepository.checkUserLoggedIn()) {
      setState(() {
        isLoggedIn = true;
      });
    }
  }

  @override
  void initState() {
    checkIfUserLoggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      child: MultiBlocProvider(
        child: MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          title: "NeoRoo",
          home: isLoggedIn ? MainScreen() : LoginPage(),
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        ),
        providers: [
          BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(
              context.read<AuthenticationRepository>(),
              context.read<HiveStorageRepository>(),
            ),
          ),
          BlocProvider<SelectOrganisationBloc>(
            create: (context) => SelectOrganisationBloc(
              context.read<AuthenticationRepository>(),
              context.read<HiveStorageRepository>(),
            ),
          ),
          BlocProvider<LocalAuthBloc>(
            create: (context) => LocalAuthBloc(
              context.read<AuthenticationRepository>(),
              context.read<HiveStorageRepository>(),
            ),
          ),
          BlocProvider<MoreOptionsBloc>(
            create: (context) => MoreOptionsBloc(
              context.read<HiveStorageRepository>(),
            ),
          ),
          BlocProvider<BabyDetailsFamilyMemberBloc>(
            create: (context) => BabyDetailsFamilyMemberBloc(
              context.read<BabyDetailsRepository>(),
              context.read<HiveStorageRepository>(),
            ),
          ),
          BlocProvider<BabyDetailsCaregiverBloc>(
            create: (context) => BabyDetailsCaregiverBloc(
              context.read<BabyDetailsRepository>(),
              context.read<HiveStorageRepository>(),
            ),
          ),
          BlocProvider<AddBabyBloc>(
            create: (context) => AddBabyBloc(
              context.read<HiveStorageRepository>(),
              context.read<AddUpdateBabyRepository>(),
            ),
          ),
          BlocProvider<UpdateBabyBloc>(
            create: (context) => UpdateBabyBloc(
              context.read<HiveStorageRepository>(),
            ),
          ),
        ],
      ),
      providers: [
        RepositoryProvider<HiveStorageRepository>(
          create: (context) => HiveStorageRepository(),
        ),
        RepositoryProvider<AuthenticationRepository>(
          create: (context) => AuthenticationRepository(
            hiveStorageRepository: context.read<HiveStorageRepository>(),
            authenticationClient: AuthenticationClient(),
            context: navigatorKey.currentContext!,
          ),
        ),
        RepositoryProvider<MoreOptionsRepository>(
          create: (context) => MoreOptionsRepository(
            hiveStorageRepository: context.read<HiveStorageRepository>(),
          ),
        ),
        RepositoryProvider<BabyDetailsRepository>(
          create: (context) => BabyDetailsRepository(
            babyDetailsClient: BabyDetailsClient(),
            hiveStorageRepository: context.read<HiveStorageRepository>(),
          ),
        ),
        RepositoryProvider<AddUpdateBabyRepository>(
          create: (context) => AddUpdateBabyRepository(
            babyAddUpdateClient: BabyAddUpdateClient(),
            hiveStorageRepository: context.read<HiveStorageRepository>(),
            context: navigatorKey.currentContext!,
          ),
        ),
      ],
    );
  }
}
