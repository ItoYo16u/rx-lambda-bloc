import 'package:equatable/equatable.dart';
import 'package:functional_rx_bloc/modules/middleware/auth/model/auth_model.dart';
import 'package:meta/meta.dart';
/// 認証状態を表現するevent オブジェクト
///
/// 以下の状態を扱う
/// - Ready: 認証前
/// - Pending: 認証中
/// - Success: 認証済み
/// - Error : 認証失敗
@immutable
abstract class TryAuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class Ready extends TryAuthState {
  Ready({this.message});

  final String message;
}

class Pending extends TryAuthState {}

class Success extends TryAuthState {
  final User user;

  Success({@required this.user});

  @override
  List<Object> get props => [user];
}

class Error extends TryAuthState {
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [message];
}
