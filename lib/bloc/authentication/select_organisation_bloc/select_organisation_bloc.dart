import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoroo_app/bloc/authentication/select_organisation_bloc/select_organisation_events.dart';
import 'package:neoroo_app/bloc/authentication/select_organisation_bloc/select_organisation_states.dart';
import 'package:neoroo_app/repository/authentication_repository.dart';
import 'package:neoroo_app/repository/hive_storage_repository.dart';

class SelectOrganisationBloc
    extends Bloc<SelectOrganisationEvents, SelectOrganisationStates> {
  final AuthenticationRepository authenticationRepository;
  final HiveStorageRepository hiveStorageRepository;
  SelectOrganisationBloc(
      this.authenticationRepository, this.hiveStorageRepository)
      : super(SelectOrganisationLoading()) {
    on<RequestOrganisationInfo>(handleRequest);
    on<SelectOrganisationEvent>(handleSelection);
  }
  Future handleRequest(RequestOrganisationInfo event,
      Emitter<SelectOrganisationStates> emitter) async {
        emitter(SelectOrganisationLoading());
      final List<List<String?>> organisationData=await authenticationRepository.getOrganisationListDetails();
      emitter(SelectOrganisationLoaded(organisationData: organisationData));
  }
  Future<void> handleSelection(SelectOrganisationEvent event,
      Emitter<SelectOrganisationStates> emitter) async {
        await authenticationRepository.selectOrganisation(event.organisationId,event.organisationName);
        emitter(SelectOrganisationComplete());
      }
}
