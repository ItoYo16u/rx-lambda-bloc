import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:functional_rx_bloc/modules/middleware/auth/value_object/email.dart';
import 'package:functional_rx_bloc/modules/middleware/auth/value_object/password.dart';
abstract class TryAuthParams {}
class SignUpParams extends TryAuthParams{
  SignUpParams(
      {@required this.email, @required this.password, @required this.username});

  final Email email;
  final Password password;
  final String username;
}
class TokenSignInParams extends TryAuthParams {}
class SignInParams extends TryAuthParams {
  SignInParams(
      {@required this.email, @required this.password});

  final Email email;
  final Password password;
}
class SignOutParams extends TryAuthParams{}

class DeleteAccountParams extends TryAuthParams {
  DeleteAccountParams({@required this.password}){
    if(password.length <5){
      throw const FormatException('password is too short!');
    }
  }
  final String password;
}
