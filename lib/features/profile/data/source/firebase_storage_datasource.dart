import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageDatasource {
  final FirebaseStorage _storage;
  FirebaseStorageDatasource({required FirebaseStorage storage})
    : _storage = storage;

  Future<void> uploadFile(String path, String filePath) async {
    final file = File(filePath);
    await _storage.ref(path).putFile(file);
  }
}
