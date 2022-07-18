class SelectOrganisationStates {}

class SelectOrganisationLoading extends SelectOrganisationStates {}

class SelectOrganisationLoaded extends SelectOrganisationStates {
  final List<List<String?>> organisationData;
  SelectOrganisationLoaded({required this.organisationData});
}

class SelectOrganisationComplete extends SelectOrganisationStates {}

class SelectOrganisationInProgress extends SelectOrganisationStates {}
