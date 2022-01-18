import 'package:redux/redux.dart';

import 'camera_actions.dart';
import 'camera_state.dart';

final cameraReducer = combineReducers<CameraState>([
  TypedReducer<CameraState, LoadingAction>(_loading),
  TypedReducer<CameraState, PickImageAction>(_pickImage),
  TypedReducer<CameraState, PlayAssetVideoAction>(_playAssetVideo),
  TypedReducer<CameraState, PlayFileVideoAction>(_playFileVideo),
]);

CameraState _loading(CameraState state, LoadingAction action) {
  return state.rebuild((builder) => builder
    ..isLoading = true
    ..build());
}

CameraState _pickImage(CameraState state, PickImageAction action) {
  return state.rebuild((builder) => builder
    ..isLoading = false
    ..imagePath = action.path
    ..assetVideoPath = ''
    ..fileVideoPath = ''
    ..build());
}

CameraState _playAssetVideo(CameraState state, PlayAssetVideoAction action) {
  return state.rebuild((builder) => builder
    ..isLoading = false
    ..imagePath = ''
    ..assetVideoPath = action.path
    ..fileVideoPath = ''
    ..build());
}

CameraState _playFileVideo(CameraState state, PlayFileVideoAction action) {
  return state.rebuild((builder) => builder
    ..isLoading = false
    ..imagePath = ''
    ..assetVideoPath = ''
    ..fileVideoPath = action.path
    ..build());
}
