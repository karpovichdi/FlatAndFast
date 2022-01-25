import 'package:built_value/built_value.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flat_and_fast/common/utils/exceptions/login_failed_exception.dart';

part 'firebase_sign_up_state.g.dart';

abstract class FirebaseSignUpState implements Built<FirebaseSignUpState, FirebaseSignUpStateBuilder> {
  FirebaseSignUpState._();

  factory FirebaseSignUpState.initial() {
    return _$FirebaseSignUpState._(
      errorDialogVisible: false,
      successDialogVisible: false,
      isLoading: false,
      hidePassword: true,
    );
  }

  factory FirebaseSignUpState([void Function(FirebaseSignUpStateBuilder)? updates]) = _$FirebaseSignUpState;

  bool get errorDialogVisible;

  bool get successDialogVisible;

  bool get isLoading;

  bool get hidePassword;

  UserCredential? get user;

  AuthFailedException? get authFailedException;
}
