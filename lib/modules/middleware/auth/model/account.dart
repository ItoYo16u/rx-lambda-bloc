part of 'auth_model.dart';

enum AccountRank {
  normal,
}

class Account {
  const Account({this.id,this.accountRank});
  final String id;
  final AccountRank accountRank;
}