import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class InitializeEvent extends Equatable {

  @override
  List<Object> get props => [];
}

class Init extends InitializeEvent {
}



