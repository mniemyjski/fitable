import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fitable/app/account/models/account_model.dart';
import 'package:fitable/app/account/models/preference_model.dart';
import 'package:fitable/app/favorite/models/favorite_model.dart';
import 'package:fitable/app/issue/models/issue_report_model.dart';
import 'package:fitable/app/meal/models/ingredient_model.dart';
import 'package:fitable/app/meal/models/meal_model.dart';
import 'package:fitable/app/meal/models/portion_model.dart';
import 'package:fitable/app/meal/models/product_model.dart';
import 'package:fitable/app/meal/models/recipe_model.dart';
import 'package:fitable/app/measurement/models/measurement_model.dart';
import 'package:fitable/app/rating/models/rating_model.dart';
import 'package:fitable/utilities/enums.dart';
import 'package:fitable/services/application.dart';
import 'package:fitable/routers/path.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:logger/logger.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:image/image.dart' as i;

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class Database {
  Database({@required this.uid}) : assert(uid != null);
  final String uid;
  // final DateTime chosenDate;

  final _service = FirebaseFirestore.instance;

  //#region UploadFile
  Future<String> uploadToFirebaseStorage({@required File file, @required String folderName, String name}) async {
    firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
    String filePath = folderName == 'accounts' ? '$folderName/$uid/avatar/$uid' : '$folderName/$name';

    try {
      await storage.ref(filePath).putFile(file);
    } on firebase_core.FirebaseException catch (e) {}

    return await storage.ref(filePath).getDownloadURL();
  }

  //endregion

  //#region Account
  Future<void> createAccount(Account account) => _service.collection(Path.accounts()).doc(uid).set(account.toMap(uid: uid));
  Future<void> updateAccount({@required dynamic name, @required dynamic value}) =>
      _service.collection(Path.accounts()).doc(uid).update({name: value});
  Stream<Account> streamAccount() => _service.collection(Path.accounts()).doc(uid).snapshots().map(
        (snapshot) => Account.fromMap(snapshot.data()),
      );
  Future<Account> getName(String uid) => _service.collection(Path.accounts()).doc(uid).get().then(
        (value) => Account.fromMap(value.data()),
      );

  Future<bool> nameAvailable(String name) => _service.collection(Path.accounts()).where('name', isEqualTo: name).get().then(
        (value) => value.docs.isNotEmpty ? true : false,
      );

  Future<Account> getAccount(String uid) => _service
      .collection(Path.accounts())
      .where(FieldPath.documentId, isEqualTo: uid)
      .get()
      .then((value) => value.docs.isNotEmpty ? Account.fromMap(value.docs.first.data()) : null);

  Stream<List<Account>> streamAccounts(List list, bool followers) {
    List<String> _list = [];
    list.forEach((element) => followers ? _list.add(element.uid) : _list.add(element.id));

    if (list.isNotEmpty) {
      return _service
          .collection(Path.accounts())
          .where(FieldPath.documentId, whereIn: _list)
          .snapshots()
          .map((snapshot) => snapshot.docs.map((snap) => Account.fromMap(snap.data())).toList());
    } else {
      return null;
    }
  }

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

  Future<Product> getProduct({String barcode, String id}) => _service
      .collection(Path.products())
      .where(barcode != null ? "barcode" : FieldPath.documentId, isEqualTo: barcode != null ? barcode : id)
      .get()
      .then((value) => value.docs.isNotEmpty ? Product.fromMap(value.docs.first.data()) : null);

  Stream<List<Product>> streamProducts(List<Favorite> list) {
    List<String> _list = [];

    list.forEach((element) {
      _list.add(element.id);
    });

    if (_list.isNotEmpty) {
      return _service
          .collection(Path.products())
          .where(FieldPath.documentId, whereIn: _list)
          .snapshots()
          .map((snapshot) => snapshot.docs.map((snap) => Product.fromMap(snap.data())).toList());
    } else {
      return null;
    }
  }

  //#endregion

  //#region Issues
  Future<void> createIssue(Issue issuesReport) {
    String _path;
    if (issuesReport.elementType == ElementType.product) _path = Path.products();
    if (issuesReport.elementType == ElementType.recipe) _path = Path.recipes();

    final DocumentReference ref = _service.collection(_path).doc(issuesReport.id).collection(Path.issues()).doc(uid);
    return ref.set(issuesReport.toMap(uid));
  }

  Future<bool> alreadyIssue(String id, ElementType elementType) {
    String _path;
    if (elementType == ElementType.product) _path = Path.products();
    if (elementType == ElementType.recipe) _path = Path.recipes();
    return _service.collection(_path).doc(id).collection(Path.issues()).doc(uid).get().then(
          (value) => value.data() != null ? true : false,
        );
  }
  //#endregion

  //#region Meals
  Future<void> addMeal({@required Meal meal}) {
    final DocumentReference ref = _service.collection(Path.accounts()).doc(uid).collection(Path.meals()).doc();
    return ref.set(meal.toMap(ref.id, uid));
  }

  Future<void> updateMeal({
    @required Meal meal,
    @required Ingredient ingredient,
  }) =>
      _service.collection(Path.accounts()).doc(uid).collection(Path.meals()).doc(meal.id).update({
        'ingredient': ingredient.toMap(),
      });

  Future<void> updateSuggested({
    @required Meal meal,
    @required bool suggested,
  }) =>
      _service.collection(Path.accounts()).doc(uid).collection(Path.meals()).doc(meal.id).update({
        'isSuggested': suggested,
      });

  Future<void> deleteMeal(Meal meal) => _service.collection(Path.accounts()).doc(uid).collection(Path.meals()).doc(meal.id).delete();

  Stream<List<Meal>> streamMeals() => _service
      .collection(Path.accounts())
      .doc(uid)
      .collection(Path.meals())
      .snapshots()
      .map((snapshot) => snapshot.docs.map((snap) => Meal.fromMap(snap.data(), snap.id)).toList());
  //#endregion

  //#region Measurement
  Future<void> setMeasurement({@required Measurement measurement}) {
    final DocumentReference ref = _service.collection(Path.accounts()).doc(uid).collection(Path.measurements()).doc(measurement.id ?? null);
    return ref.set(measurement.toMap(ref.id, uid));
  }

  Future<void> deleteMeasurement(Measurement measurement) =>
      _service.collection(Path.accounts()).doc(uid).collection(Path.measurements()).doc(measurement.id).delete();

  Stream<List<Measurement>> streamMeasurement() => _service
      .collection(Path.accounts())
      .doc(uid)
      .collection(Path.measurements())
      .snapshots()
      .map((snapshot) => snapshot.docs.map((snap) => Measurement.fromMap(snap.data(), snap.id)).toList());
  //endregion

  //#region Ratings
  updateRating(BuildContext context, Rating rating) {
    final DocumentReference ref = _service.collection(Path.recipes()).doc(rating.id).collection(Path.ratings()).doc(uid);

    ref.set(rating.toMap(uid, rating.id));
  }
  //endregion

  //#region Favorite
  updateFavorite(BuildContext context, Favorite favorite) {
    String _path;
    if (favorite.type == EnumFavorite.products) _path = Path.products();
    if (favorite.type == EnumFavorite.recipes) _path = Path.recipes();
    if (favorite.type == EnumFavorite.exercise) _path = Path.products();
    if (favorite.type == EnumFavorite.trainings) _path = Path.products();
    if (favorite.type == EnumFavorite.accounts) _path = Path.accounts();

    final DocumentReference ref = _service.collection(_path).doc(favorite.id).collection(Path.favorites()).doc(uid);
    bool _isFavorite = false;

    context.read(providerFavorite).whenData((value) {
      value.forEach((element) {
        if (element.id == favorite.id) {
          ref.delete();
          _isFavorite = true;
        }
      });
      if (!_isFavorite) ref.set(favorite.toMap(uid));
    });
  }

  Stream<List<Favorite>> streamFavorites() {
    final ref = _service.collectionGroup(Path.favorites()).where('uid', isEqualTo: uid).snapshots();

    return ref.map((snapshot) => snapshot.docs.map((snap) => Favorite.fromMap(snap.data(), snap.id)).toList());
  }

  Stream<List<Favorite>> streamFollowers() {
    final ref = _service.collection(Path.accounts()).doc(uid).collection(Path.favorites()).snapshots();
    return ref.map((snapshot) => snapshot.docs.map((snap) => Favorite.fromMap(snap.data(), snap.id)).toList());
  }

  // Future<bool> isFollower(String follower) {
  //   return _service.collection(Path.accounts()).doc(uid).collection(Path.favorites()).doc(follower).get().then((value) => value.data().isNotEmpty);
  // }

  //endregion

  //#region recipe

  Future<void> deleteRecipe(Recipe recipe) => _service.collection(Path.recipes()).doc(recipe.id).delete();

  Future<bool> createRecipe({
    @required String authorName,
    @required String localeBase,
    @required String name,
    @required String access,
    @required String description,
    @required Duration timePreparation,
    @required String videoUrl,
    @required List keyWords,
    @required List photos,
    @required List<Ingredient> ingredients,
    @required List<Portion> portions,
    Recipe oldRecipe,
  }) async {
    final DocumentReference ref = _service.collection(Path.recipes()).doc(oldRecipe?.id ?? null);

    List _photosUrl = [];

    for (String element in photos) {
      if (element.substring(0, 4) != 'http') {
        File _file = File(element);
        String url = await uploadToFirebaseStorage(file: _file, folderName: "recipes/${ref.id}", name: photos.indexOf(element).toString());
        _photosUrl.add(url);
      } else {
        _photosUrl.add(element);
      }
    }

    Recipe _recipe = Recipe(
      authorName: authorName,
      localeBase: localeBase,
      name: name,
      keyWords: keyWords,
      description: description,
      videoUrl: videoUrl,
      photosUrl: _photosUrl,
      access: access,
      ingredients: ingredients,
      portions: portions,
      timePreparation: timePreparation,
      verification: false,
      ratingsAvg: oldRecipe?.ratingsAvg ?? null,
      ratingsCount: oldRecipe?.ratingsCount ?? null,
      favoritesCount: oldRecipe?.favoritesCount ?? null,
      commentsCount: oldRecipe?.commentsCount ?? null,
      dateCreation: oldRecipe?.dateCreation ?? null,
    );

    await ref.set(_recipe.toMap(uid: uid, id: ref.id));

    return true;
  }

  Future<Recipe> getRecipe(String id) => _service
      .collection(Path.recipes())
      .where(FieldPath.documentId, isEqualTo: id)
      .get()
      .then((value) => value.docs.isNotEmpty ? Recipe.fromMap(value.docs.first.data()) : null);

  Stream<List<Recipe>> streamFavoriteRecipes(List<Favorite> list) {
    List<String> _list = [];

    list.forEach((element) {
      _list.add(element.id);
    });

    if (_list.isNotEmpty) {
      return _service
          .collection(Path.recipes())
          .where(FieldPath.documentId, whereIn: _list)
          .snapshots()
          .map((snapshot) => snapshot.docs.map((snap) => Recipe.fromMap(snap.data())).toList());
    } else {
      return null;
    }
  }

  Stream<List<Recipe>> streamYourRecipes() {
    return _service
        .collection(Path.recipes())
        .where('uid', isEqualTo: uid)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((snap) => Recipe.fromMap(snap.data())).toList());
  }

  Stream<List<Recipe>> streamRecipes(SortType sortType) {
    String name = "";

    if (sortType == SortType.last) name = "dateCreation";
    if (sortType == SortType.best) name = "ratingsAvg";
    if (sortType == SortType.popular) name = "favoritesCount";

    return _service
        .collection(Path.recipes())
        .orderBy(name, descending: true)
        .limit(10)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((snap) => Recipe.fromMap(snap.data())).toList());
  }

  //endregion

}
