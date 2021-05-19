import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitable/app/account/models/preference_model.dart';
import 'package:fitable/app/favorite/models/favorite_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:fitable/utilities/enums.dart';
import 'account_model.dart';

class AccountData {
  final Account account;
  final Preference preference;
  final List<Favorite> favorite;
  final List<Favorite> followers;

  AccountData({
    @required this.account,
    @required this.preference,
    @required this.favorite,
    @required this.followers,
  });

  List<Favorite> getFavoriteProduct() {
    return favorite.where((element) => element.type == TypeFavorite.products);
  }

  List<Favorite> getFavoriteRecipe() {
    return favorite.where((element) => element.type == TypeFavorite.recipes);
  }

  List<Favorite> getFollowing() {
    return favorite.where((element) => element.type == TypeFavorite.accounts);
  }

  List<Favorite> getFollowers() {
    return followers;
  }
}
