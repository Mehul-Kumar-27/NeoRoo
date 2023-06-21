import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class FetchBabyEvents extends Equatable {
  const FetchBabyEvents();

  @override
  List<Object> get props => [];
}

class GetInfantsFromServer extends FetchBabyEvents {
  final BuildContext context;

  GetInfantsFromServer(this.context);
}
