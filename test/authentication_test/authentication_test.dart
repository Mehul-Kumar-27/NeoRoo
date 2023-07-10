import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:neoroo_app/bloc/authentication/login_bloc/login_bloc.dart';
import 'package:neoroo_app/bloc/authentication/login_bloc/login_bloc_events.dart';
import 'package:neoroo_app/bloc/authentication/login_bloc/login_bloc_states.dart';
import 'package:neoroo_app/exceptions/custom_exception.dart';
import 'package:neoroo_app/network/authentication_client.dart';
import 'package:neoroo_app/repository/authentication_repository.dart';
import 'package:neoroo_app/repository/hive_storage_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:neoroo_app/utils/dhis2_config.dart';
import 'authentication_test.mocks.dart' as mocks;
import 'package:http/http.dart' as http;

import 'authentication_test.mocks.dart';

@GenerateMocks(
    [AuthenticationClient, HiveStorageRepository, AuthenticationRepository])
void main() {
  late mocks.MockHiveStorageRepository hiveStorageRepository;
  late mocks.MockAuthenticationClient authenticationClient;
  late AuthenticationRepository authenticationRepository;

  setUp(() {
    authenticationRepository = mocks.MockAuthenticationRepository();
    hiveStorageRepository = mocks.MockHiveStorageRepository();
    authenticationClient = mocks.MockAuthenticationClient();
  });
  //testing socket exception
  testWidgets(
    'Testing socket exceptions',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: Container(),
          ),
          localizationsDelegates: [
            AppLocalizations.delegate,
          ],
        ),
      );
      BuildContext context = tester.element(find.byType(Container));
      authenticationRepository = AuthenticationRepository(
        hiveStorageRepository: hiveStorageRepository,
        authenticationClient: authenticationClient,
        context: context,
      );
      when(mocks.MockAuthenticationClient().loginUser(
              'testuser', 'Admin@123', 'https://bmgfdev.soic.iupui.edu'))
          .thenThrow(SocketException('An error occurred!'));
      var r = await authenticationRepository.loginUser(
          'testuser', 'Admin@123', 'https://bmgfdev.soic.iupui.edu');
      expect(r as FetchDataException, isA<FetchDataException>());
    },
  );
  //testing correct password
  testWidgets('correct credentials test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: Container(),
        ),
        localizationsDelegates: [
          AppLocalizations.delegate,
        ],
      ),
    );

    BuildContext context = tester.element(find.byType(Container));

    when(authenticationClient.loginUser(any, any, any)).thenAnswer(
      (x) => Future<http.Response>.value(
        http.Response(
          jsonEncode(
            {
              'organisationUnits': [
                {'id': 'x'},
                {'id': 'y'}
              ],
              'name': 'dev',
              'id': '10',
              'userGroups': [
                {
                  'id': caregiverGroup,
                }
              ],
              'userCredentials': {
                'userRoles': [
                  {
                    'id': 'Superuser',
                  },
                ]
              }
            },
          ),
          200,
        ),
      ),
    );

    when(authenticationClient.getUserRoleName(any, any, any, any)).thenAnswer(
      (x) => Future<String>.value('UserRoleName'),
    );

    when(hiveStorageRepository.saveCredentials(any, any, any, any, any))
        .thenAnswer((realInvocation) async => null);

    when(hiveStorageRepository.saveOrganisationURL(any))
        .thenAnswer((realInvocation) async => null);

    when(hiveStorageRepository.saveOrganisations(any))
        .thenAnswer((realInvocation) async => null);

    when(hiveStorageRepository.saveUserProfile(any))
        .thenAnswer((realInvocation) async => null);

    when(hiveStorageRepository.setIsCareGiver(any))
        .thenAnswer((realInvocation) async => null);

    when(hiveStorageRepository.setUserGroups(any)).thenAnswer(
      (realInvocation) async => null,
    );

    authenticationRepository = AuthenticationRepository(
      hiveStorageRepository: hiveStorageRepository,
      authenticationClient: authenticationClient,
      context: context,
    );

    var r = await authenticationRepository.loginUser(
      'testuser',
      'Admin@123',
      'https://bmgfdev.soic.iupui.edu',
    );

    expect(r as Map<String, dynamic>, isA<Map<String, dynamic>>());
  });
  //testing incorrect password
  testWidgets(
    'incorrect credentials entered',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: Container(),
          ),
          localizationsDelegates: [
            AppLocalizations.delegate,
          ],
        ),
      );
      BuildContext context = tester.element(find.byType(Container));
      when(authenticationClient.loginUser(any, any, any)).thenAnswer(
        (x) => Future<http.Response>.value(
          http.Response(
            jsonEncode(
              {},
            ),
            401,
          ),
        ),
      );
      authenticationRepository = AuthenticationRepository(
        hiveStorageRepository: hiveStorageRepository,
        authenticationClient: authenticationClient,
        context: context,
      );
      var r = await authenticationRepository.loginUser(
        'testuser',
        'Admin@123',
        'https://bmgfdev.soic.iupui.edu',
      );
      expect((r as CustomException).statusCode, 401);
      expect((r).message, AppLocalizations.of(context).unauthorized);
    },
  );

  testWidgets(
    'Testing when input is empty',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: Container(),
          ),
          localizationsDelegates: [
            AppLocalizations.delegate,
          ],
        ),
      );
      BuildContext context = tester.element(find.byType(Container));
      authenticationRepository = AuthenticationRepository(
        hiveStorageRepository: hiveStorageRepository,
        authenticationClient: authenticationClient,
        context: context,
      );
      var r = await authenticationRepository.loginUser(
        '',
        'Admin@123',
        'https://bmgfdev.soic.iupui.edu',
      );
      expect((r as CustomException).statusCode, null);
    },
  );
  blocTest<LoginBloc, LoginState>(
    'Initial state of bloc',
    build: () {
      mocks.MockAuthenticationRepository authenticationRepository =
          mocks.MockAuthenticationRepository();
      return LoginBloc(authenticationRepository, hiveStorageRepository);
    },
    expect: () => [],
  );
  blocTest<LoginBloc, LoginState>(
    'Socket exception on no internet',
    build: () {
      final authenticationRepository = MockAuthenticationRepository();
      final hiveStorageRepository = MockHiveStorageRepository();

      when(authenticationRepository.isLocalAuthSupported())
          .thenAnswer((_) => Future<Map<String, dynamic>>.value({
                "status": false,
                "message": "No internet connection",
              }));

      final loginBloc =
          LoginBloc(authenticationRepository, hiveStorageRepository);

      return loginBloc;
    },
    act: (LoginBloc bloc) {
      bloc.add(
          LoginEvent("https://bmgfdev.soic.iupui.edu", "working", "testuser"));
    },
    expect: () => [
      LoginLoading(),
      LocalAuthSupportError("No internet connection"),
    ],
  );

  blocTest<LoginBloc, LoginState>(
    'Bloc test for correct credentials',
    build: () {
      final authenticationRepository = MockAuthenticationRepository();
      final hiveStorageRepository = MockHiveStorageRepository();

      when(authenticationRepository.isLocalAuthSupported()).thenAnswer(
        (x) => Future<Map<String, dynamic>>.value({
          "status": true,
          "message": "Local auth is supported",
        }),
      );
      when(authenticationRepository.loginUser(any, any, any)).thenAnswer(
        (x) => Future<Map<String, dynamic>>.value({
          "orgUnits": ["x", "y", "z"],
        }),
      );

      return LoginBloc(authenticationRepository, hiveStorageRepository);
    },
    act: (LoginBloc bloc) {
      bloc.add(
          LoginEvent("https://bmgfdev.soic.iupui.edu", "working", "testuser"));
    },
    expect: () => [
      LoginLoading(),
      LoginLoaded(orgUnits: ["x", "y", "z"]),
    ],
  );

  blocTest<LoginBloc, LoginState>(
    'Bloc test for incorrect credentials',
    build: () {
      mocks.MockAuthenticationRepository authenticationRepository =
          mocks.MockAuthenticationRepository();
      when(authenticationRepository.isLocalAuthSupported()).thenAnswer(
        (x) => Future<Map<String, dynamic>>.value({
          "status": true,
          "message": "Local auth is supported",
        }),
      );
      when(authenticationRepository.loginUser(any, any, any)).thenAnswer(
        (x) => Future<UnauthorisedException>.value(
          UnauthorisedException("Incorrect credentials", 401),
        ),
      );
      return LoginBloc(authenticationRepository, hiveStorageRepository);
    },
    act: (LoginBloc bloc) {
      bloc.add(
        LoginEvent("https://bmgfdev.soic.iupui.edu", "working", "testuser"),
      );
    },
    expect: () => [
      LoginLoading(),
      LoginGeneralError(
        CustomException(
          "Incorrect credentials",
          401,
        ),
      ),
    ],
  );

  blocTest<LoginBloc, LoginState>(
    'Testing when input is empty',
    build: () {
      mocks.MockAuthenticationRepository authenticationRepository =
          mocks.MockAuthenticationRepository();
          when(authenticationRepository.isLocalAuthSupported()).thenAnswer(
        (x) => Future<Map<String, dynamic>>.value({
          "status": true,
          "message": "Local auth is supported",
        }),
      );
      when(authenticationRepository.loginUser(any, any, any)).thenAnswer(
        (x) => Future<CustomException>.value(
          CustomException("Please fill in all fields", null),
        ),
      );
      return LoginBloc(authenticationRepository, hiveStorageRepository);
    },
    act: (LoginBloc bloc) {
      bloc.add(
        LoginEvent("", "working", "testuser"),
      );
    },
    expect: () => [
      LoginLoading(),
      LoginGeneralError(
        CustomException(
          "Please fill in all fields",
          null,
        ),
      ),
    ],
  );
}
