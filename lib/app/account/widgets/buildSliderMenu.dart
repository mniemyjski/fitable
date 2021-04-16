import 'package:fitable/app/search/view_models/search_view_model.dart';
import 'package:fitable/constants/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

sliderMenu(BuildContext context) {
  return Consumer(builder: (context, watch, child) {
    final model = watch(providerSearchViewModel);

    return Container(
      margin: EdgeInsets.only(right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          if (model.favoriteScreen == FavoriteScreen.allFoods) ...[
            Icon(Icons.fastfood, color: Colors.lightBlue[800]),
            Switch(value: model.recipes, onChanged: (state) => context.read(providerSearchViewModel).setRecipes(context, state)),
          ],
          if (model.favoriteScreen == FavoriteScreen.allFoods || model.favoriteScreen == FavoriteScreen.onlyProducts) ...[
            FaIcon(FontAwesomeIcons.barcode, color: Colors.lightBlue[800]),
            Switch(value: model.withBarcode, onChanged: (state) => context.read(providerSearchViewModel).setWithBarcode(context, state)),
            Icon(Icons.verified_user, color: Colors.lightBlue[800]),
            Switch(value: model.verification, onChanged: (state) => context.read(providerSearchViewModel).setVerification(context, state)),
          ],
          if (model.favoriteScreen == FavoriteScreen.accounts) ...[
            Icon(FontAwesomeIcons.userShield, color: Colors.lightBlue[800]),
            Switch(value: model.isCoach, onChanged: (state) => context.read(providerSearchViewModel).setIsCoach(context, state)),
          ],
        ],
      ),
    );
  });
}
