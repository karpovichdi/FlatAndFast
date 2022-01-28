import 'package:firebase_auth/firebase_auth.dart';
import 'package:flat_and_fast/common/redux/app/app_state.dart';
import 'package:flat_and_fast/features/firebase/utils/styles/firebase_localization.dart';
import 'package:redux/redux.dart';

import 'firebase_login_actions.dart' as firebase;
import 'package:flat_and_fast/common/redux/app/auth/auth_actions.dart' as login_actions;

class FirebaseLoginViewModel {
  FirebaseLoginViewModel({
    required this.isLoading,
    required this.isAuthorized,
    required this.errorDialogVisible,
    required this.hidePassword,
    required this.loginFailedMessage,
    required this.user,
    required this.login,
    required this.googleLogin,
    required this.dismissDialog,
    required this.showErrorDialog,
    required this.goBack,
    required this.updateGlobalAuthState,
    required this.navigateToSignUp,
    required this.changePasswordState,
  });

  final bool isLoading;
  final bool isAuthorized;
  final bool hidePassword;
  final bool errorDialogVisible;
  final UserCredential? user;
  final String loginFailedMessage;

  final Function(String, String, Function) login;
  final Function(Function) googleLogin;
  final Function(Future Function()) navigateToSignUp;
  final Function(Future Function()) goBack;
  final Function() dismissDialog;
  final Function() showErrorDialog;
  final Function() updateGlobalAuthState;
  final Function() changePasswordState;

  static FirebaseLoginViewModel fromStore(Store<AppState> store) {
    var user = store.state.uiState.firebaseLoginState.user;
    return FirebaseLoginViewModel(
      isLoading: store.state.uiState.firebaseLoginState.isLoading,
      user: user,
      isAuthorized: user != null,
      loginFailedMessage: store.state.uiState.firebaseLoginState.authFailedException?.message ?? FirebaseLocalization.errorMessage,
      errorDialogVisible: store.state.uiState.firebaseLoginState.errorDialogVisible,
      hidePassword: store.state.uiState.firebaseLoginState.hidePassword,
      login: (email, password, navigateHome) => store.dispatch(firebase.login(email, password, navigateHome)),
      googleLogin: (navigateHome) => store.dispatch(firebase.googleLogin(navigateHome)),
      dismissDialog: () => store.dispatch(firebase.dismissDialog()),
      showErrorDialog: () => store.dispatch(firebase.showDialog()),
      updateGlobalAuthState: () => store.dispatch(login_actions.changeIsAuthorizedState(user)),
      changePasswordState: () => store.dispatch(firebase.changePasswordState()),
      goBack: (navigateBackAction) => store.dispatch(firebase.goBack(navigateBackAction)),
      navigateToSignUp: (navigateToSignUp) => store.dispatch(firebase.navigateToSignUp(navigateToSignUp)),
    );
  }
}
