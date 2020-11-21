// ignore_for_file: unused_element
// ignore_for_file: avoid_positional_boolean_parameters
import 'package:flutter/material.dart';

part 'validation_result.dart';

part 'validation_constants.dart';

final RegExp _emailRegExp = RegExp(ValidationConstants.emailRegExp);
final RegExp _capitalRegExp = RegExp('[A-Z]');
final RegExp _lowerRegExp = RegExp('[a-z]');
final RegExp _numberRegExp = RegExp('[0-9]');
final RegExp _urlRegExp = RegExp(ValidationConstants.urlRegExp);
final RegExp _prefectureSuffixRegEx =
    RegExp(ValidationConstants.prefectureSuffixRegEx);
final RegExp _internationalPhoneNumber =
    RegExp(ValidationConstants.internationalPhoneNumberRegExp);

/// _ValidationResultの操作メソッド
extension _ExValidationResult on ValidationResult {
  /// 今までのバリデーションで失敗していれば変更しない。現在のバリデーションで初めて失敗した場合、バリデーション結果を更新する
  ValidationResult _updateResultIfInvalid({bool valid, String errorMessage}) {
    if (_invalid) {
      return this;
    } else {
      return _copyWith(
          valid: valid, errorMessage: !valid ? errorMessage : null);
    }
  }

  /// 空文字
  ValidationResult _isNonEmpty({String errorMessage}) => _updateResultIfInvalid(
        valid: _target.isNotEmpty,
        errorMessage: errorMessage,
      );

  /// [n]文字
  ValidationResult _isLength(int n,
          {String Function(int) errorMessageBuilder}) =>
      _updateResultIfInvalid(
        valid: _target.length == n,
        errorMessage: errorMessageBuilder?.call(n),
      );

  /// [n]文字以上
  // ignore: unused_element
  ValidationResult _isMoreThanOrEqualTo(int n,
          {String Function(int) errorMessageBuilder}) =>
      _updateResultIfInvalid(
        valid: _target.length >= n,
        errorMessage: errorMessageBuilder?.call(n),
      );

  /// [n]文字未満
  ValidationResult _isLessThan(int n,
          {String Function(int) errorMessageBuilder}) =>
      _updateResultIfInvalid(
        valid: _target.length < n,
        errorMessage: errorMessageBuilder?.call(n),
      );

  /// [n]文字以下
  ValidationResult _isLessThanOrEqualTo(int n,
          {String Function(int) errorMessageBuilder}) =>
      _updateResultIfInvalid(
        valid: _target.length <= n,
        errorMessage: errorMessageBuilder?.call(n),
      );

  /// [min]文字以上[max]文字未満
  ValidationResult _isInRange(
          {@required int max,
          @required int min,
          String Function(int, int) errorMessageBuilder}) =>
      _updateResultIfInvalid(
        valid: min <= _target.length && _target.length < max,
        errorMessage: errorMessageBuilder?.call(min, max),
      );

  /// 大文字を含む
  ValidationResult _hasCapital({String errorMessage}) => _updateResultIfInvalid(
        valid: _target.contains(_capitalRegExp),
        errorMessage: errorMessage,
      );

  /// 小文字を含む
  ValidationResult _hasLower({String errorMessage}) => _updateResultIfInvalid(
        valid: _target.contains(_lowerRegExp),
        errorMessage: errorMessage,
      );

  /// 数字を含む
  ValidationResult _hasNumber({String errorMessage}) => _updateResultIfInvalid(
        valid: _target.contains(_numberRegExp),
        errorMessage: errorMessage,
      );

  /// 特定の文字列/正規表現から始まる
  ValidationResult _startWith(Pattern pattern, {String errorMessage}) =>
      _updateResultIfInvalid(
        valid: _target.startsWith(pattern),
        errorMessage: errorMessage,
      );

  /// 特定の文字列で終わる
  ValidationResult _endWith(String pattern, {String errorMessage}) =>
      _updateResultIfInvalid(
        valid: _target.endsWith(pattern),
        errorMessage: errorMessage,
      );

  /// 正規表現
  ValidationResult _matchesRegExp(RegExp r, {String errorMessage}) =>
      _updateResultIfInvalid(
        valid: r.hasMatch(_target),
        errorMessage: errorMessage,
      );

  /// 数字のみ許容
  ValidationResult _isNumbers({String errorMessage}) => _updateResultIfInvalid(
        valid: RegExp(r'^\d+$').hasMatch(_target),
        errorMessage: errorMessage,
      );

  /// 複数条件のOR
  ValidationResult _or(List<ValidationResult> Function(ValidationResult) func,
      {String errorMessage}) {
    final validationResults = func(this);
    var valid = false;
    for (final result in validationResults) {
      if (result._valid) {
        valid = true;
        break;
      }
    }
    return _updateResultIfInvalid(valid: valid, errorMessage: errorMessage);
  }

  /// エラーメッセージを追加する
  ValidationResult _withErrorMessage(String errorMessage) =>
      _copyWith(errorMessage: _errorMessage ?? errorMessage);

  /// エラーメッセージを上書きする
  ValidationResult _overrideErrorMessage(String errorMessage) =>
      _copyWith(errorMessage: errorMessage);
}

/// バリデーションクラス。
/// + `input.isEmail().isValid`は、`input`がバリデーションをパスしている場合はtrue、そうでなければfalseを返す。
/// + `input.isEmail().validate()`は、`input`がバリデーションをパスしている場合はnull、そうでなければエラーメッセージを返す。
///
/// 後者は[TextFormField]の`validator`プロパティでの利用を想定。
///
/// バリデーションを追加する場合は[ValidationString]に、普遍的なバリデーションを追加する場合には[_ExValidationResult]にメソッドを追加してください。
///
/// example
/// ```dart
/// String input = "test@sample.com";
/// if(input.isEmail().isValid){
///   // pass validation.
///   submit(email: input);
/// }
/// ```
extension ValidationString on String {
  ValidationResult _validate() => ValidationResult(valid: true, target: this);

  // NOTE (yuta-ike): 簡易用のパスワードバリデーション
  ValidationResult isSimplePassword() => _validate()
      ._isNonEmpty(errorMessage: ValidationConstants.passwordEmpty)
      ._isInRange(
          min: 4,
          max: 10,
          errorMessageBuilder: ValidationConstants.passwordLengthError)
      ._withErrorMessage(ValidationConstants.passwordLackLetters);

  // NOTE (AkimuneKawa) : ログイン時にパスワードの制約を教える必要はない
  ValidationResult isPasswordNotEmpty() =>
      _validate()._isNonEmpty(errorMessage: ValidationConstants.passwordEmpty);

  // NOTE (AkimuneKawa) : パスワードは英大文字小文字数字含む8文字以上(100文字以下)
  ValidationResult isPassword() => _validate()
      ._isNonEmpty(errorMessage: ValidationConstants.passwordEmpty)
      ._isInRange(
          min: 8,
          max: 100,
          errorMessageBuilder: ValidationConstants.passwordLengthError)
      ._hasCapital(errorMessage: null)
      ._hasLower(errorMessage: null)
      ._hasNumber(errorMessage: null)
      ._withErrorMessage(ValidationConstants.passwordLackLetters);

  ValidationResult isEmail() => _validate()
      ._isNonEmpty(errorMessage: ValidationConstants.emailEmpty)
      ._matchesRegExp(_emailRegExp,
          errorMessage: ValidationConstants.emailInvalidFormat);

  ValidationResult isPostalCode() => _validate()
      ._isNumbers(errorMessage: ValidationConstants.mustBeNumbers)
      ._isLength(7, errorMessageBuilder: ValidationConstants.mastBeEq);

  ValidationResult isPrefecture() =>
      _validate()._matchesRegExp(_prefectureSuffixRegEx);

  ValidationResult isPhoneNumber() => _validate()
      ._isNonEmpty(errorMessage: ValidationConstants.phoneNumberEmpty)
      ._isNumbers()
      ._or((result) => [result._isLength(11), result._isLength(10)])
      ._startWith('0')
      ._withErrorMessage(ValidationConstants.phoneNumberInvalidFormat);

  ValidationResult isInternationalPhoneNumber() => _validate()
      ._isNonEmpty(errorMessage: ValidationConstants.phoneNumberEmpty)
      ._startWith('+')
      ._matchesRegExp(_internationalPhoneNumber)
      ._withErrorMessage(ValidationConstants.phoneNumberInvalidFormat);

  ValidationResult isDisplayName() => _validate()
      ._isNonEmpty(errorMessage: ValidationConstants.displayNameEmpty)
      // NOTE: 名前は30文字以下
      ._isLessThanOrEqualTo(30,
          errorMessageBuilder: ValidationConstants.displayNameLengthError);

  ValidationResult isURL() => _validate()
      ._isNonEmpty(errorMessage: ValidationConstants.urlEmpty)
      ._matchesRegExp(_urlRegExp,
          errorMessage: ValidationConstants.urlInvalidFormat);

  String isValidWhen(bool cond, {String errorMessage}) =>
      cond ? null : errorMessage;

  String isInvalidWhen(bool cond, {String errorMessage}) =>
      isValidWhen(!cond, errorMessage: errorMessage);
}
