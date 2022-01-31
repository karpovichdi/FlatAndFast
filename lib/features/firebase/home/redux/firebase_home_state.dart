import 'package:built_value/built_value.dart';

part 'firebase_home_state.g.dart';

abstract class FirebaseHomeState implements Built<FirebaseHomeState, FirebaseHomeStateBuilder> {
  FirebaseHomeState._();

  factory FirebaseHomeState.initial() {
    return _$FirebaseHomeState._(
      isLoading: false,
    );
  }

  factory FirebaseHomeState([void Function(FirebaseHomeStateBuilder)? updates]) = _$FirebaseHomeState;

  bool get isLoading;
}
