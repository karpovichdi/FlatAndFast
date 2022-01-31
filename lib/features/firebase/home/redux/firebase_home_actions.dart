import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:path/path.dart';

import '../../../../common/redux/app/app_state.dart';
import '../firebase_feature.dart';

class FeatureChanged {
  FeatureChanged({required this.selectedFeature});

  final FirebaseFeature selectedFeature;
}

class FileSelected {
  FileSelected({required this.file});

  final File file;
}

class UploadProgress {
  UploadProgress({required this.uploadTask});

  final UploadTask? uploadTask;
}

ThunkAction<AppState> changeSelectedFeature(FirebaseFeature selectedFeature) {
  return (Store<AppState> store) async {
    store.dispatch(FeatureChanged(selectedFeature: selectedFeature));
  };
}

ThunkAction<AppState> selectFile() {
  return (Store<AppState> store) async {
    final result = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (result == null) return;
    var path = result.path;
    var file = File(path);
    store.dispatch(FileSelected(file: file));
  };
}

ThunkAction<AppState> uploadFile(File? selectedFile) {
  return (Store<AppState> store) async {
    try {
      if (selectedFile == null) return;

      var fileName = basename(selectedFile.path);
      var destination = 'files/$fileName';

      UploadTask? task = FirebaseApi.uploadFile(destination, selectedFile);
      store.dispatch(UploadProgress(uploadTask: task));

      if(task != null){
        final snapshot = await task.whenComplete(() => null);
        final urlDownload = await snapshot.ref.getDownloadURL();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  };
}

class FirebaseApi {
  static UploadTask? uploadFile(String destination, File file){
    try {
      var ref = FirebaseStorage.instance.ref(destination);
      return ref.putFile(file);
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }

  static UploadTask? uploadBytes(String destination, Uint8List data){
    try {
      var ref = FirebaseStorage.instance.ref(destination);
      return ref.putData(data);
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }
}
