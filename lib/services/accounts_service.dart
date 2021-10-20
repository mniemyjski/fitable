import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitable/services/services.dart';
import 'package:fitable/utilities/utilities.dart';
import 'package:flutter/foundation.dart';
import 'package:fitable/models/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

final providerAccountService = Provider<AccountService>((ref) {
  final auth = ref.watch(providerAuthState).data?.value;

  if (auth?.uid != null) {
    return AccountService(uid: auth?.uid);
  }
  return null;
});

final providerAccount = StreamProvider<Account>((ref) {
  final db = ref.watch(providerAccountService);

  return db.streamUserAccount();
});

abstract class _BaseAccountService {}

class AccountService extends _BaseAccountService {
  AccountService({@required this.uid}) : assert(uid != null);
  final String uid;
  final _service = FirebaseFirestore.instance;

  Future<void> createAccount(Account account) {
    Logger().i('create account');
    return _service.collection(Path.accounts()).doc(uid).set(account.toMap(uid: uid));
  }

  Future<void> updateAccount({@required dynamic name, @required dynamic value}) {
    Logger().i('update account');
    return _service.collection(Path.accounts()).doc(uid).update({name: value});
  }

  Stream<Account> streamUserAccount() {
    Logger().i('stream account');
    return _service.collection(Path.accounts()).doc(uid).snapshots().map(
          (snapshot) => Account.fromMap(snapshot.data()),
        );
  }

  Future<Account> getName(String uid) {
    Logger().i('get name');

    return _service.collection(Path.accounts()).doc(uid).get().then(
          (value) => Account.fromMap(value.data()),
        );
  }

  Future<bool> nameAvailable(String name) {
    Logger().i('name available');
    return _service.collection(Path.accounts()).where('name', isEqualTo: name).get().then(
          (value) => value.docs.isNotEmpty ? true : false,
        );
  }

  Future<Account> getAccount(String uid) {
    Logger().i('get account');
    return _service
        .collection(Path.accounts())
        .where(FieldPath.documentId, isEqualTo: uid)
        .get()
        .then((value) => value.docs.isNotEmpty ? Account.fromMap(value.docs.first.data()) : null);
  }
}
