part of 'validation.dart';
class ValidationConstants{
  static const String emailRegExp = r"^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$";
  static const String urlRegExp = r"https?://[\w!?/\+\-_~=;\.,*&@$%\(\)\'\[\]]+";
  static const String internationalPhoneNumberRegExp = r'^\+\d+$';

  static const String passwordEmpty = 'パスワードを入力してください';
  static String passwordLengthError(int min, int max){
    return 'パスワードは$min文字以上$max文字未満で入力してください';
  }
  static const String passwordLackLetters = 'パスワードには大文字・小文字・数字を１文字以上含んでください';

  static const String keywordEmpty = 'あいことばを入力してください';

  static const String emailEmpty = 'メールアドレスを入力してください';
  static const String emailInvalidFormat = 'メールアドレスのフォーマットが正しくありません';

  static const String phoneNumberEmpty = '電話番号を入力してください';
  static const String phoneNumberInvalidFormat = '電話番号のフォーマットが正しくありません';

  static const String displayNameEmpty = '氏名を入力してください';
  static String displayNameLengthError(int n) => '氏名は$n文字以下で入力してください';

  static const String urlEmpty = 'URLを入力してください';
  static const String urlInvalidFormat = 'URLが正しくありません';
}