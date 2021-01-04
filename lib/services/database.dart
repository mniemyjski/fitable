import 'package:fitable/models/account_model.dart';
import 'package:fitable/services/api_path.dart';
import 'package:fitable/services/firestore_services.dart';
import 'package:flutter/foundation.dart';

abstract class Database {
  Future<void> createUser(User user);
  Stream<List<User>> userStream();
}

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase implements Database {
  FirestoreDatabase({@required this.uid}) : assert(uid != null);
  final String uid;

  final _service = FirestoreService.instance;

  Future<void> createUser(User user) => _service.setData(
        path: APIPath.user(uid),
        data: user.toMap(),
      );

  Stream<List<User>> userStream() => _service.collectionStream(
        path: APIPath.user(uid),
        builder: (data, documentId) => User.fromMap(data, documentId),
      );
}
