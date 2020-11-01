import 'package:functional_rx_bloc/modules/middleware/common/error/failures.dart';

abstract class AuthFailure extends Failure{
  AuthFailure(this.message);

  final String message;
}
abstract class SignInFailure extends AuthFailure {
  SignInFailure(String message):super(message);
}

abstract class SignUpFailure extends AuthFailure {
  SignUpFailure(String message):super(message);

}


class AccountLocked extends SignInFailure {
  AccountLocked():super('アカウントがロックされています');
}

class AccountNotFound extends SignInFailure {
  AccountNotFound():super('アカウントが見つかりませんでした');
}

class AccountAlreadyTaken extends SignUpFailure {
  AccountAlreadyTaken():super('このアカウントは既に使用されています');
}
