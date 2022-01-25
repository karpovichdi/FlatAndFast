import 'package:firebase_auth/firebase_auth.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../app_state.dart';

class AuthorizedChangedStateAction {
  AuthorizedChangedStateAction({
    required this.isAuthorized,
    required this.user,
  });

  final bool isAuthorized;
  final UserCredential? user;
}

ThunkAction<AppState> changeIsAuthorizedState(UserCredential? user) {
  bool isAuthorized = user != null ? true : false;
  return (Store<AppState> store) async {
    store.dispatch(AuthorizedChangedStateAction(isAuthorized: isAuthorized, user: user));
  };
}
