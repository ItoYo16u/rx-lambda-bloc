import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:functional_rx_bloc/modules/middleware/validation/validator/validation.dart';
import 'package:functional_rx_bloc/modules/middleware/validation/validator/validation_constants.dart';
/// emailのバリューオブジェクト. 一般的なemailのルール以外の特別なドメインルールが存在するならここでバリデーションする.
class Email extends Equatable {
  factory Email(String value) => value.isEmail() is Right
      ? Email._internal(value)
      : throw const FormatException(ValidationConstants.emailInvalidFormat);

  const Email._internal(this._value);

  static Either<FormatException, Email> create(String value) =>
      value.isEmail().map((r) => Email._internal(r));

  final String _value;

  @override
  List<Object> get props => [_value];
}
