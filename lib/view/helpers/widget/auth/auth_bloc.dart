import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:functional_rx_bloc/view/helpers/widget/auth/auth_event.dart';
import 'package:functional_rx_bloc/view/helpers/widget/auth/auth_state.dart';
/// 認証状態を管理し、変更を通知する
class AuthBloc extends Bloc<ChangeAuthStateEvent,AuthState> {
  AuthBloc() : super(const TryInitializing());

  @override
  Stream<AuthState> mapEventToState(ChangeAuthStateEvent event) async* {
    if(event is UpdateToBeAuthenticated){
      yield Authenticated(user: event.user);
    }else if (event is UpdateToBeUnAuthenticated ){
      yield const NotAuthenticated();
    } else if(event is TryInitializeWithMiddleware) {
      final res = await event.middleware.tryAutoSignIn();
      yield* res.fold((failure)async* {
        yield const NotAuthenticated();
      }, (user) async* {
       yield Authenticated(user: user);
      });
    } else {
      yield const NotAuthenticated();
    }
  }
}