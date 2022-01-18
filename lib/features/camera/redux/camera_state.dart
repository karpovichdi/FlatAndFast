import 'package:built_value/built_value.dart';

part 'camera_state.g.dart';

abstract class CameraState implements Built<CameraState, CameraStateBuilder> {
  CameraState._();

  factory CameraState.initial() {
    return _$CameraState._(isLoading: false, imagePath: '', assetVideoPath: '', fileVideoPath: '');
  }

  factory CameraState([void Function(CameraStateBuilder)? updates]) = _$CameraState;

  bool get isLoading;

  String get imagePath;

  String get assetVideoPath;

  String get fileVideoPath;
}