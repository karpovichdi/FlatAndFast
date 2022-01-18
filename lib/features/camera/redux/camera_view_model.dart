import 'package:flat_and_fast/common/redux/app/app_state.dart';
import 'package:flat_and_fast/common/utils/log.dart';
import 'package:image_picker/image_picker.dart';
import 'package:redux/redux.dart';

import 'camera_actions.dart' as actions;

class CameraViewModel {
  CameraViewModel({
    required this.pickImage,
    required this.pickVideo,
    required this.isLoading,
    required this.loadStorageImage,
    required this.playVideo,
    required this.playPortraitVideo,
    required this.imagePath,
    required this.assetVideoPath,
    required this.fileVideoPath,
  });

  final bool isLoading;

  final String imagePath;

  final String assetVideoPath;

  final String fileVideoPath;

  final Function(ImageSource) pickImage;

  final Function(ImageSource) pickVideo;

  final Function(Log) loadStorageImage;

  final Function() playVideo;

  final Function() playPortraitVideo;

  static CameraViewModel fromStore(Store<AppState> store) {
    return CameraViewModel(
      isLoading: store.state.uiState.cameraState.isLoading,
      imagePath: store.state.uiState.cameraState.imagePath,
      assetVideoPath: store.state.uiState.cameraState.assetVideoPath,
      fileVideoPath: store.state.uiState.cameraState.fileVideoPath,
      pickImage: (source) => store.dispatch(actions.pickImage(source)),
      playVideo: () => store.dispatch(actions.playAssetVideo()),
      playPortraitVideo: () => store.dispatch(actions.playPortraitVideo()),
      pickVideo: (source) => store.dispatch(actions.pickVideo(source)),
      loadStorageImage: (log) => store.dispatch(actions.loadStorageImage(log)),
    );
  }
}
