import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitable/services/services.dart';
import 'package:fitable/utilities/utilities.dart';
import 'package:flutter/foundation.dart';
import 'package:fitable/models/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

final providerMealsService = Provider<MealsService>((ref) {
  final auth = ref.watch(providerAuthState).data?.value;

  if (auth?.uid != null) {
    return MealsService(uid: auth?.uid);
  }
  return null;
});

final providerMeals = StreamProvider<List<Meal>>((ref) {
  final db = ref.watch(providerMealsService);

  return db.streamMeals();
});

abstract class _BaseMealsService {}

class MealsService {
  MealsService({@required this.uid}) : assert(uid != null);
  final String uid;
  final _service = FirebaseFirestore.instance;

  Future<void> addMeal({@required Meal meal}) {
    Logger().i('add meal');
    final DocumentReference ref = _service.collection(Path.accounts()).doc(uid).collection(Path.meals()).doc();
    return ref.set(meal.toMap(ref.id, uid));
  }

  Future<void> updateMeal({
    @required Meal meal,
    @required Ingredient ingredient,
  }) {
    Logger().i('update meal');
    return _service.collection(Path.accounts()).doc(uid).collection(Path.meals()).doc(meal.id).update({
      'ingredient': ingredient.toMap(),
    });
  }

  Future<void> updateSuggested({
    @required Meal meal,
    @required bool suggested,
  }) {
    Logger().i('update suggested');
    return _service.collection(Path.accounts()).doc(uid).collection(Path.meals()).doc(meal.id).update({
      'isSuggested': suggested,
    });
  }

  Future<void> deleteMeal(Meal meal) {
    Logger().i('delete meal');
    return _service.collection(Path.accounts()).doc(uid).collection(Path.meals()).doc(meal.id).delete();
  }

  Stream<List<Meal>> streamMeals() {
    Logger().i('stream meal');
    return _service
        .collection(Path.accounts())
        .doc(uid)
        .collection(Path.meals())
        .snapshots()
        .map((snapshot) => snapshot.docs.map((snap) => Meal.fromMap(snap.data(), snap.id)).toList());
  }
}
