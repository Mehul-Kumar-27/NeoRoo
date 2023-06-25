// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:image_picker/image_picker.dart';
import 'package:neoroo_app/models/infant_model.dart';

import 'package:neoroo_app/models/infant_mother.dart';

class AddBabyEvents {}

class AddBabyEvent extends AddBabyEvents {
  final String birthDate;
  final String birthNotes;
  final String birthTime;
  final String birthWeight;
  final String bodyLength;
  final String cribNumber;
  final String neoDeviceID;
  final String headCircumference;
  final XFile? image;
  final String needResuscitation;
  final String wardNumber;
  final String presentWeight;
  final String motherName;
  final String motherId;
  final String stsTime;
  final String nstsTime;
  final String infantTemperature;
  final String infantHeartRate;
  final String infantRespirationRate;
  final String infantBloodOxygen;
  final String infantId;

  AddBabyEvent(
      this.birthDate,
      this.birthNotes,
      this.birthTime,
      this.birthWeight,
      this.bodyLength,
      this.cribNumber,
      this.neoDeviceID,
      this.headCircumference,
      this.image,
      this.needResuscitation,
      this.wardNumber,
      this.presentWeight,
      this.motherName,
      this.motherId,
      this.stsTime,
      this.nstsTime,
      this.infantTemperature,
      this.infantHeartRate,
      this.infantRespirationRate,
      this.infantBloodOxygen,
      this.infantId);
}

class GetMotherEvent extends AddBabyEvents {}

class SearchInMotherList extends AddBabyEvents {
  final String motherName;
  final List<Mother> motherList;

  SearchInMotherList(
    this.motherName,
    this.motherList,
  );
}

