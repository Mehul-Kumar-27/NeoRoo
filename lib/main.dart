import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:neoroo_app/bloc/ToDo_bloc/to_do_bloc.dart';
import 'package:neoroo_app/bloc/add_baby_bloc/add_baby_bloc.dart';
import 'package:neoroo_app/bloc/add_user_bloc/add_user_bloc.dart';
import 'package:neoroo_app/bloc/all_babies_bloc/all_babies_bloc.dart';
import 'package:neoroo_app/bloc/authentication/local_auth_login_bloc/local_authentication_bloc.dart';
import 'package:neoroo_app/bloc/authentication/login_bloc/login_bloc.dart';
import 'package:neoroo_app/bloc/authentication/select_organisation_bloc/select_organisation_bloc.dart';
import 'package:neoroo_app/bloc/baby_details_family_member/baby_details_family_member_bloc.dart';
import 'package:neoroo_app/bloc/bluetooth_bloc/ble_bloc.dart';
import 'package:neoroo_app/bloc/fetch_baby_bloc/fetch_baby_bloc.dart';
import 'package:neoroo_app/bloc/learning_resources_bloc/learning_resources_bloc.dart';
import 'package:neoroo_app/bloc/message_bloc/message_bloc.dart';
import 'package:neoroo_app/bloc/more_options/more_options_bloc.dart';
import 'package:neoroo_app/bloc/on_call_doctors/on_call_doctors_bloc.dart';
import 'package:neoroo_app/bloc/server_bloc/server_bloc.dart';
import 'package:neoroo_app/bloc/update_baby_bloc/update_baby_bloc.dart';
import 'package:neoroo_app/models/baby_details_caregiver.dart';
import 'package:neoroo_app/models/baby_details_family_member.dart';
import 'package:neoroo_app/models/profile.dart';
import 'package:neoroo_app/models/tracked_attributes.dart';
import 'package:neoroo_app/network/add_update_baby_client.dart';
import 'package:neoroo_app/network/add_user_client.dart';
import 'package:neoroo_app/network/authentication_client.dart';
import 'package:neoroo_app/network/baby_details_client.dart';
import 'package:neoroo_app/network/fetch_baby_client.dart';
import 'package:neoroo_app/network/fetch_from_eceb.dart';
import 'package:neoroo_app/network/learning_resources_client.dart';
import 'package:neoroo_app/network/message_network_client.dart';
import 'package:neoroo_app/network/on_call_doctors_client.dart';
import 'package:neoroo_app/network/server_client.dart';
import 'package:neoroo_app/network/todo_client.dart';
import 'package:neoroo_app/repository/add_update_baby_repository.dart';
import 'package:neoroo_app/repository/add_user_repository.dart';
import 'package:neoroo_app/repository/authentication_repository.dart';
import 'package:neoroo_app/repository/baby_details_repository.dart';
import 'package:neoroo_app/repository/eceb_to_neoroo_repository.dart';
import 'package:neoroo_app/repository/fetch_baby_repository.dart';
import 'package:neoroo_app/repository/hive_storage_repository.dart';
import 'package:neoroo_app/repository/learning_resources_repository.dart';
import 'package:neoroo_app/repository/message_repository.dart';
import 'package:neoroo_app/repository/more_options_repository.dart';
import 'package:neoroo_app/repository/on_call_doctors_repository.dart';
import 'package:neoroo_app/repository/secure_storage_repository.dart';
import 'package:neoroo_app/repository/server_repository.dart';
import 'package:neoroo_app/repository/todo_repository.dart';
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
  Hive.registerAdapter(TrackedAttributesAdapter());
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
          BlocProvider<FetchBabyBloc>(
            create: (context) => FetchBabyBloc(
                context.read<FetchBabyRepository>(),
                context.read<HiveStorageRepository>()),
          ),
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
          BlocProvider<OnCallDoctorsBloc>(
            create: (context) => OnCallDoctorsBloc(
              context.read<OnCallDoctorsRepository>(),
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
                context.read<ECEBtoNeoRooRepository>()),
          ),
          BlocProvider<BluetoothControllerBloc>(
            create: (context) => BluetoothControllerBloc(),
          ),
          BlocProvider<UpdateBabyBloc>(
            create: (context) => UpdateBabyBloc(
              context.read<HiveStorageRepository>(),
              context.read<AddUpdateBabyRepository>(),
            ),
          ),
          BlocProvider<LearningResourcesBloc>(
            create: (context) => LearningResourcesBloc(
              context.read<HiveStorageRepository>(),
              context.read<LearningResourcesRepository>(),
            ),
          ),
          BlocProvider<ServerBloc>(
              create: (context) => ServerBloc(
                    context.read<ServerRepository>(),
                    context.read<HiveStorageRepository>(),
                  )),
          BlocProvider<ToDoBloc>(
              create: (context) => ToDoBloc(
                    context.read<ToDoRepository>(),
                  )),
          BlocProvider<MessageBloc>(
              create: (context) => MessageBloc(
                  messageRepository: MessageRepository(
                      messageNetwrokApiClient: MessageNetwrokApiClient(),
                      hiveStorageRepository:
                          context.read<HiveStorageRepository>()))),
          BlocProvider<AddUserBloc>(
              create: (context) =>
                  AddUserBloc(context.read<AddUserRepository>(),
                  context.read<AddUpdateBabyRepository>()))
        ],
      ),
      providers: [
        RepositoryProvider<HiveStorageRepository>(
          create: (context) => HiveStorageRepository(SecureStorageRepository),
        ),
        RepositoryProvider<OnCallDoctorsRepository>(
          create: (context) => OnCallDoctorsRepository(
            context.read<HiveStorageRepository>(),
            OnCallDoctorsClient(),
            navigatorKey.currentContext!,
          ),
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
        RepositoryProvider<ECEBtoNeoRooRepository>(
          create: (context) => ECEBtoNeoRooRepository(
              context.read<HiveStorageRepository>(),
              FetchBabyFromECEBClient(),
              context),
        ),
        RepositoryProvider<FetchBabyRepository>(
          create: (context) => FetchBabyRepository(
            fetchBabyClient: FetchBabyClient(),
            hiveStorageRepository: context.read<HiveStorageRepository>(),
          ),
        ),
        RepositoryProvider(
          create: (context) => LearningResourcesRepository(
            LearningResourcesClient(),
            navigatorKey.currentContext!,
            context.read<HiveStorageRepository>(),
          ),
        ),
        RepositoryProvider<ServerRepository>(
            create: (context) => ServerRepository(
                  context.read<HiveStorageRepository>(),
                  ServerClient(),
                  navigatorKey.currentContext!,
                )),
        RepositoryProvider<ToDoRepository>(
            create: (context) => ToDoRepository(
                hiveStorageRepository: context.read<HiveStorageRepository>(),
                addUpdateDeleteToDoClient: AddUpdateDeleteToDoClient(),
                context: context)),
        RepositoryProvider<MessageRepository>(
            create: (context) => MessageRepository(
                messageNetwrokApiClient: MessageNetwrokApiClient(),
                hiveStorageRepository: context.read<HiveStorageRepository>())),
        RepositoryProvider<AddUserRepository>(
            create: (context) => AddUserRepository(
                addUserCliet: AddUserCliet(),
                hiveStorageRepository: context.read<HiveStorageRepository>())),
      ],
    );
  }
}
