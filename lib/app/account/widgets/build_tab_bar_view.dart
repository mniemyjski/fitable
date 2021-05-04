import 'package:fitable/app/account/account_details_screen.dart';
import 'package:fitable/app/favorite/models/favorite_model.dart';
import 'package:fitable/app/search/view_models/search_view_model.dart';
import 'package:fitable/common_widgets/custom_list_view.dart';
import 'package:fitable/constants/constants.dart';
import 'package:fitable/constants/enums.dart';
import 'package:fitable/routers/route_generator.dart';
import 'package:fitable/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

buildTabBarView({
  @required BuildContext context,
  @required Database db,
  @required List<Favorite> favorites,
  // @required SearchViewModel model,
  @required FavoriteScreen favoriteScreen,
}) {
  _buildList({
    @required Stream stream,
    @required EnumTileType type,
    @required ValueChanged<dynamic> onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: StreamBuilder(
          stream: stream,
          builder: (context, snapshot) {
            if (snapshot.hasError) Center(child: Text(Constants.error()));
            if (snapshot.hasData)
              return CustomListView(
                list: snapshot.data,
                type: type,
                direction: DismissDirection.none,
                onPressed: onPressed,
              );

            return Container(child: Center(child: Text(Constants.empty())));
          }),
    );
  }

  switch (favoriteScreen) {
    case FavoriteScreen.onlyProducts:
      return [
        _buildList(
          stream: db.streamProducts(favorites),
          type: EnumTileType.product,
          onPressed: (element) => context.read(providerSearchViewModel).productDetails(context, element),
        )
      ];
      break;
    case FavoriteScreen.allFoods:
      return [
        _buildList(
          stream: db.streamProducts(favorites),
          type: EnumTileType.product,
          onPressed: (element) => context.read(providerSearchViewModel).productDetails(context, element),
        ),
        _buildList(
          stream: db.streamFavoriteRecipes(favorites),
          type: EnumTileType.recipe,
          onPressed: (element) => context.read(providerSearchViewModel).recipeDetails(context, element),
        ),
        _buildList(
          stream: db.streamYourRecipes(),
          type: EnumTileType.recipe,
          onPressed: (element) => context.read(providerSearchViewModel).recipeDetails(context, element),
        )
      ];
      break;
    case FavoriteScreen.workouts:
      return [
        Tab(text: Constants.exercises()),
        Tab(text: Constants.workouts()),
      ];
      break;
    case FavoriteScreen.accounts:
      return [
        _buildList(
          stream: db.streamAccounts(favorites, false),
          type: EnumTileType.account,
          onPressed: (element) => Navigator.of(context).pushNamed(
            AppRoute.accountDetails,
            arguments: AccountDetailsScreenArguments(account: element),
          ),
        ),
        StreamBuilder(
            stream: db.streamFollowers(),
            builder: (context, snapshot) {
              if (snapshot.hasError) return Center(child: Text(Constants.error()));
              if (snapshot.hasData) {
                return _buildList(
                  stream: db.streamAccounts(snapshot.data, true),
                  type: EnumTileType.account,
                  onPressed: (element) => Navigator.of(context).pushNamed(
                    AppRoute.accountDetails,
                    arguments: AccountDetailsScreenArguments(account: element),
                  ),
                );
              }
              return Container();
            }),
      ];
      break;
  }
}
