import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitable/app/account/models/account_model.dart';
import 'package:fitable/app/account/models/preference_model.dart';
import 'package:fitable/app/product/models/meal_model.dart';
import 'package:fitable/app/product/models/product_model.dart';
import 'package:fitable/services/path.dart';
import 'package:flutter/foundation.dart';

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class Database {
  Database({@required this.uid}) : assert(uid != null);
  final String uid;

  final _service = FirebaseFirestore.instance;

  //#region Account
  Future<void> createAccount(Account account) => _service.collection(Path.accounts()).doc(uid).set(account.toMap());
  Future<void> updateAccount({@required dynamic name, @required dynamic value}) =>
      _service.collection(Path.accounts()).doc(uid).update({name: value});
  Stream<Account> streamAccount() => _service.collection(Path.accounts()).doc(uid).snapshots().map(
        (snapshot) => Account.fromMap(snapshot.data(), snapshot.id),
      );
  //#endregion

  //#region Preference
  Future<void> createPreference(Preference preference) => _service.collection(Path.preferences()).doc(uid).set(preference.toMap());
  Future<void> updatePreference({@required dynamic name, @required dynamic value}) =>
      _service.collection(Path.preferences()).doc(uid).update({name: value});
  Stream<Preference> streamPreference() => _service.collection(Path.preferences()).doc(uid).snapshots().map(
        (snapshot) => Preference.fromMap(snapshot.data(), snapshot.id),
      );
  //#endregion

  //#region Product
  Future<void> createProduct(Product product) {
    final DocumentReference ref = _service.collection(Path.products()).doc();
    return ref.set(product.toMap(id: ref.id));
  }

  Future<Product> getProduct(String barcode) => _service
      .collection(Path.products())
      .where("barcode", isEqualTo: barcode)
      .get()
      .then((value) => value.docs.isNotEmpty ? Product.fromMap(value.docs.first.data(), value.docs.first.id) : null);
  //#endregion

  //#region Meals
  Future<void> setMeal({@required Meal meal, String id}) {
    final DocumentReference ref = _service.collection(Path.accounts()).doc(uid).collection(Path.meals()).doc(id ?? null);
    return ref.set(meal.toMap(ref.id));
  }

  Future<void> updateMeal({
    @required Meal meal,
    @required double portionSize,
    @required String portionChosen,
  }) =>
      _service.collection(Path.accounts()).doc(uid).collection(Path.meals()).doc(meal.id).update({
        'portionSize': portionSize,
        'portionChosen': portionChosen,
      });

  Future<void> deleteMeal(Meal meal) => _service.collection(Path.accounts()).doc(uid).collection(Path.meals()).doc(meal.id).delete();

  Stream<List<Meal>> streamMeals() => _service
      .collection(Path.accounts())
      .doc(uid)
      .collection(Path.meals())
      .snapshots()
      .map((snapshot) => snapshot.docs.map((snap) => Meal.fromMap(snap.data(), snap.id)).toList());
  //#endregion
}
