import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitable/models/account_model.dart';
import 'package:fitable/models/preference_model.dart';
import 'package:fitable/services/collections.dart';
import 'package:flutter/foundation.dart';

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class Database {
  Database({@required this.uid}) : assert(uid != null);
  final String uid;

  final _service = FirebaseFirestore.instance;

  //#region Account
  Future<void> createAccount(Account account) => _service.collection(Collections.account()).doc(uid).set(account.toMap());
  Future<void> updateAccount({@required dynamic name, @required dynamic value}) =>
      _service.collection(Collections.account()).doc(uid).update({name: value});
  Stream<Account> accountStream() => _service.collection(Collections.account()).doc(uid).snapshots().map(
        (snapshot) => Account.fromMap(snapshot.data(), snapshot.id),
      );
  //#endregion

  //#region Preference
  Future<void> createPreference(Preference preference) => _service.collection(Collections.preference()).doc(uid).set(preference.toMap());
  Future<void> updatePreference({@required dynamic name, @required dynamic value}) =>
      _service.collection(Collections.preference()).doc(uid).update({name: value});
  Stream<Preference> preferenceStream() => _service.collection(Collections.preference()).doc(uid).snapshots().map(
        (snapshot) => Preference.fromMap(snapshot.data(), snapshot.id),
      );
  //#endregion
}
