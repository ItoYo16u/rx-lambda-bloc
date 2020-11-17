part of 'auth_model.dart';

class AccessToken {
  AccessToken({
    @required this.token,
    @required this.expiration,
  })  : assert(token != null, 'token must not to be null'),
        assert(expiration != null, 'expiration must not to be null');
  // TODO(ItoYo16u): 細かい条件を追加する(e.g. expiration.isAfter(DateTime.now()))
  AccessToken.fromJson(Map<String, dynamic> json)
      : token = json['token'] as String,
        expiration =
        DateTime.fromMillisecondsSinceEpoch(json['expiration'] as int);

  final String token;
  final DateTime expiration;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'token': token,
    'expiration': expiration.millisecondsSinceEpoch,
  };
}
