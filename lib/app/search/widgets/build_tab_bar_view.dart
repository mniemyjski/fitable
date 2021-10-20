import 'package:fitable/app/account/account_details_screen.dart';
import 'package:fitable/models/favorite_model.dart';
import 'package:fitable/app/search/view_models/search_view_model.dart';
import 'package:fitable/common_widgets/custom_list_view.dart';
import 'package:fitable/services/services.dart';
import 'package:fitable/utilities/languages.dart';
import 'package:fitable/utilities/enums.dart';
import 'package:fitable/routers/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List<Widget> buildTabBarView({
  @required List<Favorite> favorites,
  @required ETypeFavoriteScreen favoriteScreen,
}) {
  switch (favoriteScreen) {
    case ETypeFavoriteScreen.onlyProducts:
      return [
        Consumer(builder: (context, watch, child) {
          final model = watch(providerFavoriteProducts);
          if (model == null) return Container();

          return model.when(
            data: (data) {
              if (data == null) return Container();
              return CustomListView(
                list: data,
                type: EnumTileType.product,
                direction: DismissDirection.none,
                onPressed: (element) => context.read(providerSearchViewModel).productDetails(context, element),
              );
            },
            loading: () => Container(),
            error: (e, r) => Container(),
          );
        }),
      ];
      break;
    case ETypeFavoriteScreen.allFoods:
      return [
        Consumer(builder: (context, watch, child) {
          final model = watch(providerFavoriteProducts);
          if (model == null) return Container();

          return model.when(
            data: (data) {
              if (data == null) return Container();
              return CustomListView(
                list: data,
                type: EnumTileType.product,
                direction: DismissDirection.none,
                onPressed: (element) => context.read(providerSearchViewModel).productDetails(context, element),
              );
            },
            loading: () => Container(),
            error: (e, r) => Container(),
          );
        }),
        Consumer(builder: (context, watch, child) {
          final model = watch(providerFavoriteRecipes);
          if (model == null) return Container();

          return model.when(
            data: (data) {
              if (data == null) return Container();
              return CustomListView(
                list: data,
                type: EnumTileType.recipe,
                direction: DismissDirection.none,
                onPressed: (element) => context.read(providerSearchViewModel).recipeDetails(context, element),
              );
            },
            loading: () => Container(),
            error: (e, r) => Container(),
          );
        }),
        Consumer(builder: (context, watch, child) {
          final model = watch(providerYourRecipes);
          return model.when(
            data: (data) {
              if (data == null) return Container();
              return CustomListView(
                list: data,
                type: EnumTileType.recipe,
                direction: DismissDirection.none,
                onPressed: (element) => context.read(providerSearchViewModel).recipeDetails(context, element),
              );
            },
            loading: () => Container(),
            error: (e, r) => Container(),
          );
        }),
      ];
      break;
    case ETypeFavoriteScreen.workouts:
      return [
        Tab(text: Languages.exercises()),
        Tab(text: Languages.workouts()),
      ];
      break;
    case ETypeFavoriteScreen.accounts:
      return [
        Consumer(builder: (context, watch, child) {
          final model = watch(providerFollowers);
          if (model == null) return Container();

          return model.when(
            data: (data) {
              if (data == null) return Container();
              return CustomListView(
                list: data,
                type: EnumTileType.account,
                direction: DismissDirection.none,
                onPressed: (element) {
                  final ctx = context.read(providerSearchViewModel);
                  ctx.selectedIndex = ctx.controller.index = 0;
                  return Navigator.of(context).pushNamed(
                    AppRoute.accountDetails,
                    arguments: AccountDetailsScreenArguments(account: element),
                  );
                },
              );
            },
            loading: () => Container(),
            error: (e, r) => Container(),
          );
        }),
        Consumer(builder: (context, watch, child) {
          final model = watch(providerFollowing);
          if (model == null) return Container();
          return model.when(
            data: (data) {
              if (data == null) return Container();
              return CustomListView(
                list: data,
                type: EnumTileType.account,
                direction: DismissDirection.none,
                onPressed: (element) {
                  final ctx = context.read(providerSearchViewModel);
                  ctx.selectedIndex = ctx.controller.index = 0;
                  return Navigator.of(context).pushNamed(
                    AppRoute.accountDetails,
                    arguments: AccountDetailsScreenArguments(account: element),
                  );
                },
              );
            },
            loading: () => Container(),
            error: (e, r) => Container(),
          );
        }),
      ];
      break;
    default:
      return [];
  }
}
