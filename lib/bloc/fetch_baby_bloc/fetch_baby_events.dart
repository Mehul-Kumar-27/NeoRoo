// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import 'package:neoroo_app/models/infant_model.dart';

class FetchBabyEvents extends Equatable {
  const FetchBabyEvents();

  @override
  List<Object> get props => [];
}

class GetInfantsFromServer extends FetchBabyEvents {
  final BuildContext context;

  GetInfantsFromServer(this.context);
}

class SearchInfants extends FetchBabyEvents {
  String query;
  List<Infant> infantList;
  SearchInfants({
    required this.query,
    required this.infantList,
  });

  @override
  List<Object> get props => [];
}
