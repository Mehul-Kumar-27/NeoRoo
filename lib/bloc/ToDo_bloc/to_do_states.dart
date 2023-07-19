// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:neoroo_app/exceptions/custom_exception.dart';

class ToDoState {}

class ToDoInitial extends ToDoState {}

class AddDoToSucessState extends ToDoState {}

class AddToDoFailedState extends ToDoState {
  final CustomException exception;
  AddToDoFailedState({
    required this.exception,
  });
}

class UpdateToDoSucessState extends ToDoState {}

class UpdateToDoFailedState extends ToDoState {
  final CustomException exception;
  UpdateToDoFailedState({
    required this.exception,
  });
}
