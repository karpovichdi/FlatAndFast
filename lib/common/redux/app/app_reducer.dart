import 'package:flat_and_fast/common/redux/app/ui_reducer.dart';

import 'app_state.dart';

AppState appReducer(AppState state, dynamic action) {
  return state.rebuild(
    (builder) => builder
      ..uiState.replace(
        uiReducer(state.uiState, action),
      ),
  );
}
