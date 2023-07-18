// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:neoroo_app/exceptions/custom_exception.dart';

class ToDoState {}

class ToDoInitial extends ToDoState{}

class AddDoToSucessState extends ToDoState{}

class AddToFailedState extends ToDoState {
 final CustomException exception;
  AddToFailedState({
    required this.exception,
  });
}
