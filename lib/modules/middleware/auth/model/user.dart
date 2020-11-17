
part of 'auth_model.dart';
class User {
  User({
    this.id,
    this.authenticateType,
    this.firstName,
    this.lastName,
    this.accessToken,
  });


  User.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        firstName = json['firstName'] as String,
        lastName = json['lastName'] as String,
        authenticateType = json['authenticateType'] as String,
        accessToken = json['accessToken'] as AccessToken;

  String get fullName => '$lastName $firstName';

  final String id;
  final String authenticateType;
  final String firstName;
  final String lastName;
  final AccessToken accessToken;
}
