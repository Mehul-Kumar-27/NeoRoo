class SelectOrganisationEvents {}

class RequestOrganisationInfo extends SelectOrganisationEvents {}

class SelectOrganisationEvent extends SelectOrganisationEvents {
  String organisationId;
  String? organisationName;
  SelectOrganisationEvent(
      {required this.organisationId, required this.organisationName});
}
