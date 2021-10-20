import 'package:fitable/models/favorite_model.dart';
import 'package:fitable/services/favorite_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitable/utilities/enums.dart';

final providerAccountDetailsViewModel = ChangeNotifierProvider.autoDispose<AccountDetailsViewModel>((ref) => AccountDetailsViewModel());

class AccountDetailsViewModel extends ChangeNotifier {
  bool isFavorite = false;

  favoriteButton(BuildContext context, String uid) {
    Favorite _favorite = Favorite(type: ETypeFavorite.accounts, id: uid);
    context.read(providerFavoriteService).whenData((value) => value.updateFavorite(_favorite));
  }

  favoriteCheck(Favorite element, String uid) {
    if (element.id == uid && element.type == ETypeFavorite.accounts) {
      isFavorite = true;
    }
  }
}
