import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoroo_app/bloc/authentication/local_auth_login_bloc/local_authentication_events.dart';
import 'package:neoroo_app/bloc/authentication/local_auth_login_bloc/local_authentication_states.dart';
import 'package:neoroo_app/repository/authentication_repository.dart';
import 'package:neoroo_app/repository/hive_storage_repository.dart';

class LocalAuthBloc extends Bloc<LocalAuthEvents,LocalAuthStates>{
  final AuthenticationRepository authenticationRepository;
  final HiveStorageRepository hiveStorageRepository;
  LocalAuthBloc(this.authenticationRepository, this.hiveStorageRepository)
      : super(LocalAuthInitial()) {
    on<LocalAuthRequestEvent>(login);
  }
  Future<void> login(LocalAuthRequestEvent event, Emitter<LocalAuthStates> emitter)async{}

}