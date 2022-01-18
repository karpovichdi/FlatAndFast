import 'package:built_value/built_value.dart';
import 'package:flat_and_fast/common/redux/app/ui_state.dart';

part 'app_state.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {
  AppState._();

  factory AppState.initial() {
    return AppState(
      uiState: UIState(),
    );
  }

  factory AppState({
    required UIState uiState,
  }) {
    return _$AppState._(
      uiState: uiState,
    );
  }

  UIState get uiState;
}