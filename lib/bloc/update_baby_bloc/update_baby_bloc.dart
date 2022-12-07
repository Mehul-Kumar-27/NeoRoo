import 'package:bloc/bloc.dart';
import 'package:neoroo_app/bloc/update_baby_bloc/update_baby_events.dart';
import 'package:neoroo_app/bloc/update_baby_bloc/update_baby_states.dart';
import 'package:neoroo_app/repository/hive_storage_repository.dart';

class UpdateBabyBloc extends Bloc<UpdateBabyEvents,UpdateBabyStates>{
  final HiveStorageRepository hiveStorageRepository;
  UpdateBabyBloc(this.hiveStorageRepository):super(UpdateBabyInitial()){
    on<UpdateBabyEvent>(updateBaby);
  }
  Future<void> updateBaby(UpdateBabyEvent updateBabyEvent, Emitter<UpdateBabyStates> emitter)async{
    if(updateBabyEvent.birthDate.isEmpty ||
        updateBabyEvent.birthTime.isEmpty ||
        updateBabyEvent.motherName.trim().isEmpty ||
        updateBabyEvent.birthWeight.isEmpty ||
        updateBabyEvent.bodyLength.isEmpty ||
        updateBabyEvent.headCircumference.isEmpty ||
        updateBabyEvent.familyMemberGroup.isEmpty ||
        updateBabyEvent.caregiverGroup.isEmpty ||
        updateBabyEvent.birthDescription.isEmpty){
          emitter(
            UpdateBabyEmptyField()
          );
          return;
        }
    emitter(UpdateBabyInProgress());
    await hiveStorageRepository.updateBaby(updateBabyEvent.birthDate, updateBabyEvent.birthTime, updateBabyEvent.motherName, double.parse(updateBabyEvent.birthWeight), double.parse(updateBabyEvent.bodyLength), double.parse(updateBabyEvent.headCircumference), updateBabyEvent.familyMemberGroup, updateBabyEvent.caregiverGroup, updateBabyEvent.birthDescription, updateBabyEvent.index);
    emitter(UpdateBabySuccess());
  }
}