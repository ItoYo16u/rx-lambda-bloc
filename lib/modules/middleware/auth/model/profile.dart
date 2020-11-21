part of 'auth_model.dart';

enum Sex { man, woman, other }

/// ユーザーを一意に識別しない情報
class Profile {
  Profile(
      {this.firstName,
      this.lastName,
      this.firstNameInKana,
      this.lastNameInKana,
      this.sex,
      this.birthDay});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return null;
  }

  String get fullName => '$lastName $firstName';
  final Sex sex;
  final DateTime birthDay;
  final String firstName;
  final String firstNameInKana;
  final String lastNameInKana;
  final String lastName;
}
