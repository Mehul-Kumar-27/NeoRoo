import 'package:bloc/bloc.dart';
import 'dart:async';
import 'package:neoroo_app/bloc/authentication/login_bloc/login_bloc_events.dart';
import 'package:neoroo_app/bloc/authentication/login_bloc/login_bloc_states.dart';
import 'package:neoroo_app/repository/authentication_repository.dart';
import 'package:neoroo_app/repository/hive_storage_repository.dart';

class LoginBloc extends Bloc<LoginEvents, LoginState> {
  final AuthenticationRepository authenticationRepository;
  final HiveStorageRepository hiveStorageRepository;
  LoginBloc(this.authenticationRepository, this.hiveStorageRepository)
      : super(LoginInitial()) {
    on<LoginEvent>(login);
    on<LocalLoginEvent>(handleLocalLoginEvent);
  }
  Future<void> login(LoginEvent event, Emitter<LoginState> emitter) async {
    emitter(LoginLoading());
    Map<String, dynamic> canAuthenticate =
        await authenticationRepository.isLocalAuthSupported();
    if (!canAuthenticate["status"]) {
      emitter(LocalAuthSupportError(canAuthenticate["message"]));
      return;
    }
    var result = await authenticationRepository.loginUser(
        event.username, event.password, event.serverURL);
    if (result is Map) {
      emitter(
        LoginLoaded(
          orgUnits: result["orgUnits"],
        ),
      );
    } else {
      emitter(LoginGeneralError(result));
    }
  }

  Future<void> handleLocalLoginEvent(
      LocalLoginEvent event, Emitter<LoginState> emitter) async {
    emitter(LoginLoading());
    Map<String, dynamic> canAuthenticate =
        await authenticationRepository.isLocalAuthSupported();
    if (!canAuthenticate["status"]) {
      emitter(LocalAuthSupportError(canAuthenticate["message"]));
      return;
    }
    Map<String, dynamic> savedCredentials =
        await authenticationRepository.getSavedCredentials();
    if (!savedCredentials["status"]) {
      emitter(LocalAuthSupportError(savedCredentials["message"]));
      return;
    }
    emitter(LocalAuthSuccess(savedCredentials["data"]));
  }
}
