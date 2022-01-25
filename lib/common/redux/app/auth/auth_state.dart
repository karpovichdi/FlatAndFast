import 'package:built_value/built_value.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_state.g.dart';

abstract class AuthState implements Built<AuthState, AuthStateBuilder> {
  AuthState._();

  factory AuthState() {
    return _$AuthState._(
      isAuthorized: false,
      user: null,
    );
  }

  bool get isAuthorized;

  UserCredential? get user;
}
