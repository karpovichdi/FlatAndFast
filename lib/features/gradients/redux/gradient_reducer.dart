import 'package:redux/redux.dart';

import 'gradient_screen_actions.dart';
import 'gradient_screen_state.dart';

final gradientReducer = combineReducers<GradientScreenState>([
  TypedReducer<GradientScreenState, LoadingAction>(_loading),
  TypedReducer<GradientScreenState, LoadingFinishedAction>(_loadingFinished),
]);

GradientScreenState _loading(GradientScreenState state, LoadingAction action) {
  return state.rebuild((builder) => builder
    ..isLoading = true
    ..build());
}

GradientScreenState _loadingFinished(GradientScreenState state, LoadingFinishedAction action) {
  return state.rebuild((builder) => builder
    ..isLoading = false
    ..build());
}
