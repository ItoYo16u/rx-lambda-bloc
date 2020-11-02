
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class AuthState extends Equatable {
  const AuthState._();
  @override
  List<Object> get props => [];
}
class TryInitializing extends AuthState {
  const TryInitializing():super._();
}
class Authenticated extends AuthState {
  const Authenticated({@required this.token}):super._();
  final String token;
}
class NotAuthenticated extends AuthState {
  final String message;
  const NotAuthenticated({this.message}):super._();
}