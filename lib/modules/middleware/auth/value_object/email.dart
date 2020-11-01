import 'package:dartz/dartz.dart';
import 'package:functional_rx_bloc/modules/middleware/validation/validator/validation.dart';

class Email {
  Email._internal(this._value);

  static Either<FormatException, Email> create(String value) =>
      value.isEmail().map((r) => Email._internal(r));

  final String _value;
}
