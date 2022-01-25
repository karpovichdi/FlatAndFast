import 'package:firebase_auth/firebase_auth.dart';
import 'package:flat_and_fast/common/redux/app/app_state.dart';
import 'package:flat_and_fast/common/redux/app/app_state_actions.dart';
import 'package:flat_and_fast/common/utils/exceptions/login_failed_exception.dart';
import 'package:flat_and_fast/common/utils/validation/validator.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

class ChangePasswordStateAction {}

class LoadingStateChangedAction {
  LoadingStateChangedAction({
    required this.isLoading,
  });

  final bool isLoading;
}

class ErrorDialogStateChangedAction {
  ErrorDialogStateChangedAction({
    required this.isVisible,
  });

  final bool isVisible;
}

class LoginAction {
  LoginAction({
    required this.authFailedException,
    required this.userCredential,
    required this.isSuccessful,
  });

  final AuthFailedException? authFailedException;
  final bool isSuccessful;
  final UserCredential? userCredential;
}

ThunkAction<AppState> dismissDialog() {
  return (Store<AppState> store) async {
    store.dispatch(ErrorDialogStateChangedAction(isVisible: false));
  };
}

ThunkAction<AppState> showDialog() {
  return (Store<AppState> store) async {
    store.dispatch(ErrorDialogStateChangedAction(isVisible: true));
  };
}

ThunkAction<AppState> goBack(Function navigateBackAction) {
  return (Store<AppState> store) async {
    navigateBackAction();
  };
}

ThunkAction<AppState> changePasswordState() {
  return (Store<AppState> store) async {
    store.dispatch(ChangePasswordStateAction());
  };
}

ThunkAction<AppState> navigateToSignUp(Future Function() navigateToSignUp) {
  return (Store<AppState> store) async {
    navigateToSignUp();
  };
}

ThunkAction<AppState> login(String email, String password, Function navigateToHomeAction) {
  return (Store<AppState> store) async {
    try {
      store.dispatch(LoadingStateChangedAction(isLoading: true));

      final user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      store.dispatch(LoginAction(isSuccessful: true, userCredential: user, authFailedException: null));
      navigateToHomeAction();
    } catch (error) {
      store.dispatch(
        LoginAction(
          isSuccessful: false,
          userCredential: null,
          authFailedException: AuthFailedException(
            message: Validator.deleteBrackets(error.toString()),
          ),
        ),
      );
    }
  };
}
