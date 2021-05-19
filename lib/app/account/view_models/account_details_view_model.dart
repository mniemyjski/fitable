import 'package:fitable/app/favorite/models/favorite_model.dart';
import 'package:fitable/utilities/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitable/utilities/enums.dart';

final providerAccountDetailsViewModel = ChangeNotifierProvider.autoDispose<AccountDetailsViewModel>((ref) => AccountDetailsViewModel());

class AccountDetailsViewModel extends ChangeNotifier {
  bool isFavorite = false;

  favoriteButton(BuildContext context, String uid) {
    Favorite _favorite = Favorite(type: TypeFavorite.accounts, id: uid);
    context.read(providerDatabase).updateFavorite(context, _favorite);
  }

  favoriteCheck(Favorite element, String uid) {
    if (element.id == uid && element.type == TypeFavorite.accounts) {
      isFavorite = true;
    }
  }
}
