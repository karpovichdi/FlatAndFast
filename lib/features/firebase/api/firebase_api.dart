import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

import '../../../common/utils/storage/paths.dart';
import '../home/data/firebase_file.dart';

class FirebaseApi {
  static UploadTask? uploadFile(String destination, File file) {
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

  static UploadTask? uploadBytes(String destination, Uint8List data) {
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

  static Future<List<FirebaseFile>?> listAllFiles({String path = 'files/'}) async {
    try {
      var ref = FirebaseStorage.instance.ref(path);
      final ListResult result = await ref.listAll();
      final List<String> urls = await _getDownloadLinks(result.items);

      return urls
          .asMap()
          .map((index, url) {
            final Reference ref = result.items[index];
            final name = ref.name;
            final file = FirebaseFile(url: url, name: name, ref: ref);

            return MapEntry(index, file);
          })
          .values
          .toList();
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }

  static Future<String> downloadFile(Reference ref) async {
    var path = '${Paths.documentsDir?.path}/${ref.name}';
    var file = File(path);
    await ref.writeToFile(file);
    return path;
  }
}

Future<List<String>> _getDownloadLinks(List<Reference> items) => Future.wait(items.map((item) => item.getDownloadURL()).toList());
