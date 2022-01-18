import 'dart:io';

import 'package:flat_and_fast/common/redux/app/app_state.dart';
import 'package:flat_and_fast/common/utils/log.dart';
import 'package:flat_and_fast/common/utils/storage/paths.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:redux/redux.dart';
import 'package:path/path.dart';
import 'package:redux_thunk/redux_thunk.dart';

const portraitVideoPath = 'assets/videos/portrait_video.mp4';
const horizontalVideoPath = 'assets/videos/Rick.mp4';
const imageName = 'avatar.jpg';
const videoName = 'video.mp4';

class LoadingAction {}

class PickImageAction {
  PickImageAction({
    required this.path,
  });

  final String? path;
}

class PlayAssetVideoAction {
  PlayAssetVideoAction({
    required this.path,
  });

  final String? path;
}

class PlayFileVideoAction {
  PlayFileVideoAction({
    required this.path,
  });

  final String? path;
}

ThunkAction<AppState> pickImage(ImageSource source) {
  return (Store<AppState> store) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final temporaryImage = await _saveFile(image.path, imageName);
      store.dispatch(
        PickImageAction(
          path: temporaryImage,
        ),
      );
    } on PlatformException catch (e) {
      print('User declined camera permissions: $e');
    }
  };
}

ThunkAction<AppState> pickVideo(ImageSource source) {
  return (Store<AppState> store) async {
    try {
      final video = await ImagePicker().pickVideo(source: source);
      if (video == null) return;

      var videoName = basename(video.path);
      final temporaryImage = await _saveFile(video.path, videoName);
      store.dispatch(
        PlayFileVideoAction(
          path: temporaryImage,
        ),
      );
    } on PlatformException catch (e) {
      print('User declined camera permissions: $e');
    }
  };
  }

  ThunkAction<AppState> playAssetVideo() {
    return (Store<AppState> store) async {
      try {
        store.dispatch(
          PlayAssetVideoAction(
            path: horizontalVideoPath,
          ),
        );
      } on PlatformException catch (e) {
        print('User declined camera permissions: $e');
      }
    };
  }

  ThunkAction<AppState> playPortraitVideo() {
    return (Store<AppState> store) async {
      try {
        store.dispatch(
          PlayAssetVideoAction(
            path: portraitVideoPath,
          ),
        );
      } on PlatformException catch (e) {
        print('User declined camera permissions: $e');
      }
    };
  }

ThunkAction<AppState> loadStorageImage(Log log) {
  return (Store<AppState> store) async {
    try {
      var newImagePath = '${Paths.documentsDir?.path}/$imageName';
      var file = File(newImagePath);
      if (await file.exists()) {
        store.dispatch(
          PickImageAction(
            path: newImagePath,
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  };
}

Future<String> _saveFile(String originalImagePath, String fileName) async {
  var newImagePath = '${Paths.documentsDir?.path}/$fileName';
  var newImage = File(newImagePath);
  if (await newImage.exists()) {
    newImage.delete();
  }
  await File(originalImagePath).copy(newImagePath);
  return newImagePath;
}
