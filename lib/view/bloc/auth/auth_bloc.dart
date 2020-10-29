import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:functional_rx_bloc/modules/middleware/auth/auth_middleware.dart';
import 'package:functional_rx_bloc/modules/middleware/auth/protocol/auth_event.dart';
import 'package:functional_rx_bloc/modules/middleware/auth/protocol/auth_state.dart';
import 'package:functional_rx_bloc/modules/middleware/common/error/failures.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthMiddleware _authMiddleware;

  // todo require middleware
  AuthBloc(AuthState initialState, {AuthMiddleware middleware})
      : _authMiddleware = middleware,
        super(initialState);

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is SignUp) {
      yield* event.validate().fold(
        (failure) async* {
          yield Error(message: '');
        },
        (params) async* {
          yield Pending();
          final failureOrToken = await _authMiddleware.signUp(params);
          yield* _eitherSuccessOrError(failureOrToken);
        },
      );
    } else if (event is SignIn) {
      yield* event.validate().fold((failure) async* {
        yield Error(message: 'err:wrong email or password');
      }, (params) async* {
        yield Pending();
        // final failureOrToken = await _authMiddleware.signIn(params);
        // yield* _eitherSuccessOrError(failureOrToken);
        final isAuthenticated = params.email == 'test@example.com' &&
            params.password == 'password12345';
        yield isAuthenticated
            ? Authorized(token: "token")
            : UnAuthorized(message: 'wrong email or password');
      });
    } else if (event is SignOut) {
      yield* event.validate().fold((failure) async* {
        yield Error(message: 'wrong email or password');
      }, (params) async* {
        yield Pending();
        await Future<void>.delayed(const Duration(seconds: 1));
        //final failureOrUnit = await _authMiddleware.signOut(params);
        //yield* _eitherSignOutOrError(failureOrUnit);
        yield UnAuthorized();
      });
    } else if (event is SignInWithToken) {
      yield* event.validate().fold((failure) async* {
        yield Error(message: '');
      }, (params) async* {
        yield Pending();
        //final failureOrToken =  _authMiddleware.tryAutoSignIn(); => repo.retrieveToken.then signInWithToken(token)
        await Future<void>.delayed(const Duration(seconds: 1));
        // unauthorized or authorized or err
        yield UnAuthorized(message: 'token expired');
      });
    }
  }

  Stream<AuthState> _eitherSuccessOrError(
    Either<Failure, String> failureOrToken,
  ) async* {
    yield failureOrToken.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (token) => Authorized(token: token),
    );
  }

  Stream<AuthState> _eitherSignOutOrError(
    Either<Failure, void> failureOrUnit,
  ) async* {
    yield failureOrUnit.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (_) => UnAuthorized(),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'server error';
      case CacheFailure:
        return 'cache error';
      default:
        return 'Unexpected error';
    }
  }
}
