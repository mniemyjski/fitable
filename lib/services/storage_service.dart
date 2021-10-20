import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitable/services/services.dart';
import 'package:fitable/utilities/utilities.dart';
import 'package:flutter/foundation.dart';
import 'package:fitable/models/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

final providerStorageService = Provider<StorageService>((ref) {
  final auth = ref.watch(providerAuthState).data?.value;

  if (auth?.uid != null) {
    return StorageService(uid: auth?.uid);
  }
  return null;
});

abstract class _BaseStorageService {}

class StorageService {
  StorageService({@required this.uid}) : assert(uid != null);
  final String uid;

  Future<String> uploadToFirebaseStorage({Uint8List uint8List, @required String folderName, String name}) async {
    firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
    String filePath = folderName == 'accounts' ? '$folderName/$uid/avatar/$uid' : '$folderName/$name';

    try {
      await storage.ref(filePath).putData(uint8List);
    } on firebase_core.FirebaseException catch (e) {}

    return await storage.ref(filePath).getDownloadURL();
  }
}
