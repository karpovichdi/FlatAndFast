import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flat_and_fast/common/redux/app/app_state.dart';
import 'package:flat_and_fast/features/firebase/home/firebase_feature.dart';
import 'package:redux/redux.dart';
import 'firebase_home_actions.dart' as actions;

class FirebaseHomeViewModel {
  FirebaseHomeViewModel({
    required this.isLoading,
    required this.selectedFeature,
    required this.changeSelectedFeature,
    required this.uploadTask,
    required this.selectFile,
    required this.uploadFile,
    required this.selectedFile,
  });

  final bool isLoading;
  final File? selectedFile;
  final FirebaseFeature selectedFeature;
  final UploadTask? uploadTask;

  final Function(FirebaseFeature) changeSelectedFeature;
  final Function selectFile;
  final Function uploadFile;

  static FirebaseHomeViewModel fromStore(Store<AppState> store) {
    var file = store.state.uiState.firebaseHomeState.selectedFile;
    return FirebaseHomeViewModel(
      isLoading: store.state.uiState.firebaseHomeState.isLoading,
      selectedFeature: store.state.uiState.firebaseHomeState.selectedFeature,
      uploadTask: store.state.uiState.firebaseHomeState.uploadTask,
      selectedFile: file,
      changeSelectedFeature: (selectedFeature) => store.dispatch(actions.changeSelectedFeature(selectedFeature)),
      selectFile: () => store.dispatch(actions.selectFile()),
      uploadFile: () => store.dispatch(actions.uploadFile(file)),
    );
  }
}
