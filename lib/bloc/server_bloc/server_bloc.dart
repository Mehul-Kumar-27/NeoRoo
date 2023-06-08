// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:neoroo_app/bloc/server_bloc/server_bloc_events.dart';
import 'package:neoroo_app/bloc/server_bloc/server_bloc_states.dart';
import 'package:neoroo_app/repository/hive_storage_repository.dart';
import 'package:neoroo_app/repository/server_repository.dart';

class ServerBloc extends Bloc<ServerBlocEvents, ServerBlocStates> {
  final ServerRepository serverRepository;
  final HiveStorageRepository hiveStorageRepository;
  ServerBloc(
    this.serverRepository,
    this.hiveStorageRepository,
  ) : super(ServerStateInitial()) {
    on<ConnectToServer>(connectToServer);
    on<CheckForAttributes>(checkForAttributes);
    on<CheckForEntityTypes>(checkForEntityTypes);
  }

  Future connectToServer(
      ConnectToServer event, Emitter<ServerBlocStates> emitter) async {
    emitter(ConnectingToServerState());
    String serverURL = await hiveStorageRepository.getOrganisationURL();
    print("$serverURL this is the server url !!!!!!!!!!!!!!!!!!111");
    // Write the code to connect to the server basically authentication
    var response = await serverRepository.connectToServer();
    if (response == "Sucess") {
      emitter(ConnectedToServer());
    } else {
      emitter(ConnectionFailed(exception: response));
    }
  }

  Future checkForAttributes(
      CheckForAttributes event, Emitter<ServerBlocStates> emitter) async {
    emitter(FetchAttributes());
    //Write code for checking the avability of attributes
    var attributeResponse = await serverRepository.checkForAttributes();
    if (attributeResponse is List<String>) {
      List<String> attributesToPrepare = attributeResponse;
      if (attributesToPrepare.isEmpty) {
        /// No need to create attributes check for entity
        emitter(AttributesPrepared());
        //////
      } else if (attributesToPrepare.isNotEmpty) {
        print("Im here");
        for (var name in attributesToPrepare) {
          print(name);
        }
        emitter(PrepareAttributes());
        var prepareAttributeResponse =
            await serverRepository.prepareAttribute(attributesToPrepare);
        if (prepareAttributeResponse == true) {
          emitter(AttributesPrepared());
        } else {
          emitter(ConnectionFailed(exception: prepareAttributeResponse));
        }
      }
    } else {
      emitter(ConnectionFailed(exception: attributeResponse));
    }
  }

  Future checkForEntityTypes(
      CheckForEntityTypes event, Emitter<ServerBlocStates> emitter) async {
    emitter(FetchTrackedEntityType());

    var entityResponse = await serverRepository.checkForEntityTypes();

    if (entityResponse is List<String>) {
      List<String> trackedEntitiesToPrepare = entityResponse;

      if (trackedEntitiesToPrepare.isEmpty) {
        await hiveStorageRepository.saveLoginInformation();
        emitter(ServerPrepared());
      } else {
        emitter(PrepareEntityType());
        var prepareEntityResponse = await serverRepository.prepareEntityTypes();
        if (prepareEntityResponse == true) {
          await hiveStorageRepository.saveLoginInformation();
          emitter(ServerPrepared());
        } else {
          emitter(ConnectionFailed(exception: prepareEntityResponse));
        }
      }
    }
  }
}
