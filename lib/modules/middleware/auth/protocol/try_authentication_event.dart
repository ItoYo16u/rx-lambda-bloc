import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:functional_rx_bloc/modules/middleware/auth/protocol/try_auth_params.dart';
import 'package:functional_rx_bloc/modules/middleware/auth/value_object/email.dart';
import 'package:functional_rx_bloc/modules/middleware/auth/value_object/password.dart';
import 'package:functional_rx_bloc/modules/middleware/common/error/failures.dart';

@immutable
abstract class TryAuthEvent extends Equatable {
  Either<Failure, TryAuthParams> validate();

  @override
  List<Object> get props => [];
}

class SignInWithToken extends TryAuthEvent {
  @override
  List<Object> get props => [];

  @override
  Either<Failure, TokenSignInParams> validate() {
    return Right(TokenSignInParams());
  }
}

class SignIn extends TryAuthEvent {
  SignIn({@required this.email, @required this.password});

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];

  @override
  Either<Failure, SignInParams> validate() {
    try {
      return Right(
          SignInParams(email: Email(email), password: Password(password)));
    } on FormatException catch (e) {
      return Left(InvalidInputFailure(message: e.message));
    }
  }
}

class SignUp extends TryAuthEvent {
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
      final result = SignUpParams(
          email: Email(email),
          password: Password(password),
          username: username);
      return Right(result);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}

class SignOut extends TryAuthEvent {
  @override
  Either<Failure, SignOutParams> validate() {
    return Right(SignOutParams());
  }
}

class DeleteAccount extends TryAuthEvent {
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
