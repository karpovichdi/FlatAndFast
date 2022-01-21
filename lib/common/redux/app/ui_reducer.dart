import 'package:flat_and_fast/common/redux/app/ui_state.dart';
import 'package:flat_and_fast/features/camera/redux/camera_reducer.dart';
import 'package:flat_and_fast/features/controls/redux/controls_reducer.dart';

UIState uiReducer(UIState state, dynamic action) {
  return state.rebuild(
        (builder) => builder
      ..gradientState.replace(controlsReducer(state.gradientState, action))
      ..cameraState.replace(cameraReducer(state.cameraState, action)),
  );
}
