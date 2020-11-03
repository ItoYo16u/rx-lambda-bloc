import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:functional_rx_bloc/modules/middleware/auth/auth_error.dart';
import 'package:functional_rx_bloc/modules/middleware/auth/interface/auth_middleware.dart';
import 'package:functional_rx_bloc/modules/middleware/auth/protocol/try_auth_state.dart';
import 'package:functional_rx_bloc/modules/middleware/auth/protocol/try_authentication_event.dart';
import 'package:functional_rx_bloc/modules/middleware/common/error/failures.dart';

///新規会員登録・ログイン・自動ログインなどを行う
///
///イベントを受信すると処理を行い
///- Ready
///- Pending
///- Success || Error
///
///の状態にmessageをつめて通知する.
class TryAuthBloc extends Bloc<TryAuthEvent, TryAuthState> {
  final AuthMiddleware _authMiddleware;

  TryAuthBloc(TryAuthState initialState, {@required AuthMiddleware middleware})
      : _authMiddleware = middleware,
        super(initialState);

  @override
  Stream<TryAuthState> mapEventToState(
    TryAuthEvent event,
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
      // validationで弾かれた場合はusecase/middleware層に入らずにリターンする
      //
      //     validation
      //   ------o--> success --> usecase/middleware -o--> result
      //          \                                 /
      //           \--> error ---------------------/
      yield* event.validate().fold((failure) async* {
        if (failure is InvalidInputFailure) {
          yield Error(message: failure.message ?? 'something went wrong');
        } else {
          yield Error(message: 'something went wrong');
        }
      }, (params) async* {
        yield Pending();
        final failureOrToken = await _authMiddleware.signIn(params);
        yield* _eitherSuccessOrError(failureOrToken);
      });
    } else if (event is SignInWithToken) {
      yield* event.validate().fold((failure) async* {
        yield Error(message: '');
      }, (params) async* {
        yield Pending();
        final failureOrToken = await _authMiddleware.tryAutoSignIn();
        yield* _eitherSuccessOrError(failureOrToken);
      });
    }
  }

  Stream<TryAuthState> _eitherSuccessOrError(
    Either<Failure, String> failureOrToken,
  ) async* {
    yield failureOrToken.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (token) => Success(token: token),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return 'サーバーエラーが発生しました';
    } else if (failure is SignInFailure) {
      return failure.message;
    } else {
      return '予期せぬエラーが発生しました.';
    }
  }
}
