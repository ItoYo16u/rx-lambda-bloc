import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:functional_rx_bloc/modules/middleware/auth/protocol/auth_params.dart';
import 'package:functional_rx_bloc/modules/middleware/auth/value_object/email.dart';
import 'package:functional_rx_bloc/modules/middleware/auth/value_object/password.dart';
import 'package:functional_rx_bloc/modules/middleware/common/error/failures.dart';
import 'package:functional_rx_bloc/modules/middleware/validation/validator/monadic_validation.dart';

@immutable
abstract class AuthEvent extends Equatable {
  Either<Failure, AuthParams> validate();

  @override
  List<Object> get props => [];
}

class SignInWithToken extends AuthEvent {
  @override
  List<Object> get props => [];

  @override
  Either<Failure, TokenSignInParams> validate() {
    return Right(TokenSignInParams());
  }
}

class SignIn extends AuthEvent {
  SignIn({@required this.email, @required this.password});

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];

  @override
  Either<Failure, SignInParams> validate() {
    final _email = Email.create(email);
    final _password =Password.create(password);
   // if ([_email,_password].every((_) =>_.isRight() )) return Right(SignInParams(email: email, password: password));
    // _emailと_passwordが両方Rightの時のみRightを返したい.
    try {
      return Right(SignInParams(email: email, password: password));
    } on FormatException catch (e) {
      return Left(InvalidInputFailure(message: e.message));
    }
  }
}

class SignUp extends AuthEvent {
  SignUp(
      {@required this.username, @required this.email, @required this.password});

  final String username;
  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];

  @override
  Either<Failure, SignUpParams> validate() {
    try {
      final result =
      SignUpParams(email: email, password: password, username: username);
      return Right(result);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}

class SignOut extends AuthEvent {
  @override
  Either<Failure, SignOutParams> validate() {
    return Right(SignOutParams());
  }
}

class DeleteAccount extends AuthEvent {
  DeleteAccount({this.password});

  final String password;

  @override
  Either<Failure, DeleteAccountParams> validate() {
    try {
      final result = DeleteAccountParams(password: password);
      return Right(result);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure {
  InvalidInputFailure({this.message});

  final String message;
}
