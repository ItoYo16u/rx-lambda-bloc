
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt serviceLocator = GetIt.instance();
/// DI
Future<bool> init() async {
  // ローカルストレージの初期化
  final sharedPreferences = await SharedPreferences.getInstance();
  // middlewareの初期化
  // repository,usecaseの初期化
  // initializerMiddlewareの初期化
  await Future<bool>.delayed(Duration(seconds: 1));
  return true;
}