// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:neoroo_app/bloc/add_user_bloc/add_user_event.dart';
import 'package:neoroo_app/bloc/add_user_bloc/add_user_state.dart';
import 'package:neoroo_app/exceptions/custom_exception.dart';
import 'package:neoroo_app/repository/add_user_repository.dart';

class AddUserBloc extends Bloc<AddUserEvent, AddUserState> {
  final AddUserRepository addUserRepository;
  AddUserBloc(
    this.addUserRepository,
  ) : super(AddUserInitial()) {
    on<AddUserOnServer>(createUser);
  }

  createUser(AddUserOnServer event, Emitter<AddUserState> emitter) async {
    emitter(AddUserEventInitial());
    Either<bool, CustomException> response =
        await addUserRepository.createUserOnDhis2Server(event.firstName,
            event.lastName, event.email, event.username, event.password);
    response.fold(
        (l) => emitter(AddUserSuccessful()), (r) => emitter(AddUserFailed(r)));
  }
}
