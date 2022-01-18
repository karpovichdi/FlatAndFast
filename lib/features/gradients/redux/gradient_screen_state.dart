import 'package:built_value/built_value.dart';

part 'gradient_screen_state.g.dart';

abstract class GradientScreenState implements Built<GradientScreenState, GradientScreenStateBuilder> {
  GradientScreenState._();

  factory GradientScreenState.initial() {
    return _$GradientScreenState._(isLoading: false);
  }

  factory GradientScreenState([void Function(GradientScreenStateBuilder)? updates]) = _$GradientScreenState;

  bool get isLoading;
}