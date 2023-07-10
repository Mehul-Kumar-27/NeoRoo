// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

abstract class ServerBlocEvents extends Equatable {}

class ConnectToServer extends ServerBlocEvents {

  @override
  List<Object?> get props => [];
}

class CheckForAttributes extends ServerBlocEvents {
  @override
  List<Object?> get props => [];
}

class CheckForEntityTypes extends ServerBlocEvents {
 @override
  List<Object?> get props => [];
}

