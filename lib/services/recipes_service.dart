import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitable/common_widgets/carousel/models/box_model.dart';
import 'package:fitable/services/services.dart';
import 'package:fitable/utilities/utilities.dart';
import 'package:flutter/foundation.dart';
import 'package:fitable/models/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

final providerRecipesService = Provider<RecipesService>((ref) {
  final auth = ref.watch(providerAuthState).data?.value;
  final storageService = ref.watch(providerStorageService);

  if (auth?.uid != null) {
    return RecipesService(uid: auth?.uid, storageService: storageService);
  }
  return null;
});

final providerRecipesNew = StreamProvider<List<Recipe>>((ref) {
  final db = ref.watch(providerRecipesService);

  return db.streamRecipesNew();
});

final providerRecipesPopular = StreamProvider<List<Recipe>>((ref) {
  final db = ref.watch(providerRecipesService);

  return db.streamRecipesPopular();
});

final providerRecipesRatings = StreamProvider<List<Recipe>>((ref) {
  final db = ref.watch(providerRecipesService);

  return db.streamRecipesRating();
});

final providerYourRecipes = StreamProvider<List<Recipe>>((ref) {
  final db = ref.watch(providerRecipesService);

  return db.streamYourRecipes();
});

abstract class _BaseRecipesService {}

class RecipesService {
  RecipesService({@required this.uid, @required this.storageService})
      : assert(uid != null),
        assert(storageService != null);
  final String uid;
  final StorageService storageService;
  final _service = FirebaseFirestore.instance;

  Future<void> deleteRecipe(Recipe recipe) {
    Logger().i('delete recipe');
    return _service.collection(Path.recipes()).doc(recipe.id).delete();
  }

  Future<bool> createRecipe({
    @required String authorName,
    @required String localeBase,
    @required String name,
    @required String access,
    @required String description,
    @required Duration timePreparation,
    @required String videoUrl,
    @required List<String> keyWords,
    @required List<Box> photos,
    @required List<Ingredient> ingredients,
    @required List<Portion> portions,
    Recipe oldRecipe,
  }) async {
    Logger().i('create recipes');
    final DocumentReference ref = _service.collection(Path.recipes()).doc(oldRecipe?.id ?? null);

    List<String> _photosUrl = [];

    for (Box element in photos) {
      if (element.uint8List != null) {
        String url = await storageService.uploadToFirebaseStorage(
          uint8List: element.uint8List,
          folderName: "recipes/${ref.id}",
          name: photos.indexOf(element).toString(),
        );
        _photosUrl.add(url);
      } else {
        if (!element.isVideo) _photosUrl.add(element.url);
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

  Future<Recipe> getRecipe(String id) {
    Logger().i('get recipe');
    return _service
        .collection(Path.recipes())
        .where(FieldPath.documentId, isEqualTo: id)
        .get()
        .then((value) => value.docs.isNotEmpty ? Recipe.fromMap(value.docs.first.data()) : null);
  }

  Stream<List<Recipe>> streamYourRecipes() {
    Logger().i('stream your recipes');
    return _service
        .collection(Path.recipes())
        .where('uid', isEqualTo: uid)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((snap) => Recipe.fromMap(snap.data())).toList());
  }

  Stream<List<Recipe>> streamRecipesNew() {
    Logger().i('stream recipes new');
    return _service
        .collection(Path.recipes())
        .orderBy('dateCreation', descending: true)
        .limit(10)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((snap) => Recipe.fromMap(snap.data())).toList());
  }

  Stream<List<Recipe>> streamRecipesRating() {
    Logger().i('stream recipes rating');
    return _service
        .collection(Path.recipes())
        .orderBy('ratingsAvg', descending: true)
        .limit(10)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((snap) => Recipe.fromMap(snap.data())).toList());
  }

  Stream<List<Recipe>> streamRecipesPopular() {
    Logger().i('stream recipes favorite');
    return _service
        .collection(Path.recipes())
        .orderBy('favoritesCount', descending: true)
        .limit(10)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((snap) => Recipe.fromMap(snap.data())).toList());
  }

  updateRating(Rating rating) {
    Logger().i('update rating');
    final DocumentReference ref = _service.collection(Path.recipes()).doc(rating.id).collection(Path.ratings()).doc(uid);

    ref.set(rating.toMap(uid, rating.id));
  }
}
