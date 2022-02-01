import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseFile {
  FirebaseFile({
    this.ref,
    this.name,
    this.url,
    this.file,
  });

  Reference? ref;
  String? name;
  String? url;
  File? file;
}
