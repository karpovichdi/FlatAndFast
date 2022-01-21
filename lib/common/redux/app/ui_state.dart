import 'package:built_value/built_value.dart';
import 'package:flat_and_fast/features/camera/redux/camera_state.dart';
import 'package:flat_and_fast/features/controls/redux/controls_screen_state.dart';

part 'ui_state.g.dart';

abstract class UIState implements Built<UIState, UIStateBuilder> {
  UIState._();

  factory UIState() {
    return _$UIState._(
      gradientState: ControlsScreenState.initial(),
      cameraState: CameraState.initial(),
    );
  }

  ControlsScreenState get gradientState;

  CameraState get cameraState;
}
