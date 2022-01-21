import 'package:built_value/built_value.dart';

part 'controls_screen_state.g.dart';

abstract class ControlsScreenState implements Built<ControlsScreenState, ControlsScreenStateBuilder> {
  ControlsScreenState._();

  factory ControlsScreenState.initial() {
    return _$ControlsScreenState._(isLoading: false);
  }

  factory ControlsScreenState([void Function(ControlsScreenStateBuilder)? updates]) = _$ControlsScreenState;

  bool get isLoading;
}