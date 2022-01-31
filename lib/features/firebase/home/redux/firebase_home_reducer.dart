import 'package:flat_and_fast/features/camera/redux/camera_actions.dart';
import 'package:redux/redux.dart';

import 'firebase_home_actions.dart';
import 'firebase_home_state.dart';

final firebaseHomeReducer = combineReducers<FirebaseHomeState>([
  TypedReducer<FirebaseHomeState, LoadingAction>(_changeErrorDialogState),
]);

FirebaseHomeState _changeErrorDialogState(FirebaseHomeState state, LoadingAction action) {
  return state.rebuild((builder) => builder
    // ..errorDialogVisible = action.isVisible
    ..build());
}