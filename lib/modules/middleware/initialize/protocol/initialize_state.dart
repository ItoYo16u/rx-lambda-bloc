import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class InitializeState extends Equatable {
  @override
  List<Object> get props => [];
}

class NotInitialized extends InitializeState{}

class Initializing extends InitializeState {}


class Initialized extends InitializeState {
}

class InitializeFailed extends InitializeState {
  final String message;

  InitializeFailed({@required this.message});

  @override
  List<Object> get props => [message];
}