import 'package:dartz/dartz.dart';
import 'package:functional_rx_bloc/modules/middleware/validation/validator/validation.dart';
import 'package:functional_rx_bloc/modules/middleware/validation/validator/validation_constants.dart';

class Email {
  factory Email(String value) => value.isEmail() is Right
      ? Email._internal(value)
      : throw const FormatException(ValidationConstants.emailInvalidFormat);

  Email._internal(this._value);

  static Either<FormatException, Email> create(String value) =>
      value.isEmail().map((r) => Email._internal(r));

  final String _value;
}
