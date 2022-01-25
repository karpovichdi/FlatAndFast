import 'package:flat_and_fast/common/redux/app/ui_state/ui_reducer.dart';
import 'package:redux/redux.dart';

import 'app_state.dart';
import 'auth/auth_reducer.dart';

final appReducer = combineReducers<AppState>([
  TypedReducer<AppState, dynamic>(_initialize),
]);

AppState _initialize(AppState state, dynamic action) {
  return state.rebuild(
    (builder) => builder
      ..uiState.replace(uiReducer(state.uiState, action))
      ..authState.replace(authReducer(state.authState, action)),
  );
}
