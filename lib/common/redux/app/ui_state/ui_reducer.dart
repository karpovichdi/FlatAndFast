import 'package:flat_and_fast/common/redux/app/ui_state/ui_state.dart';
import 'package:flat_and_fast/features/camera/redux/camera_reducer.dart';
import 'package:flat_and_fast/features/controls/redux/controls_reducer.dart';
import 'package:flat_and_fast/features/firebase/login/redux/firebase_login_reducer.dart';
import 'package:flat_and_fast/features/firebase/sign_up/redux/firebase_sign_up_resucer.dart';

UIState uiReducer(UIState state, dynamic action) {
  return state.rebuild(
        (builder) => builder
      ..controlsState.replace(controlsReducer(state.controlsState, action))
      ..firebaseLoginState.replace(firebaseLoginReducer(state.firebaseLoginState, action))
      ..firebaseSignUpState.replace(firebaseSignUpReducer(state.firebaseSignUpState, action))
      ..cameraState.replace(cameraReducer(state.cameraState, action)),
  );
}
