import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:functional_rx_bloc/modules/middleware/validation/validator/validation.dart';
import 'package:functional_rx_bloc/modules/middleware/validation/validator/validation_constants.dart';
/// passwordのバリューオブジェクト. 一般的なpasswordのルール以外の特別なドメインルールが存在するならここでバリデーションする.
class Password extends Equatable{
  factory Password(String value) => value.isPassword() is Right
      ? Password._internal(value)
      : throw const FormatException(ValidationConstants.invalidPasswordFormat);
  const Password._internal(this._value);

  final String _value;

  static Either<FormatException, Password> create(String value) =>
      value.isPassword().map((r) => Password._internal(r));

  @override
  // TODO: implement props
  List<Object> get props =>[_value];
}
