
part of 'auth_model.dart';
class User {
  User({
    this.id,
    this.authenticateType,
    this.accessToken,
    this.profile,
  });


  User.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        profile = Profile.fromJson(json['profile'] as Map<String,dynamic> ),
        authenticateType = json['authenticateType'] as String,
        accessToken = json['accessToken'] as AccessToken;


  final String id;
  final Profile profile;
  final String authenticateType;
  final AccessToken accessToken;
}
