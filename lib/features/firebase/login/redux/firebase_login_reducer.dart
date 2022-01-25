import 'package:redux/redux.dart';

import 'firebase_login_actions.dart';
import 'firebase_login_state.dart';

final firebaseLoginReducer = combineReducers<FirebaseLoginState>([
  TypedReducer<FirebaseLoginState, LoadingStateChangedAction>(_loadingStateChanged),
  TypedReducer<FirebaseLoginState, ErrorDialogStateChangedAction>(_changeErrorDialogState),
  TypedReducer<FirebaseLoginState, ChangePasswordStateAction>(_changePasswordState),
  TypedReducer<FirebaseLoginState, LoginAction>(_login),
]);

FirebaseLoginState _changeErrorDialogState(FirebaseLoginState state, ErrorDialogStateChangedAction action) {
  return state.rebuild((builder) => builder
    ..errorDialogVisible = action.isVisible
    ..build());
}

FirebaseLoginState _loadingStateChanged(FirebaseLoginState state, LoadingStateChangedAction action) {
  return state.rebuild((builder) => builder
    ..isLoading = action.isLoading
    ..build());
}

FirebaseLoginState _changePasswordState(FirebaseLoginState state, ChangePasswordStateAction action) {
  return state.rebuild((builder) => builder
    ..hidePassword = !state.hidePassword
    ..build());
}

FirebaseLoginState _login(FirebaseLoginState state, LoginAction action) {
  return state.rebuild((builder) => builder
    ..errorDialogVisible = !action.isSuccessful
    ..isLoading = false
    ..user = action.userCredential
    ..authFailedException = action.authFailedException
    ..build());
}
