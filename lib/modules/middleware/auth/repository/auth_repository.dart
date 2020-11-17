import 'package:dartz/dartz.dart';
import 'package:functional_rx_bloc/modules/middleware/auth/model/auth_model.dart';
import 'package:functional_rx_bloc/modules/middleware/auth/protocol/try_auth_params.dart';
import 'package:functional_rx_bloc/modules/middleware/common/error/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure,String>> fetchAuthToken();
  Future<Either<Failure,User>> signInWithToken(String token);
  Future<Either<Failure,User>> signIn(SignInParams params);
  Future<Either<Failure,User>> signUp(SignUpParams params);
  Future<Either<Failure,Unit>> signOut(SignOutParams params);
  Future<Either<Failure,Unit>> deleteAccount(DeleteAccountParams params);

}