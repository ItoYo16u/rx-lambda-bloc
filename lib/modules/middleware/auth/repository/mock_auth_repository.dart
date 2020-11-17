import 'package:dartz/dartz.dart';
import 'package:functional_rx_bloc/modules/middleware/auth/model/auth_model.dart';
import 'package:functional_rx_bloc/modules/middleware/auth/protocol/try_auth_params.dart';
import 'package:functional_rx_bloc/modules/middleware/auth/repository/auth_repository.dart';
import 'package:functional_rx_bloc/modules/middleware/common/error/failures.dart';

class MockAuthRepository implements AuthRepository {
  @override
  Future<Either<Failure, Unit>> deleteAccount(DeleteAccountParams params) {
    // TODO: implement deleteAccount
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> fetchAuthToken() async {
    return const Right('token');
  }

  @override
  Future<Either<Failure, User>> signIn(SignInParams params) {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> signInWithToken(String token) async{
    return Right(User());
  }

  @override
  Future<Either<Failure, Unit>> signOut(SignOutParams params) {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> signUp(SignUpParams params) {
    // TODO: implement signUp
    throw UnimplementedError();
  }

}