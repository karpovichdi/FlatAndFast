import 'dart:io';

import 'package:built_value/built_value.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../data/firebase_file.dart';
import '../firebase_feature.dart';

part 'firebase_home_state.g.dart';

abstract class FirebaseHomeState implements Built<FirebaseHomeState, FirebaseHomeStateBuilder> {
  FirebaseHomeState._();

  factory FirebaseHomeState.initial() {
    return _$FirebaseHomeState._(
      isLoading: false,
      realApi: false,
      downloadingFiles: [],
      downloadedFiles: [],
      selectedFeature: FirebaseFeature.fileUpload,
    );
  }

  factory FirebaseHomeState([void Function(FirebaseHomeStateBuilder)? updates]) = _$FirebaseHomeState;

  bool get isLoading;

  bool get realApi;

  FirebaseFile? get selectedFile;

  UploadTask? get uploadTask;

  List<FirebaseFile>? get thumbnails;

  List<FirebaseFile> get downloadingFiles;

  List<FirebaseFile> get downloadedFiles;

  FirebaseFeature get selectedFeature;

  FirebaseFile? get openedImage;
}
