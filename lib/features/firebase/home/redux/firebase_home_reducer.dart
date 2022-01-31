import 'package:redux/redux.dart';

import 'firebase_home_actions.dart';
import 'firebase_home_state.dart';

final firebaseHomeReducer = combineReducers<FirebaseHomeState>([
  TypedReducer<FirebaseHomeState, FeatureChanged>(_changeSelectedFeature),
  TypedReducer<FirebaseHomeState, FileSelected>(_selectedFileChanged),
  TypedReducer<FirebaseHomeState, UploadProgress>(_uploadProgressChanged),
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