import 'package:dartz/dartz.dart';
import 'package:functional_rx_bloc/modules/middleware/auth/protocol/try_auth_params.dart';
import 'package:functional_rx_bloc/modules/middleware/common/error/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure,String>> fetchAuthToken();
  Future<Either<Failure,String>> signInWithToken(String token);
  Future<Either<Failure,String>> signIn(SignInParams params);
  Future<Either<Failure,String>> signUp(SignUpParams params);
  Future<Either<Failure,Unit>> signOut(SignOutParams params);
  Future<Either<Failure,Unit>> deleteAccount(DeleteAccountParams params);

}