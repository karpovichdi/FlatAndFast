import 'package:redux/redux.dart';

import 'firebase_sign_up_actions.dart';
import 'firebase_sign_up_state.dart';

final firebaseSignUpReducer = combineReducers<FirebaseSignUpState>([
  TypedReducer<FirebaseSignUpState, LoadingStateChangedAction>(_loadingStateChanged),
  TypedReducer<FirebaseSignUpState, ErrorDialogStateChangedAction>(_changeErrorDialogState),
  TypedReducer<FirebaseSignUpState, SuccessDialogStateChangedAction>(_changeSuccessDialogState),
  TypedReducer<FirebaseSignUpState, ChangePasswordStateAction>(_changePasswordState),
  TypedReducer<FirebaseSignUpState, SignUpAction>(_signUp),
]);

FirebaseSignUpState _changeErrorDialogState(FirebaseSignUpState state, ErrorDialogStateChangedAction action) {
  return state.rebuild((builder) => builder
    ..errorDialogVisible = action.isVisible
    ..build());
}

FirebaseSignUpState _changeSuccessDialogState(FirebaseSignUpState state, SuccessDialogStateChangedAction action) {
  return state.rebuild((builder) => builder
    ..successDialogVisible = action.isVisible
    ..build());
}

FirebaseSignUpState _loadingStateChanged(FirebaseSignUpState state, LoadingStateChangedAction action) {
  return state.rebuild((builder) => builder
    ..isLoading = action.isLoading
    ..build());
}

FirebaseSignUpState _changePasswordState(FirebaseSignUpState state, ChangePasswordStateAction action) {
  return state.rebuild((builder) => builder
    ..hidePassword = !state.hidePassword
    ..build());
}

FirebaseSignUpState _signUp(FirebaseSignUpState state, SignUpAction action) {
  return state.rebuild((builder) => builder
    ..errorDialogVisible = !action.isSuccessful
    ..isLoading = false
    ..user = action.userCredential
    ..authFailedException = action.authFailedException
    ..successDialogVisible = action.isSuccessful
    ..build());
}