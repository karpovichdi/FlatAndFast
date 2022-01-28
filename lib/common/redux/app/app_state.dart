import 'package:built_value/built_value.dart';
import 'package:flat_and_fast/common/redux/app/ui_state/ui_state.dart';

import 'auth/auth_state.dart';

part 'app_state.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {
  AppState._();

  factory AppState.initial() {
    return AppState(
      loginState: AuthState(),
      uiState: UIState(),
    );
  }

  factory AppState({
    required AuthState loginState,
    required UIState uiState,
  }) {
    return _$AppState._(
      authState: loginState,
      uiState: uiState,
    );
  }

  AuthState get authState;

  UIState get uiState;
}