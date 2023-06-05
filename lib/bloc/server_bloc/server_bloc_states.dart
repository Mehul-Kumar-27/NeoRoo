// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:neoroo_app/exceptions/custom_exception.dart';

abstract class ServerBlocStates extends Equatable {}

class ServerStateInitial extends ServerBlocStates {
  @override
  List<Object?> get props => [];
}

class ConnectingToServerState extends ServerBlocStates {
  @override
  List<Object?> get props => [];
}
class ConnectedToServer extends ServerBlocStates{
  @override
  List<Object?> get props => [];
}
//////////////////

class FetchAttributes extends ServerBlocStates {
  @override
  List<Object?> get props => [];
}
class PrepareAttributes extends ServerBlocStates {
  @override
  List<Object?> get props => [];
}
class AttributesPrepared extends ServerBlocStates {
  @override
  List<Object?> get props => [];
}

//////////////////

class FetchTrackedEntityType extends ServerBlocStates {
  @override
  List<Object?> get props => [];
}

class PrepareEntityType extends ServerBlocStates {
  @override
  List<Object?> get props => [];
}


class ServerPrepared extends ServerBlocStates {
  @override
  List<Object?> get props => [];
}

class ConnectionFailed extends ServerBlocStates {
  final CustomException exception;
  ConnectionFailed({
    required this.exception,
  });
  @override
  List<Object?> get props => [this.exception];
}
