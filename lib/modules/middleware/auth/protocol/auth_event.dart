import 'package:equatable/equatable.dart';

/// 認証状態

/// auth middlewareの処理が完了してアプリケーションの状態を更新する必要があるときに呼ばれる
abstract class ChangeAuthStateEvent extends Equatable {
  const ChangeAuthStateEvent._();

  @override
  List<Object> get props => [];
}

class UpdateToBeAuthenticated extends ChangeAuthStateEvent {
  const UpdateToBeAuthenticated({this.message}) : super._();
  final String message;
}
class UpdateToBeUnAuthenticated extends ChangeAuthStateEvent {
  const UpdateToBeUnAuthenticated({this.message}) : super._();
  final String message;
}
