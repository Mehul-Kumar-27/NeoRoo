// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:neoroo_app/bloc/fetch_baby_bloc/fetch_baby_events.dart';
import 'package:neoroo_app/bloc/fetch_baby_bloc/fetch_baby_states.dart';
import 'package:neoroo_app/models/infant_model.dart';
import 'package:neoroo_app/models/profile.dart';
import 'package:neoroo_app/repository/fetch_baby_repository.dart';
import 'package:neoroo_app/repository/hive_storage_repository.dart';

class FetchBabyBloc extends Bloc<FetchBabyEvents, FetchBabyStates> {
  final FetchBabyRepository fetchBabyRepository;
  final HiveStorageRepository hiveStorageRepository;
  FetchBabyBloc(
    this.fetchBabyRepository,
    this.hiveStorageRepository,
  ) : super(FetchBabyInitialState()) {
    on<GetInfantsFromServer>(getInfantsFromServer);
    on<SearchInfants>(searchInInfantList);
  }

  Future<void> getInfantsFromServer(
      GetInfantsFromServer event, Emitter<FetchBabyStates> emitter) async {
    emitter(FetchBabyTriggeredState());
    Profile profile = await hiveStorageRepository.getUserProfile();

    try {
      final list = await fetchBabyRepository.getInfantsFromServer().toList();

      List<Infant> infantList = list[0];
      if (profile.userRole == "Family Member") {
        List<Infant> familyMemberInfant = [];
        for (var infant in infantList) {
          if (infant.motherUsername == profile.userId) {
            familyMemberInfant.add(infant);
          }
        }
        emitter(FetchInfantFromServerSuccess(familyMemberInfant));
      } else {
        emitter(FetchInfantFromServerSuccess(infantList));
      }
    } catch (e) {
      emitter(FetchInfantFromServerError(e.toString()));
    }
  }

  Future<void> searchInInfantList(
      SearchInfants event, Emitter<FetchBabyStates> emitter) async {
    emitter(FetchInfantFromServerSuccess(event.infantList));
    List<Infant> infantSearchResult = [];

    for (var infant in event.infantList) {
      if (infant.moterName.toLowerCase().contains(event.query.toLowerCase()) ||
          infant.dateOfBirth
              .toLowerCase()
              .contains(event.query.toLowerCase()) ||
          infant.wardNumber.toLowerCase().contains(event.query.toLowerCase())) {
        infantSearchResult.add(infant);
      }
    }
    emitter(SearchInfantList(infants: infantSearchResult));
  }
}
