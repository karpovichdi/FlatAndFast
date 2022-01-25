import 'package:redux/redux.dart';

import 'auth_actions.dart';
import 'auth_state.dart';

final authReducer = combineReducers<AuthState>([
  TypedReducer<AuthState, AuthorizedChangedStateAction>(_authChanged),
]);

AuthState _authChanged(AuthState state, AuthorizedChangedStateAction action) {
  return state.rebuild((builder) => builder
    ..isAuthorized = action.isAuthorized
    ..build());
}