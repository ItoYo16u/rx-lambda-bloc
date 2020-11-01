import 'package:dartz/dartz.dart';
import 'package:functional_rx_bloc/modules/middleware/auth/auth_error.dart';
import 'package:functional_rx_bloc/modules/middleware/auth/interface/auth_middleware.dart';
import 'package:functional_rx_bloc/modules/middleware/auth/protocol/try_auth_params.dart';
import 'package:functional_rx_bloc/modules/middleware/common/error/failures.dart';

class MockAuthMiddleware implements AuthMiddleware {
  @override
  Future<Either<Failure, void>> deleteAccount(DeleteAccountParams params) {
    // TODO: implement deleteAccount
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> signIn(SignInParams params) async {
    final isAuthenticated = params.email == 'test@example.com' &&
        params.password == 'password12345';
    return isAuthenticated ? const Right('token') : Left(AccountNotFound());
  }

  @override
  // ignore: missing_return
  Future<Either<Failure, Unit>> signOut(SignOutParams params) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    return const Right(unit);
  }

  @override
  Future<Either<Failure, String>> signUp(SignUpParams params) {
    // TODO: implement signUp
    throw UnimplementedError();
  }
}
