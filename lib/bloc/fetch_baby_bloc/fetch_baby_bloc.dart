import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoroo_app/bloc/fetch_baby_bloc/fetch_baby_events.dart';
import 'package:neoroo_app/bloc/fetch_baby_bloc/fetch_baby_states.dart';
import 'package:neoroo_app/models/infant_model.dart';
import 'package:neoroo_app/repository/fetch_baby_repository.dart';

class FetchBabyBloc extends Bloc<FetchBabyEvents, FetchBabyStates> {
  final FetchBabyRepository fetchBabyRepository;

  FetchBabyBloc(this.fetchBabyRepository) : super(FetchBabyInitialState()) {
    on<GetInfantsFromServer>(getInfantsFromServer);
  }

  Future<void> getInfantsFromServer(
      GetInfantsFromServer event, Emitter<FetchBabyStates> emitter) async {
    emitter(FetchBabyInitialState());
    print("1");
    try {
      final list = await fetchBabyRepository.getInfantsFromServer().toList();
      print("2");
      List<Infant> infantList = list[0];
      

      emitter(FetchInfantFromServerSuccess(infantList));
    } catch (e) {
      emitter(FetchInfantFromServerError(e.toString()));
    }
  }
}
