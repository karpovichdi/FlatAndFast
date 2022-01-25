import 'package:firebase_auth/firebase_auth.dart';
import 'package:flat_and_fast/common/redux/app/app_state.dart';
import 'package:flat_and_fast/common/navigation/navigation_helper.dart';
import 'package:flat_and_fast/common/utils/exceptions/login_failed_exception.dart';
import 'package:flat_and_fast/common/utils/validation/validator.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

class ChangePasswordStateAction {}

class TryAgainAction {}

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

class SuccessDialogStateChangedAction {
  SuccessDialogStateChangedAction({
    required this.isVisible,
  });

  final bool isVisible;
}

class SignUpAction {
  SignUpAction({
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

ThunkAction<AppState> signUp(String email, String password, Function goBackAction) {
  return (Store<AppState> store) async {
    try {
      store.dispatch(LoadingStateChangedAction(isLoading: true));

      final UserCredential user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      store.dispatch(SignUpAction(isSuccessful: true, userCredential: user, authFailedException: null));

      const successDialogDuration = Duration(seconds: 2);
      await Future.delayed(successDialogDuration);

      store.dispatch(SuccessDialogStateChangedAction(isVisible: false));
      goBackAction();
    } catch (error) {
      store.dispatch(
        SignUpAction(
          isSuccessful: false,
          userCredential: null,
          authFailedException: AuthFailedException(
            message: Validator.deleteBrackets(
              error.toString(),
            ),
          ),
        ),
      );
    }
  };
}
