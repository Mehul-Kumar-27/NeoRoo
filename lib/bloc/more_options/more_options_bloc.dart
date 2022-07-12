import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoroo_app/bloc/more_options/more_options_events.dart';
import 'package:neoroo_app/bloc/more_options/more_options_states.dart';
import 'package:neoroo_app/repository/hive_storage_repository.dart';

class MoreOptionsBloc extends Bloc<MoreOptionsEvents,MoreOptionsStates>{
  final HiveStorageRepository hiveStorageRepository;
  MoreOptionsBloc(this.hiveStorageRepository):super(InitialMoreOptionsState()){
    on<LoadMoreOptionsEvent>(loadMoreOptions);
    on<LogoutEvent>(logOutUser);
  }
  Future<void> loadMoreOptions(LoadMoreOptionsEvent loadMoreOptionsEvent, Emitter<MoreOptionsStates> emitter)async{
    bool isCaregiver=await hiveStorageRepository.getIsCareGiver();
    if(isCaregiver){
      emitter(
        CaregiverUser(),
      );
    }else{
      emitter(
        FamilyMemberUser(),
      );
    }
  }
  Future<void> logOutUser(LogoutEvent logoutEvent,Emitter<MoreOptionsStates> emitter)async{
    await hiveStorageRepository.logOutUser();
    emitter(UserLoggedOut());
  }
}