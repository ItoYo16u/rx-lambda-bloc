
import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState._();
  @override
  List<Object> get props => [];
}
class Authenticated extends AuthState {
  const Authenticated():super._();
}
class NotAuthenticated extends AuthState {
  final String message;
  const NotAuthenticated({this.message}):super._();
}