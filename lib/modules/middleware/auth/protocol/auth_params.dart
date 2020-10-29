import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:functional_rx_bloc/modules/middleware/auth/protocol/auth_event.dart';
abstract class AuthParams {}
class SignUpParams extends AuthParams{
  SignUpParams(
      {@required this.email, @required this.password, @required this.username}){
    if(password.length < 5){
      // !(email.validate().isEmail() && password.validate().isPassword() && username.validate().isUserName())
      throw const FormatException('password is too short!');
    }
  }

  final String email;
  final String password;
  final String username;
}
class TokenSignInParams extends AuthParams {}
class SignInParams extends AuthParams {
  SignInParams(
      {@required this.email, @required this.password}){
    // todo Email object と password objectを作って,formatexceptionはそこで投げる.
    if (email == null || password == null) throw const FormatException('email and password must not be null!');
    if(password.length < 5){
      // !(email.validate().isEmail() && password.validate().isPassword() && username.validate().isUserName())
      throw const FormatException('password is too short!');
    }
  }

  final String email;
  final String password;
}
class SignOutParams extends AuthParams{}

class DeleteAccountParams extends AuthParams {
  DeleteAccountParams({@required this.password}){
    if(password.length <5){
      throw const FormatException('password is too short!');
    }
  }
  final String password;
}
