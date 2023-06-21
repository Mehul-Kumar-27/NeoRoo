// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:neoroo_app/models/infant_model.dart';
import 'package:neoroo_app/models/profile.dart';
import 'package:neoroo_app/models/tracked_attributes.dart';
import 'package:neoroo_app/network/fetch_baby_client.dart';
import 'package:neoroo_app/repository/hive_storage_repository.dart';

class FetchBabyRepository {
  final FetchBabyClient fetchBabyClient;
  final HiveStorageRepository hiveStorageRepository;

  FetchBabyRepository({
    required this.fetchBabyClient,
    required this.hiveStorageRepository,
  });

  Stream<List<Infant>> getInfantsFromServer() async* {
    Profile profile = await hiveStorageRepository.getUserProfile();
    String organizationUnitID =
        await hiveStorageRepository.getSelectedOrganisation();
    String serverURL = await hiveStorageRepository.getOrganisationURL();
    String username = profile.username;
    String password = profile.password;
    TrackedAttributes trackedAttributes =
        await hiveStorageRepository.getTarckedAttribute("NeoRoo");

    yield* fetchBabyClient.fetchInfant(username, password, serverURL,
        trackedAttributes.trackedAttributeId, organizationUnitID);
  }
}
