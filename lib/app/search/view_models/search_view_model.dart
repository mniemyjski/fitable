import 'package:algolia/algolia.dart';
import 'package:fitable/app/account/account_details_screen.dart';
import 'package:fitable/common_widgets/show_alert_dialog.dart';
import 'package:fitable/models/models.dart';
import 'package:fitable/app/meal/product_create_screen.dart';
import 'package:fitable/app/meal/product_details_screen.dart';
import 'package:fitable/app/meal/product_not_found_screen.dart';
import 'package:fitable/app/meal/recipe_details_screen.dart';
import 'package:fitable/app/search/widgets/search_data.dart';
import 'package:fitable/common_widgets/show_flush_bar.dart';
import 'package:fitable/services/services.dart';
import 'package:fitable/utilities/utilities.dart';
import 'package:fitable/routers/route_generator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:logger/logger.dart';

final providerSearchViewModel = ChangeNotifierProvider.autoDispose<SearchViewModel>((ref) {
  return SearchViewModel();
});

class SearchViewModel extends ChangeNotifier {
  TabController controller;
  int selectedIndex = 0;
  List<Widget> tabBar = [];
  Algolia algolia = Application.algolia;
  AlgoliaQuery _searchQuery;
  ETypeFavoriteScreen _favoriteScreen;
  String title;

  ETypeFavoriteScreen get favoriteScreen => _favoriteScreen;

  set favoriteScreen(ETypeFavoriteScreen favoriteScreen) {
    switch (favoriteScreen) {
      case ETypeFavoriteScreen.onlyProducts:
        _searchType = ETypeSearch.products;
        break;
      case ETypeFavoriteScreen.allFoods:
        _searchType = ETypeSearch.products;
        break;
      case ETypeFavoriteScreen.workouts:
        _searchType = ETypeSearch.workouts;
        break;
      case ETypeFavoriteScreen.accounts:
        _searchType = ETypeSearch.accounts;
        break;
    }
    _favoriteScreen = favoriteScreen;
  }

  ETypeSearch _searchType;
  ETypeSearch get searchType => _searchType;

  bool _verification = false;
  bool get verification => _verification;
  setVerification(BuildContext context, bool state) {
    _verification = state;
    if (_verification) massageFlushBar(context, Languages.search_verification_product_only());
    notifyListeners();
  }

  bool _isCoach = false;
  bool get isCoach => _isCoach;
  setIsCoach(BuildContext context, bool state) {
    _isCoach = state;
    if (_isCoach) massageFlushBar(context, Languages.only_look_for_coaches());
    notifyListeners();
  }

  bool _withBarcode = true;
  bool get withBarcode => _withBarcode;
  setWithBarcode(BuildContext context, bool state) {
    _withBarcode = state;
    if (_withBarcode) massageFlushBar(context, Languages.search_product_only_with_barcode());
    notifyListeners();
  }

  bool _recipes = false;
  bool get recipes => _recipes;
  setRecipes(BuildContext context, bool state) {
    _recipes = state;
    if (state) {
      _searchType = ETypeSearch.recipes;
      massageFlushBar(context, Languages.search_recipes());
    } else {
      _searchType = ETypeSearch.products;
      massageFlushBar(context, Languages.search_products());
    }

    notifyListeners();
  }

  bool _trainings = false;
  bool get trainings => _trainings;
  set trainings(bool trainings) {
    _trainings = trainings;
    notifyListeners();
  }

  Future getStream(BuildContext context, String id) {
    switch (searchType) {
      case ETypeSearch.recipes:
        return context.read(providerRecipesService).getRecipe(id);
        break;
      case ETypeSearch.products:
        return context.read(providerProductsService).getProduct(id: id);
        break;
      case ETypeSearch.accounts:
        return context.read(providerAccountService).getAccount(id);
        break;
      case ETypeSearch.workouts:
        return context.read(providerRecipesService).getRecipe(id);
        break;
      default:
        return null;
    }
  }

  Future<AlgoliaQuerySnapshot> searchQuery(BuildContext context, String query) async {
    await context.read(providerPreference.last).then((preference) {
      if (favoriteScreen == ETypeFavoriteScreen.onlyProducts || favoriteScreen == ETypeFavoriteScreen.allFoods) {
        if (recipes) {
          _searchQuery = algolia.instance.index('recipes').query(query);
          _searchQuery = _searchQuery.facetFilter('localeBase:${preference.localeBase}');
          if (verification) _searchQuery = _searchQuery.facetFilter('verification:true');
        } else {
          _searchQuery = algolia.instance.index('products').query(query);
          _searchQuery = _searchQuery.facetFilter('localeBase:${preference.localeBase}');
          if (verification) _searchQuery = _searchQuery.facetFilter('verification:true');
          if (withBarcode) _searchQuery = _searchQuery.facetFilter('withBarcode:true');
        }
      }
      if (favoriteScreen == ETypeFavoriteScreen.workouts) {
        _searchQuery = algolia.instance.index('workouts').query(query);
      }
      if (favoriteScreen == ETypeFavoriteScreen.accounts) {
        _searchQuery = algolia.instance.index('accounts').query(query);
        if (isCoach) _searchQuery = _searchQuery.facetFilter('isCoach:true');
      }
    });

    return await _searchQuery.getObjects();
  }

  productDetails(BuildContext context, Product element) async {
    selectedIndex = controller.index = 0;
    dynamic result = await Navigator.of(context).pushNamed(AppRoute.productDetailsScreen,
        arguments: ProductDetailsScreenArguments(
          element: Ingredient.transform(element),
        ));

    if (result != null) Navigator.pop(context, result);
  }

  recipeDetails(BuildContext context, Recipe element) async {
    selectedIndex = controller.index = 0;
    dynamic result = await Navigator.of(context).pushNamed(AppRoute.recipeDetailsScreen,
        arguments: RecipeDetailsScreenArguments(
          element: Ingredient.transform(element),
        ));

    if (result != null) Navigator.pop(context, result);
  }

  bool mobilePlatform() {
    if (defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS) {
      return true;
    } else {
      return false;
    }
  }

  barcodeOnPress(BuildContext context) async {
    await Permission.camera.request();
    var barcode = await scanner.scan();

    if (barcode != null) {
      Product product = await context.read(providerProductsService).getProduct(barcode: barcode);

      if (product != null) {
        var result = await Navigator.of(context).pushNamed(AppRoute.productDetailsScreen,
            arguments: ProductDetailsScreenArguments(
              element: Ingredient.transform(product),
            ));
        Navigator.pop(context, result);
      } else {
        bool already = await context.read(providerProductsService).productImagesToCreateAlready(barcode);

        String desc = already ? Languages.product_not_found_desc_2() : Languages.product_not_found_desc_1();

        showAlertDialog(
          context,
          title: Languages.product_not_found(),
          content: desc,
          actions: <Widget>[
            TextButton(
              child: Text(Languages.cancel()),
              onPressed: () => Navigator.pop(context),
            ),
            if (!already)
              FittedBox(
                child: TextButton(
                  child: Row(
                    children: [
                      FaIcon(FontAwesomeIcons.images),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(Languages.send()),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, AppRoute.productNotFound, arguments: ProductNotFoundArguments(barcode));
                  },
                ),
              ),
            FittedBox(
              child: TextButton(
                child: Row(
                  children: [
                    FaIcon(FontAwesomeIcons.file),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(Languages.create()),
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.of(context).pushNamed(AppRoute.createProductScreen,
                      arguments: ProductCreateScreenArguments(
                        barcode: barcode,
                      ));
                },
              ),
            ),
          ],
        );

        // showDialog(
        //     context: context,
        //     builder: (BuildContext context) {
        //       return AlertDialog(
        //         title: Text(Languages.product_not_found()),
        //         content: Text(desc),
        //         actions: [
        //           TextButton(
        //             child: Text(Languages.cancel()),
        //             onPressed: () => Navigator.pop(context),
        //           ),
        //           if (!already)
        //             TextButton(
        //               child: Row(
        //                 children: [
        //                   FaIcon(FontAwesomeIcons.images),
        //                   Text(Languages.send()),
        //                 ],
        //               ),
        //               onPressed: () {
        //                 Navigator.pop(context);
        //                 Navigator.pushNamed(context, AppRoute.productNotFound, arguments: ProductNotFoundArguments(barcode));
        //               },
        //             ),
        //           TextButton(
        //             child: Row(
        //               children: [
        //                 FaIcon(FontAwesomeIcons.file),
        //                 Text(Languages.create()),
        //               ],
        //             ),
        //             onPressed: () {
        //               Navigator.pop(context);
        //               Navigator.of(context).pushNamed(AppRoute.createProductScreen,
        //                   arguments: ProductCreateScreenArguments(
        //                     barcode: barcode,
        //                   ));
        //             },
        //           ),
        //         ],
        //       );
        //     });
      }
    }
  }

  searchOnPress(BuildContext context) async {
    // FacebookAudienceNetwork.init(
    //   testingId: "1fc63a78-68f9-4ac1-8faa-6d3688d610aa", //optional
    // );
    //
    // FacebookInterstitialAd.loadInterstitialAd(
    //   placementId: "1366934306833619_1366944173499299",
    //   listener: (effect, value) {
    //     if (effect == InterstitialAdResult.LOADED) FacebookInterstitialAd.showInterstitialAd(delay: 5000);
    //   },
    // );
    selectedIndex = controller.index = 0;
    var value = await showSearch(context: context, delegate: DataSearch());

    if (value != null) {
      if (value.runtimeType == Product) {
        var result = await Navigator.of(context).pushNamed(
          AppRoute.productDetailsScreen,
          arguments: ProductDetailsScreenArguments(element: Ingredient.transform(value)),
        );

        Navigator.pop(context, result);
      }

      if (value.runtimeType == Recipe) {
        var result = await Navigator.of(context).pushNamed(
          AppRoute.recipeDetailsScreen,
          arguments: RecipeDetailsScreenArguments(element: Ingredient.transform(value)),
        );

        Navigator.pop(context, result);
      }

      if (value.runtimeType == Account) {
        Navigator.of(context).pushNamed(
          AppRoute.accountDetails,
          arguments: AccountDetailsScreenArguments(account: value),
        );

        // Navigator.pop(context);
      }
    }
  }
}
