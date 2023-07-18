// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

import 'package:neoroo_app/bloc/ToDo_bloc/to_do_events.dart';
import 'package:neoroo_app/bloc/ToDo_bloc/to_do_states.dart';
import 'package:neoroo_app/exceptions/custom_exception.dart';
import 'package:neoroo_app/repository/todo_repository.dart';

class ToDoBloc extends Bloc<ToDoEvent, ToDoState> {
  final ToDoRepository toDoRepository;
  ToDoBloc(
    this.toDoRepository,
  ) : super(ToDoInitial()) {
    on<AddToDoEvent>(addToDoEvent);
  }

  Future addToDoEvent(AddToDoEvent event, Emitter<ToDoState> emitter) async {
    if (event.dateTime.isEmpty ||
        event.toDoBody.isEmpty ||
        event.toDoId.isEmpty ||
        event.toDoTitle.isEmpty) {
      emitter(AddToFailedState(
          exception: FetchDataException("Please fill all details", 404)));
    } else {
      Either<bool, CustomException> response = await toDoRepository.addToDo(
          event.toDoId,
          event.toDoTitle,
          event.toDoBody,
          event.dateTime,
          event.toDoTag);
      response.fold(
          (l) => {
                if (l == true) {emitter(AddDoToSucessState())}
              },
          (r) => {emitter(AddToFailedState(exception: r))});
    }
  }
}