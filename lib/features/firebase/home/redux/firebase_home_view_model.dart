import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flat_and_fast/common/redux/app/app_state.dart';
import 'package:flat_and_fast/features/firebase/home/data/firebase_file.dart';
import 'package:flat_and_fast/features/firebase/home/firebase_feature.dart';
import 'package:redux/redux.dart';
import 'firebase_home_actions.dart' as actions;

class FirebaseHomeViewModel {
  FirebaseHomeViewModel({
    required this.isLoading,
    required this.realApi,
    required this.selectedFeature,
    required this.changeSelectedFeature,
    required this.uploadTask,
    required this.selectFile,
    required this.uploadFile,
    required this.openImage,
    required this.shareImage,
    required this.closeImage,
    required this.openedImage,
    required this.changeApi,
    required this.listAllThumbnails,
    required this.thumbnails,
    required this.downloadingFiles,
    required this.downloadedFiles,
    required this.selectedFile,
    required this.downloadFile,
  });

  final bool isLoading;
  final bool realApi;
  final FirebaseFile? selectedFile;
  final FirebaseFile? openedImage;
  final List<FirebaseFile>? thumbnails;
  final List<FirebaseFile> downloadingFiles;
  final List<FirebaseFile> downloadedFiles;
  final FirebaseFeature selectedFeature;
  final UploadTask? uploadTask;

  final Function(FirebaseFeature) changeSelectedFeature;
  final Function(FirebaseFile?) downloadFile;
  final Function(FirebaseFile?) openImage;
  final Function(FirebaseFile?) shareImage;
  final Function selectFile;
  final Function closeImage;
  final Function uploadFile;
  final Function changeApi;
  final Function listAllThumbnails;

  static FirebaseHomeViewModel fromStore(Store<AppState> store) {
    var file = store.state.uiState.firebaseHomeState.selectedFile;
    var realApi = store.state.uiState.firebaseHomeState.realApi;
    return FirebaseHomeViewModel(
      isLoading: store.state.uiState.firebaseHomeState.isLoading,
      realApi: realApi,
      selectedFeature: store.state.uiState.firebaseHomeState.selectedFeature,
      uploadTask: store.state.uiState.firebaseHomeState.uploadTask,
      thumbnails: store.state.uiState.firebaseHomeState.thumbnails,
      downloadingFiles: store.state.uiState.firebaseHomeState.downloadingFiles,
      downloadedFiles: store.state.uiState.firebaseHomeState.downloadedFiles,
      openedImage: store.state.uiState.firebaseHomeState.openedImage,
      selectedFile: file,
      changeSelectedFeature: (selectedFeature) => store.dispatch(actions.changeSelectedFeature(selectedFeature)),
      selectFile: () => store.dispatch(actions.selectFile()),
      changeApi: () => store.dispatch(actions.changeApi()),
      openImage: (file) => store.dispatch(actions.openImage(file)),
      shareImage: (file) => store.dispatch(actions.shareImage(file)),
      closeImage: () => store.dispatch(actions.closeImage()),
      downloadFile: (file) => store.dispatch(actions.downloadSelectedFile(file, realApi)),
      listAllThumbnails: () => store.dispatch(actions.listAllFiles(realApi)),
      uploadFile: () => store.dispatch(actions.uploadFile(file, realApi)),
    );
  }
}
