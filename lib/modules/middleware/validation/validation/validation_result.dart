part of 'validation.dart';

/// バリデーションの結果を表す普遍オブジェクト
/// [_valid]はバリデーションが通っているか、[_target]はバリデーションを行う文字列、[_errorMessage]はバリデーションでエラーが発生した場合のエラーメッセージ。
class ValidationResult{
  const ValidationResult({bool valid, String target, String errorMessage}):
    _valid = valid,
    _target = target,
    _errorMessage = errorMessage;

  final bool _valid;
  final String _target;
  final String _errorMessage;

  bool get _invalid => !_valid;

  /// バリデーション結果を、バリデーションが通ればnull、失敗していればエラーメッセージを返す
  String validate() => _valid ? null : _errorMessage;
  
  /// バリデーションの結果をbooleanで返す
  bool get isValid => _valid;

  ValidationResult _copyWith({bool valid, String target, String errorMessage})=> ValidationResult(valid: valid ?? _valid, target: target ?? _target, errorMessage: errorMessage ?? _errorMessage);
}