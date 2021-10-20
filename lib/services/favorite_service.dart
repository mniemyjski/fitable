import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitable/services/services.dart';
import 'package:fitable/utilities/utilities.dart';
import 'package:flutter/foundation.dart';
import 'package:fitable/models/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';

final providerFavoriteService = FutureProvider<FavoriteService>((ref) async {
  final auth = ref.watch(providerAuthState).data?.value;
  final List<Favorite> favorites = await ref.watch(providerFavorite.last).then((value) => value);
  final List<Favorite> watchers = await ref.watch(_providerWatchers.last).then((value) => value);

  if (auth?.uid != null) {
    return FavoriteService(uid: auth?.uid, favorites: favorites, watchers: watchers);
  }
  return null;
});

final _providerWatchers = StreamProvider<List<Favorite>>((ref) {
  final auth = ref.watch(providerAuthState).data?.value;

  if (auth?.uid != null) {
    return FavoriteService(uid: auth?.uid).streamWatchers();
  }
  return null;
});

final providerFavorite = StreamProvider<List<Favorite>>((ref) {
  final auth = ref.watch(providerAuthState).data?.value;

  if (auth?.uid != null) {
    return FavoriteService(uid: auth?.uid).streamFavorites();
  }
  return null;
});

final providerFollowers = StreamProvider<List<Account>>((ref) {
  final db = ref.watch(providerFavoriteService).data.value;

  return db.streamAccounts(true);
});

final providerFollowing = StreamProvider<List<Account>>((ref) {
  final db = ref.watch(providerFavoriteService).data.value;

  return db.streamAccounts(false);
});

final providerFavoriteProducts = StreamProvider<List<Product>>((ref) {
  final db = ref.watch(providerFavoriteService).data.value;

  return db.streamFavoriteProducts();
});

final providerFavoriteRecipes = StreamProvider<List<Recipe>>((ref) {
  final db = ref.watch(providerFavoriteService).data.value;

  return db.streamFavoriteRecipes();
});

abstract class _BaseFavoriteService {}

class FavoriteService {
  FavoriteService({
    @required this.uid,
    this.favorites,
    this.watchers,
  }) : assert(uid != null);

  final String uid;
  final List<Favorite> favorites;
  final List<Favorite> watchers;

  final _service = FirebaseFirestore.instance;

  updateFavorite(Favorite favorite) {
    Logger().i('update favorite');
    String _path;
    if (favorite.type == ETypeFavorite.products) _path = Path.products();
    if (favorite.type == ETypeFavorite.recipes) _path = Path.recipes();
    if (favorite.type == ETypeFavorite.accounts) _path = Path.accounts();
    if (favorite.type == ETypeFavorite.exercise) _path = Path.products();
    if (favorite.type == ETypeFavorite.trainings) _path = Path.products();

    final DocumentReference ref = _service.collection(_path).doc(favorite.id).collection(Path.favorites()).doc(uid);
    bool _isFavorite = false;

    favorites.forEach((element) {
      if (element.id == favorite.id) {
        ref.delete();
        _isFavorite = true;
      }
    });
    if (!_isFavorite) ref.set(favorite.toMap(uid));
  }

  Stream<List<Favorite>> streamFavorites() {
    Logger().i('stream favorite');
    final ref = _service.collectionGroup(Path.favorites()).where('uid', isEqualTo: uid).snapshots();

    return ref.map((snapshot) => snapshot.docs.map((snap) => Favorite.fromMap(snap.data(), snap.id)).toList());
  }

  Stream<List<Favorite>> streamWatchers() {
    Logger().i('stream followers');
    final ref = _service.collection(Path.accounts()).doc(uid).collection(Path.favorites()).snapshots();
    return ref.map((snapshot) => snapshot.docs.map((snap) => Favorite.fromMap(snap.data(), snap.id)).toList());
  }

  Stream<List<Account>> streamAccounts(bool followers) {
    Logger().i('stream accounts');

    List<String> _list = [];
    if (followers) {
      favorites.forEach((element) {
        if (element.type == ETypeFavorite.accounts) {
          followers ? _list.add(element.id) : _list.add(element.uid);
        }
      });
    } else {
      watchers.forEach((element) {
        if (element.type == ETypeFavorite.accounts) {
          followers ? _list.add(element.id) : _list.add(element.uid);
        }
      });
    }
    if (_list.isNotEmpty) {
      return _service
          .collection(Path.accounts())
          .where(FieldPath.documentId, whereIn: _list)
          .snapshots()
          .map((snapshot) => snapshot.docs.map((snap) => Account.fromMap(snap.data())).toList());
    } else {
      return null;
    }
  }

  Stream<List<Recipe>> streamFavoriteRecipes() {
    List<String> _list = [];

    favorites.forEach((element) {
      if (element.type == ETypeFavorite.recipes) _list.add(element.id);
    });

    if (_list.isNotEmpty) {
      Logger().i('stream favorite recipes');
      return _service
          .collection(Path.recipes())
          .where(FieldPath.documentId, whereIn: _list)
          .snapshots()
          .map((snapshot) => snapshot.docs.map((snap) => Recipe.fromMap(snap.data())).toList());
    } else {
      return null;
    }
  }

  Stream<List<Product>> streamFavoriteProducts() {
    List<String> _list = [];

    favorites.forEach((element) {
      if (element.type == ETypeFavorite.products) _list.add(element.id);
    });

    if (_list.isNotEmpty) {
      Logger().i('stream products Favorite');
      return _service
          .collection(Path.products())
          .where(FieldPath.documentId, whereIn: _list)
          .snapshots()
          .map((snapshot) => snapshot.docs.map((snap) => Product.fromMap(snap.data())).toList());
    } else {
      return null;
    }
  }
}
