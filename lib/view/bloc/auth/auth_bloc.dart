import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:functional_rx_bloc/modules/middleware/auth/protocol/auth_event.dart';
import 'package:functional_rx_bloc/modules/middleware/auth/protocol/auth_state.dart';

class AuthBloc extends Bloc<ChangeAuthStateEvent,AuthState> {
  AuthBloc() : super(const NotAuthenticated());

  @override
  Stream<AuthState> mapEventToState(ChangeAuthStateEvent event) async* {
    if(event is UpdateToBeAuthenticated){
      yield const Authenticated();
    }else if (event is UpdateToBeUnAuthenticated ){
      yield const NotAuthenticated();
    }else {
      yield const NotAuthenticated();
    }
  }
}