import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitable/app/account/models/account_model.dart';
import 'package:fitable/app/account/models/preference_model.dart';
import 'package:fitable/app/product/models/product_model.dart';
import 'package:fitable/services/collections.dart';
import 'package:flutter/foundation.dart';

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class Database {
  Database({@required this.uid}) : assert(uid != null);
  final String uid;

  final _service = FirebaseFirestore.instance;

  //#region Account
  Future<void> createAccount(Account account) => _service.collection(Collections.accounts()).doc(uid).set(account.toMap());
  Future<void> updateAccount({@required dynamic name, @required dynamic value}) =>
      _service.collection(Collections.accounts()).doc(uid).update({name: value});
  Stream<Account> streamAccount() => _service.collection(Collections.accounts()).doc(uid).snapshots().map(
        (snapshot) => Account.fromMap(snapshot.data(), snapshot.id),
      );
  //#endregion

  //#region Preference
  Future<void> createPreference(Preference preference) => _service.collection(Collections.preferences()).doc(uid).set(preference.toMap());
  Future<void> updatePreference({@required dynamic name, @required dynamic value}) =>
      _service.collection(Collections.preferences()).doc(uid).update({name: value});
  Stream<Preference> streamPreference() => _service.collection(Collections.preferences()).doc(uid).snapshots().map(
        (snapshot) => Preference.fromMap(snapshot.data(), snapshot.id),
      );
  //#endregion

  //#region Product
  Future<void> createProduct(Product product) => _service.collection(Collections.products()).doc().set(product.toMap());
  Future<Product> getProduct(String barcode) => _service
      .collection(Collections.products())
      .where("barcode", isEqualTo: barcode)
      .get()
      .then((value) => value.docs.isNotEmpty ? Product.fromMap(value.docs.first.data(), value.docs.first.id) : null);
//#endregion
}
