import 'package:dartz/dartz.dart';
import 'package:functional_rx_bloc/modules/middleware/auth/model/auth_model.dart';
import 'package:functional_rx_bloc/modules/middleware/auth/protocol/try_auth_params.dart';
import 'package:functional_rx_bloc/modules/middleware/common/error/failures.dart';
/// auth middlewareが返すのはsignIn/up/out -> InternalServerError, signIn-> UserNotFoundError,signUp -> UserAlreadyExistErrorなど
/// paramsの生成時に失敗しうるようにする
/// バリデーション、表示とsubmit制限はバリデーションmiddlewareとblocに任せる
abstract class AuthMiddleware {
  Future<Either<Failure,User>> signIn(SignInParams params);
  /// ulid 、アカウントオブジェクトの生成、repositoryで永続化、レスポンス処理
  Future<Either<Failure,User>> signUp(SignUpParams params);
  Future<Either<Failure,User>> tryAutoSignIn();
  Future<Either<Failure,Unit>> signOut(SignOutParams params);
  Future<Either<Failure,void>> deleteAccount(DeleteAccountParams params);
}