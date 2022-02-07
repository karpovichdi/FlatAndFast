import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flat_and_fast/common/utils/storage/paths.dart';
import 'package:flat_and_fast/features/firebase/home/data/firebase_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:path/path.dart';
import 'package:share/share.dart' as share;

import '../../../../common/redux/app/app_state.dart';
import '../../api/firebase_api.dart';
import '../firebase_feature.dart';

class FeatureChanged {
  FeatureChanged({required this.selectedFeature});

  final FirebaseFeature selectedFeature;
}

class FileUploaded {
  FileUploaded();
}

class FakeFileUploaded {
  FakeFileUploaded();
}

class ChangeApi {
  ChangeApi();
}

class FileSelected {
  FileSelected({required this.file});

  final FirebaseFile file;
}

class FilesDownloaded {
  FilesDownloaded({required this.files});

  final List<FirebaseFile>? files;
}

class FileDownloading {
  FileDownloading({required this.file});

  final FirebaseFile file;
}

class FileDownloaded {
  FileDownloaded({required this.file});

  final FirebaseFile file;
}

class OpenImage {
  OpenImage({required this.file});

  final FirebaseFile file;
}

class ShareImage {
  ShareImage({required this.file});

  final FirebaseFile file;
}

class CloseImage {
  CloseImage();
}

class UploadProgress {
  UploadProgress({required this.uploadTask});

  final UploadTask? uploadTask;
}

class LoadingStateChangedAction {
  LoadingStateChangedAction({
    required this.isLoading,
  });

  final bool isLoading;
}

ThunkAction<AppState> changeSelectedFeature(FirebaseFeature selectedFeature) {
  return (Store<AppState> store) async {
    store.dispatch(FeatureChanged(selectedFeature: selectedFeature));
  };
}

ThunkAction<AppState> changeApi() {
  return (Store<AppState> store) async {
    store.dispatch(ChangeApi());
  };
}

ThunkAction<AppState> selectFile() {
  return (Store<AppState> store) async {
    final result = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (result == null) return;
    var path = result.path;
    var file = File(path);
    store.dispatch(FileSelected(file: FirebaseFile(file: file)));
  };
}

ThunkAction<AppState> downloadSelectedFile(FirebaseFile? firebaseFile, bool realApi) {
  return (Store<AppState> store) async {
    if (firebaseFile == null) return;

    store.dispatch(FileDownloading(file: firebaseFile));
    File file;

    if (realApi) {
      var path = await FirebaseApi.downloadFile(firebaseFile.ref!);
      file = File(path);
    } else {
      file = await downloadFileDEBUG(firebaseFile.url ?? '', UniqueKey().toString(), Paths.documentsDir?.path ?? '');
    }

    firebaseFile.file = file;
    store.dispatch(FileDownloaded(file: firebaseFile));
  };
}

ThunkAction<AppState> openImage(FirebaseFile? file) {
  return (Store<AppState> store) async {
    if (file == null) return;
    store.dispatch(OpenImage(file: file));
  };
}

ThunkAction<AppState> shareImage(FirebaseFile? file) {
  return (Store<AppState> store) async {
    if (file == null) return;

    var path = file.file!.path;

    share.Share.shareFiles([path]);
    store.dispatch(ShareImage(file: file));
  };
}

ThunkAction<AppState> closeImage() {
  return (Store<AppState> store) async {
    store.dispatch(CloseImage());
  };
}

ThunkAction<AppState> uploadFile(FirebaseFile? selectedFile, bool realApi) {
  return (Store<AppState> store) async {
    if (!realApi) {
      store.dispatch(FakeFileUploaded());
      return;
    }

    try {
      if (selectedFile == null || selectedFile.file == null) return;

      File file = selectedFile.file!;

      var fileName = basename(file.path);
      var destination = 'files/$fileName';

      UploadTask? task = FirebaseApi.uploadFile(destination, selectedFile.file!);
      store.dispatch(UploadProgress(uploadTask: task));

      if (task != null) {
        final snapshot = await task.whenComplete(() => null);
        final String urlDownload = await snapshot.ref.getDownloadURL();

        selectedFile.name = fileName;
        selectedFile.url = urlDownload;
        selectedFile.ref = snapshot.ref;

        store.dispatch(FileUploaded());
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  };
}

ThunkAction<AppState> listAllFiles(bool realApi) {
  return (Store<AppState> store) async {
    store.dispatch(LoadingStateChangedAction(isLoading: true));
    List<FirebaseFile>? listAllFiles;
    if (realApi) {
      listAllFiles = await FirebaseApi.listAllFiles();
    } else {
      listAllFiles = fakeImageUrls
          .map(
            (url) => FirebaseFile(
              ref: null,
              name: basename(url),
              url: url,
            ),
          )
          .toList();
    }
    store.dispatch(FilesDownloaded(files: listAllFiles));
  };
}

List<String> fakeImageUrls = [
  'https://www.applevacations.com/siteassets/content/images/destination-images/caribbean/barbados/barbados1.jpg',
  'https://www.beach.com/wp-content/uploads/2019/04/rsz_shutterstock_678305578.jpg',
  'https://lprluxury.com/wp-content/uploads/2014/02/villapontoquito1-00001.jpg',
  'https://www.lateet.com/wp-content/uploads/2018/09/colorado-vacation.jpeg',
  'https://www.zicasso.com/sites/default/files/styles/original_scaled_down/public/photos/tour/shutterstock_58941373.jpg',
  'https://www.applevacations.com/siteassets/content/images/destination-images/caribbean/barbados/barbados1.jpg',
  'https://www.beach.com/wp-content/uploads/2019/04/rsz_shutterstock_678305578.jpg',
  'https://lprluxury.com/wp-content/uploads/2014/02/villapontoquito1-00001.jpg',
  'https://www.lateet.com/wp-content/uploads/2018/09/colorado-vacation.jpeg',
  'https://www.zicasso.com/sites/default/files/styles/original_scaled_down/public/photos/tour/shutterstock_58941373.jpg',
];

Future<File> downloadFileDEBUG(String url, String fileName, String dir) async {
  HttpClient httpClient = HttpClient();
  File file;
  String filePath = '';

  try {
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    if (response.statusCode == 200) {
      var bytes = await consolidateHttpClientResponseBytes(response);
      filePath = '$dir/$fileName.jpg';
      file = File(filePath);
      await file.writeAsBytes(bytes);
    } else {
      filePath = 'Error code: ' + response.statusCode.toString();
    }
  } catch (ex) {
    filePath = 'Can not fetch url';
  }

  return File(filePath);
}
