import 'package:functional_rx_bloc/modules/middleware/auth/interface/auth_middleware.dart';
import 'package:functional_rx_bloc/modules/middleware/auth/mock_auth_middleware.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt sl = GetIt.instance;

/// DI
Future<bool> init() async {
  // ローカルストレージの初期化
  final sharedPreferences = await SharedPreferences.getInstance();
  // middlewareの初期化
  final mockMiddleware = MockAuthMiddleware();
  sl.registerSingleton<AuthMiddleware>(mockMiddleware);
  // repository,usecaseの初期化
  // initializerMiddlewareの初期化
  return true;
}
