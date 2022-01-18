import 'package:built_value/built_value.dart';
import 'package:flat_and_fast/features/gradients/redux/gradient_screen_state.dart';

part 'ui_state.g.dart';

abstract class UIState implements Built<UIState, UIStateBuilder> {
  UIState._();

  factory UIState() {
    return _$UIState._(
      gradientState: GradientScreenState.initial(),
    );
  }

  GradientScreenState get gradientState;
}
