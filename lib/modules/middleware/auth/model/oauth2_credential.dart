part of 'auth_model.dart';

class Oauth2Credential {
  Oauth2Credential({
    this.accessToken,
    this.tokenType,
    this.expiresIn,
    this.scope,
  });

  Oauth2Credential.fromJson(Map<String, dynamic> json)
      : accessToken = json['accessToken'] as String,
        tokenType = json['tokenType'] as String,
        expiresIn = json['expiresIn'] as int,
        scope = json['scope'] as String;

  final String accessToken;
  final String tokenType;
  final int expiresIn;
  final String scope;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'accessToken': accessToken,
    'tokenType': tokenType,
    'expiresIn': expiresIn,
    'scope': scope,
  };

  @override
  String toString() =>
      'Oauth2Credential{accessToken: $accessToken, tokenType: $tokenType, expiresIn: $expiresIn, scope: $scope}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Oauth2Credential &&
              runtimeType == other.runtimeType &&
              accessToken == other.accessToken &&
              tokenType == other.tokenType &&
              expiresIn == other.expiresIn &&
              scope == other.scope;

  @override
  int get hashCode =>
      accessToken.hashCode ^
      tokenType.hashCode ^
      expiresIn.hashCode ^
      scope.hashCode;
}
