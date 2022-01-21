import 'package:redux/redux.dart';

import 'controls_screen_actions.dart';
import 'controls_screen_state.dart';

final controlsReducer = combineReducers<ControlsScreenState>([
  TypedReducer<ControlsScreenState, LoadingAction>(_loading),
  TypedReducer<ControlsScreenState, LoadingFinishedAction>(_loadingFinished),
]);

ControlsScreenState _loading(ControlsScreenState state, LoadingAction action) {
  return state.rebuild((builder) => builder
    ..isLoading = true
    ..build());
}

ControlsScreenState _loadingFinished(ControlsScreenState state, LoadingFinishedAction action) {
  return state.rebuild((builder) => builder
    ..isLoading = false
    ..build());
}
