import 'package:firebase_auth/firebase_auth.dart';
import 'package:flat_and_fast/common/redux/app/app_state.dart';
import 'package:flat_and_fast/features/firebase/utils/styles/firebase_localization.dart';
import 'package:redux/redux.dart';

import 'firebase_sign_up_actions.dart' as firebase;

class FirebaseSignUpViewModel {
  FirebaseSignUpViewModel({
    required this.isLoading,
    required this.isAuthorized,
    required this.errorDialogVisible,
    required this.successDialogVisible,
    required this.hidePassword,
    required this.authFailedMessage,
    required this.user,
    required this.signUp,
    required this.dismissDialog,
    required this.showDialog,
    required this.goBack,
    required this.changePasswordState,
  });

  final bool isLoading;
  final bool isAuthorized;
  final bool hidePassword;
  final bool errorDialogVisible;
  final bool successDialogVisible;
  final UserCredential? user;
  final String authFailedMessage;

  final Function(String, String, Function) signUp;
  final Function() dismissDialog;
  final Function() showDialog;
  final Function(Function) goBack;
  final Function() changePasswordState;

  static FirebaseSignUpViewModel fromStore(Store<AppState> store) {
    var user = store.state.uiState.firebaseSignUpState.user;
    return FirebaseSignUpViewModel(
      isLoading: store.state.uiState.firebaseSignUpState.isLoading,
      isAuthorized: store.state.authState.isAuthorized,
      user: user,
      authFailedMessage: store.state.uiState.firebaseSignUpState.authFailedException?.message ?? FirebaseLocalization.errorMessage,
      errorDialogVisible: store.state.uiState.firebaseSignUpState.errorDialogVisible,
      successDialogVisible: store.state.uiState.firebaseSignUpState.successDialogVisible,
      hidePassword: store.state.uiState.firebaseSignUpState.hidePassword,
      signUp: (email, password, goBackAction) => store.dispatch(firebase.signUp(email, password, goBackAction)),
      dismissDialog: () => store.dispatch(firebase.dismissDialog()),
      showDialog: () => store.dispatch(firebase.showDialog()),
      goBack: (navigateBackAction) => store.dispatch(firebase.goBack(navigateBackAction)),
      changePasswordState: () => store.dispatch(firebase.changePasswordState()),
    );
  }
}
