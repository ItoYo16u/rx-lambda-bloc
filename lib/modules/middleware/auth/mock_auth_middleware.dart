import 'package:dartz/dartz.dart';
import 'package:functional_rx_bloc/modules/middleware/auth/auth_error.dart';
import 'package:functional_rx_bloc/modules/middleware/auth/interface/auth_middleware.dart';
import 'package:functional_rx_bloc/modules/middleware/auth/model/auth_model.dart';
import 'package:functional_rx_bloc/modules/middleware/auth/protocol/try_auth_params.dart';
import 'package:functional_rx_bloc/modules/middleware/auth/repository/auth_repository.dart';
import 'package:functional_rx_bloc/modules/middleware/auth/value_object/email.dart';
import 'package:functional_rx_bloc/modules/middleware/auth/value_object/password.dart';
import 'package:functional_rx_bloc/modules/middleware/common/error/failures.dart';

class MockAuthMiddleware implements AuthMiddleware {
  MockAuthMiddleware({this.authRepository});

  final AuthRepository authRepository;

  @override
  Future<Either<Failure, void>> deleteAccount(DeleteAccountParams params) {
    // TODO: implement deleteAccount
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> signIn(SignInParams params) async {
    final isAuthenticated = params.email == Email('test@example.com') &&
        params.password == Password('Password12345');
    return isAuthenticated ? Right(User()) : Left(AccountNotFound());
  }

  @override
  Future<Either<Failure, Unit>> signOut(SignOutParams params) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    return const Right(unit);
  }

  @override
  Future<Either<Failure, User>> signUp(SignUpParams params) async {
    return Right(User());
  }

  @override
  Future<Either<Failure, User>> tryAutoSignIn() async {
    final _tokenE = await authRepository.fetchAuthToken();
    //   ConnectionFailure,ServerFailure,
    //  TokenNotFound,InvalidToken,OtherFailure,
    final _userEitherF = _tokenE.fold(
        (l) => Future.value(Left<Failure, User>(l)),
        authRepository.signInWithToken);
    // ConnectionFailure,ServerFailure,
    // Rejected,OtherFailure
    final _userE = await _userEitherF;
    return _userE;
  }
}
