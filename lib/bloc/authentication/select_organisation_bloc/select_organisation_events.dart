class SelectOrganisationEvents {}

class RequestOrganisationInfo extends SelectOrganisationEvents {}

class SelectOrganisationEvent extends SelectOrganisationEvents {
  String organisationId;
  SelectOrganisationEvent({required this.organisationId});
}
