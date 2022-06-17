import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:neoroo_app/bloc/authentication/local_auth_login_bloc/local_authentication_bloc.dart';
import 'package:neoroo_app/bloc/authentication/login_bloc/login_bloc.dart';
import 'package:neoroo_app/bloc/authentication/select_organisation_bloc/select_organisation_bloc.dart';
import 'package:neoroo_app/models/profile.dart';
import 'package:neoroo_app/network/authentication_client.dart';
import 'package:neoroo_app/repository/authentication_repository.dart';
import 'package:neoroo_app/repository/hive_storage_repository.dart';
import 'package:neoroo_app/screens/authentication/login/login.dart';
import 'package:neoroo_app/screens/temp_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await registerHive();
  runApp(MyApp());
}

Future<void> registerHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ProfileAdapter());
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
          home: isLoggedIn ? TempScreen() : LoginPage(),
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
          )
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
      ],
    );
  }
}
