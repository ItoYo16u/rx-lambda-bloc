import 'package:dartz/dartz.dart';
import 'package:functional_rx_bloc/modules/middleware/validation/validator/validation.dart';
import 'package:functional_rx_bloc/modules/middleware/validation/validator/validation_constants.dart';

class Password {
  factory Password(String value) => value.isPassword() is Right
      ? Password._internal(value)
      : throw const FormatException(ValidationConstants.invalidPasswordFormat);
  Password._internal(this._value);

  final String _value;

  static Either<FormatException, Password> create(String value) =>
      value.isPassword().map((r) => Password._internal(r));
}
