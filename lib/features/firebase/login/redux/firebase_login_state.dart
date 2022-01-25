import 'package:built_value/built_value.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flat_and_fast/common/utils/exceptions/login_failed_exception.dart';

part 'firebase_login_state.g.dart';

abstract class FirebaseLoginState implements Built<FirebaseLoginState, FirebaseLoginStateBuilder> {
  FirebaseLoginState._();

  factory FirebaseLoginState.initial() {
    return _$FirebaseLoginState._(
      errorDialogVisible: false,
      isLoading: false,
      hidePassword: true,
    );
  }

  factory FirebaseLoginState([void Function(FirebaseLoginStateBuilder)? updates]) = _$FirebaseLoginState;

  bool get errorDialogVisible;

  bool get isLoading;

  bool get hidePassword;

  UserCredential? get user;

  AuthFailedException? get authFailedException;
}
