import 'package:redux/redux.dart';

import 'firebase_home_actions.dart';
import 'firebase_home_state.dart';

final firebaseHomeReducer = combineReducers<FirebaseHomeState>([
  TypedReducer<FirebaseHomeState, FeatureChanged>(_changeSelectedFeature),
  TypedReducer<FirebaseHomeState, FileSelected>(_selectedFileChanged),
  TypedReducer<FirebaseHomeState, UploadProgress>(_uploadProgressChanged),
  TypedReducer<FirebaseHomeState, FilesDownloaded>(_thumbnailsDownloaded),
  TypedReducer<FirebaseHomeState, FileUploaded>(_fileUploaded),
  TypedReducer<FirebaseHomeState, FakeFileUploaded>(_fakeFileUploaded),
  TypedReducer<FirebaseHomeState, FileDownloading>(_fileDownloading),
  TypedReducer<FirebaseHomeState, FileDownloaded>(_fileDownloaded),
  TypedReducer<FirebaseHomeState, OpenImage>(_openImage),
  TypedReducer<FirebaseHomeState, CloseImage>(_closeImage),
  TypedReducer<FirebaseHomeState, ChangeApi>(_changeApi),
]);

FirebaseHomeState _changeSelectedFeature(FirebaseHomeState state, FeatureChanged action) {
  return state.rebuild((builder) => builder
    ..selectedFeature = action.selectedFeature
    ..build());
}

FirebaseHomeState _selectedFileChanged(FirebaseHomeState state, FileSelected action) {
  return state.rebuild((builder) => builder
    ..selectedFile = action.file
    ..build());
}

FirebaseHomeState _uploadProgressChanged(FirebaseHomeState state, UploadProgress action) {
  return state.rebuild((builder) => builder
    ..uploadTask = action.uploadTask
    ..build());
}

FirebaseHomeState _openImage(FirebaseHomeState state, OpenImage action) {
  return state.rebuild((builder) => builder
    ..openedImage = action.file
    ..build());
}

FirebaseHomeState _closeImage(FirebaseHomeState state, CloseImage action) {
  return state.rebuild((builder) => builder
    ..openedImage = null
    ..build());
}

FirebaseHomeState _changeApi(FirebaseHomeState state, ChangeApi action) {
  return state.rebuild((builder) => builder
    ..realApi = !state.realApi
    ..build());
}

FirebaseHomeState _fileDownloading(FirebaseHomeState state, FileDownloading action) {
  state.downloadingFiles.add(action.file);
  return state.rebuild((builder) => builder
    ..downloadingFiles = state.downloadingFiles
    ..build());
}

FirebaseHomeState _fileDownloaded(FirebaseHomeState state, FileDownloaded action) {
  state.downloadingFiles.remove(action.file);
  state.downloadedFiles.add(action.file);
  return state.rebuild((builder) => builder
    ..downloadingFiles = state.downloadingFiles
    ..downloadedFiles = state.downloadedFiles
    ..build());
}

FirebaseHomeState _fileUploaded(FirebaseHomeState state, FileUploaded action) {
  if (state.selectedFile != null) {
    state.thumbnails?.add(state.selectedFile!);
  }

  return state.rebuild((builder) => builder
    ..selectedFile = null
    ..uploadTask = null
    ..thumbnails = state.thumbnails
    ..build());
}

FirebaseHomeState _fakeFileUploaded(FirebaseHomeState state, FakeFileUploaded action) {
  return state.rebuild((builder) => builder
    ..selectedFile = null
    ..uploadTask = null
    ..thumbnails = state.thumbnails
    ..build());
}

FirebaseHomeState _thumbnailsDownloaded(FirebaseHomeState state, FilesDownloaded action) {
  return state.rebuild((builder) => builder
    ..thumbnails = action.files
    ..isLoading = false
    ..build());
}
