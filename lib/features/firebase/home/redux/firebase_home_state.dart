import 'dart:io';

import 'package:built_value/built_value.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../firebase_feature.dart';

part 'firebase_home_state.g.dart';

abstract class FirebaseHomeState implements Built<FirebaseHomeState, FirebaseHomeStateBuilder> {
  FirebaseHomeState._();

  factory FirebaseHomeState.initial() {
    return _$FirebaseHomeState._(
      isLoading: false,
      selectedFeature: FirebaseFeature.fileUpload,
    );
  }

  factory FirebaseHomeState([void Function(FirebaseHomeStateBuilder)? updates]) = _$FirebaseHomeState;

  bool get isLoading;

  File? get selectedFile;

  UploadTask? get uploadTask;

  FirebaseFeature get selectedFeature;
}
