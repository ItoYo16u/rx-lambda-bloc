import 'package:functional_rx_bloc/modules/middleware/common/error/failures.dart';

abstract class AuthFailure extends Failure{}
abstract class SignInFailure extends AuthFailure{}
abstract class SignUpFailure extends AuthFailure{}


class AccountLocked extends SignInFailure{}
class AccountNotFound extends SignInFailure{}
class AccountAlreadyTaken extends SignUpFailure{}
