import 'package:dartz/dartz.dart';
import 'package:functional_rx_bloc/modules/middleware/validation/validator/validation.dart';

class Password {
  Password._internal(this._value);

  final String _value;

  static Either<FormatException, Password> create(String value) =>
      value.isPassword().map((r) => Password._internal(r));
}
