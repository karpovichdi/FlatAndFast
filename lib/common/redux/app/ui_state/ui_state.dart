import 'package:built_value/built_value.dart';
import 'package:flat_and_fast/features/camera/redux/camera_state.dart';
import 'package:flat_and_fast/features/controls/redux/controls_screen_state.dart';
import 'package:flat_and_fast/features/firebase/login/redux/firebase_login_state.dart';
import 'package:flat_and_fast/features/firebase/sign_up/redux/firebase_sign_up_state.dart';

import '../../../../features/firebase/home/redux/firebase_home_state.dart';

part 'ui_state.g.dart';

abstract class UIState implements Built<UIState, UIStateBuilder> {
  UIState._();

  factory UIState() {
    return _$UIState._(
      controlsState: ControlsScreenState.initial(),
      firebaseHomeState: FirebaseHomeState.initial(),
      cameraState: CameraState.initial(),
      firebaseLoginState: FirebaseLoginState.initial(),
      firebaseSignUpState: FirebaseSignUpState.initial(),
    );
  }

  ControlsScreenState get controlsState;

  FirebaseHomeState get firebaseHomeState;

  CameraState get cameraState;

  FirebaseLoginState get firebaseLoginState;

  FirebaseSignUpState get firebaseSignUpState;
}
