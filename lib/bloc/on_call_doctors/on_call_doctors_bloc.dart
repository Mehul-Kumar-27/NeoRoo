import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoroo_app/bloc/on_call_doctors/on_call_doctors_event.dart';
import 'package:neoroo_app/bloc/on_call_doctors/on_call_doctors_state.dart';
import 'package:neoroo_app/repository/on_call_doctors_repository.dart';

class OnCallDoctorsBloc extends Bloc<OnCallDoctorsEvent, OnCallDoctorsState> {
  final OnCallDoctorsRepository onCallDoctorsRepository;
  OnCallDoctorsBloc(this.onCallDoctorsRepository)
      : super(OnCallDoctorsInitial()) {
    on<GetOnCallDoctors>((event, emit) {});
  }

  Future<void> getOnCallDoctors(
      GetOnCallDoctors event, Emitter<OnCallDoctorsState> emitter) async {
    var response = await onCallDoctorsRepository.getOnCallDoctors();
    if (response is List) {
      emitter(OnCallDoctorsSucessState(response));
    } else {
      emitter(OnCallDoctorsErrorState(response));
    }
  }
}
