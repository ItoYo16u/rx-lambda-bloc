
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:functional_rx_bloc/modules/middleware/auth/model/auth_model.dart';

abstract class AuthState extends Equatable {
  const AuthState._();
  @override
  List<Object> get props => [];
}
class TryInitializing extends AuthState {
  const TryInitializing():super._();
}
class Authenticated extends AuthState {
  const Authenticated({@required this.user}):super._();
  final User user;
}
class NotAuthenticated extends AuthState {
  final String message;
  const NotAuthenticated({this.message}):super._();
}