import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
/// 認証状態を表現するevent オブジェクト
///
/// 以下の状態を扱う
/// - UnAuthorized: 認証前
/// - Pending: 認証中
/// - Authorized: 認証済み
/// - Error : 認証失敗
@immutable
abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class UnAuthorized extends AuthState {
  UnAuthorized({this.message});

  final String message;
}

class Pending extends AuthState {}

class Authorized extends AuthState {
  final String token;

  Authorized({@required this.token});

  @override
  List<Object> get props => [token];
}

class Error extends AuthState {
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [message];
}
