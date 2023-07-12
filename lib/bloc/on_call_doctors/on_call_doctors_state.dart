import 'package:neoroo_app/exceptions/custom_exception.dart';

class OnCallDoctorsState {}

class OnCallDoctorsInitial extends OnCallDoctorsState {}

class OnCallDoctorsSucessState extends OnCallDoctorsState {
  final List<dynamic> todaysSchedule;

  OnCallDoctorsSucessState(this.todaysSchedule);
}

class OnCallDoctorsErrorState extends OnCallDoctorsState {
  final CustomException exception;

  OnCallDoctorsErrorState(this.exception);
}
