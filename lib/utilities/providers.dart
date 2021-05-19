import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitable/app/account/models/account_model.dart';
import 'package:fitable/app/account/models/preference_model.dart';
import 'package:fitable/app/account/models/account_data_model.dart';
import 'package:fitable/app/favorite/models/favorite_model.dart';
import 'package:fitable/app/meal/models/meal_model.dart';
import 'package:fitable/services/auth.dart';
import 'package:fitable/services/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final providerAuthBase = Provider<AuthBase>((ref) => Auth());
final providerAuthState = StreamProvider<User>((ref) => ref.watch(providerAuthBase).authStateChanges());
final providerDatabase = Provider<Database>((ref) {
  final auth = ref.watch(providerAuthState);

  if (auth.data?.value?.uid != null) {
    return Database(uid: auth.data?.value?.uid);
  }
  return null;
});

final providerAccount = StreamProvider<Account>((ref) {
  final db = ref.watch(providerDatabase);

  return db.streamAccount();
});

final providerPreference = StreamProvider<Preference>((ref) {
  final db = ref.watch(providerDatabase);

  return db.streamPreference();
});

final providerMeals = StreamProvider<List<Meal>>((ref) {
  final db = ref.watch(providerDatabase);

  return db.streamMeals();
});

final providerFavorite = StreamProvider<List<Favorite>>((ref) {
  final db = ref.watch(providerDatabase);

  return db.streamFavorites();
});

final providerFollowers = StreamProvider<List<Favorite>>((ref) {
  final db = ref.watch(providerDatabase);

  return db.streamFollowers();
});

final providerUserData = StreamProvider<AccountData>((ref) {
  final db = ref.watch(providerDatabase);

  return db.streamUserData();
});
