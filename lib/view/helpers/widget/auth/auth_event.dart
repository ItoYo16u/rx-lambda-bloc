import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:functional_rx_bloc/modules/middleware/auth/interface/auth_middleware.dart';
import 'package:functional_rx_bloc/modules/middleware/auth/model/auth_model.dart';

/// 認証状態

/// auth middlewareの処理が完了してアプリケーションの状態を更新する必要があるときに呼ばれる
abstract class ChangeAuthStateEvent extends Equatable {
  const ChangeAuthStateEvent._();

  @override
  List<Object> get props => [];
}

/// 初期化時にログイン状態を復元するための処理.
class TryInitializeWithMiddleware extends ChangeAuthStateEvent {
  const TryInitializeWithMiddleware({@required this.middleware}) : super._();
  final AuthMiddleware middleware;
}

class UpdateToBeAuthenticated extends ChangeAuthStateEvent {
  const UpdateToBeAuthenticated(this.user, {this.message}) : super._();
  final User user;
  final String message;
}

class UpdateToBeUnAuthenticated extends ChangeAuthStateEvent {
  const UpdateToBeUnAuthenticated({this.message}) : super._();
  final String message;
}
