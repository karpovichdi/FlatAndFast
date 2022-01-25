import 'package:built_value/built_value.dart';
import 'package:flat_and_fast/common/redux/app/ui_state/ui_state.dart';

import 'auth/auth_state.dart';

part 'app_state.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {
  AppState._();

  factory AppState.initial() {
    return AppState(
      uiState: UIState(),
      loginState: AuthState(),
    );
  }

  factory AppState({
    required UIState uiState,
    required AuthState loginState,
  }) {
    return _$AppState._(
      uiState: uiState,
      authState: loginState,
    );
  }

  UIState get uiState;

  AuthState get authState;
}