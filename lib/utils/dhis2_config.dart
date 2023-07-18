const caregiverGroup = "m7rHFvlkv8G";
const familyMemberGroup = "xfRuyEIN71P";
const motherName = "OQQT0IVOKMC";
const birthDate = "XShE95RVDjc";
const birthTime = "CF2zfJ40hIt";
const bodyLength = "WkBwfQh2zvs";
const birthWeight = "IjwsihsWFGs";
const headCircumference = "GETv5cVMMaj";
const requireResuscitation = "vIYf2LgS9CN";
const birthNotes = "GwciK5IFjLF";
const familyMemberUserGroup = "dfsJxqlEejm";
const caregiverUserGroup = "vCMP96VuOKE";
const trackerProgramId = "Nsieup9fiQp";
const avatarIdAttribute = "pr3gQ05Qf6q";
const trackedEntityType = "Dnn2nc0kiud";

final Map<String, String> neoRooRequiredAttributes = {
  "Birth_Date": "NeoRoo_Birth_Date",
  "Birth_Notes": "NeoRoo_Birth_Notes",
  "Birth Time": "NeoRoo_Birth_Time",
  "Birth Weight": "NeoRoo_Birth_Weight",
  "Body Length": "NeoRoo_Body_Length",
  "NCN": "NeoRoo_Crib_Number",
  "NeoRoo_Device_Id": "NeoRoo_Device_Id",
  "Head Circumference": "NeoRoo_Head_Circumference",
  "Require Resuscitation": "NeoRoo_Require_Resuscitation",
  "NeoRoo_TEI_avatar": "NeoRoo_TEI_avatar",
  "Ward Number": "NeoRoo_Ward_Number",
  "Present Weight": "NeoRoo_Weight_of_baby_normal",
  "Mother Name": "NeoRoo_mother_name",
  "Mother Id": "NeoRoo_mother_id",
  "STS_Time": "NeoRoo_STS",
  "NSTS_Time": "NeoRoo_NSTS",
  "Infant_Temperature": "NeoRoo_Temperature",
  "Infant_Heart_Rate": "NeoRoo_HeartRate",
  "Infant_Respiration_Rate": "NeoRoo_RespiratoryRate",
  "Infant_Blood_Oxygen": "NeoRoo_BloodOxygen",
  "Goals": "NeoRoo_Goals",
  "todo": "ToDo",
  "infant_ID": "NeoRoo_InfantID"
};

const List<String> trackedEntityNameList = ["NeoRoo"];

final Map<String, String> ecebRequiredAttributeList = {
  "ECEB_TEI_BirthDate_Time": "ECEB_TEI_BirthDate_Time",
  "ECEB_TEI_Classification": "ECEB_TEI_Classification",
  "Identifier": "ECEB_TEI_Identifier",
  "ECEB_TEI_Mother_Name": "ECEB_TEI_Mother_Name",
  "ECEB_TEI_Ward_Name": "ECEB_TEI_Ward_Name",
  "ebdt": "ECEB_birth_description_TEI"
};

final Map<String, String> onCallDoctorsAttributeList = {
  "On Call Doctor List": "On Call Doctor List",
  "Organization Unit": "Organization Unit",
  "On Call Doctor List ID": "On Call Doctor List ID"
};

final String ecebEntityName = "Newborn";
final String onCallDoctorsProgramsName = "On Call Doctor";
