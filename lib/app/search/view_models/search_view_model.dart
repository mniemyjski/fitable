import 'package:algolia/algolia.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fitable/app/account/account_details_screen.dart';
import 'package:fitable/models/account_model.dart';
import 'package:fitable/models/preference_model.dart';
import 'package:fitable/models/ingredient_model.dart';
import 'package:fitable/models/product_model.dart';
import 'package:fitable/models/recipe_model.dart';
import 'package:fitable/app/meal/product_create_screen.dart';
import 'package:fitable/app/meal/product_details_screen.dart';
import 'package:fitable/app/meal/product_not_found_screen.dart';
import 'package:fitable/app/meal/recipe_details_screen.dart';
import 'package:fitable/app/search/widgets/data_search.dart';
import 'package:fitable/common_widgets/massage_flush_bar.dart';
import 'package:fitable/utilities/application.dart';
import 'package:fitable/utilities/languages.dart';
import 'package:fitable/utilities/enums.dart';
import 'package:fitable/routers/route_generator.dart';
import 'package:fitable/utilities/providers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';
import 'package:qrscan/qrscan.dart' as scanner;

final providerSearchViewModel = ChangeNotifierProvider.autoDispose<SearchViewModel>((ref) {
  return SearchViewModel();
});

class SearchViewModel extends ChangeNotifier {
  TabController controller;
  int selectedIndex;
  List<Widget> tabBar = [];
  Algolia algolia = Application.algolia;
  AlgoliaQuery _searchQuery;
  TypeFavoriteScreen _favoriteScreen;
  String title;

  TypeFavoriteScreen get favoriteScreen => _favoriteScreen;

  set favoriteScreen(TypeFavoriteScreen favoriteScreen) {
    switch (favoriteScreen) {
      case TypeFavoriteScreen.onlyProducts:
        _searchType = TypeSearch.products;
        break;
      case TypeFavoriteScreen.allFoods:
        _searchType = TypeSearch.products;
        break;
      case TypeFavoriteScreen.workouts:
        _searchType = TypeSearch.workouts;
        break;
      case TypeFavoriteScreen.accounts:
        _searchType = TypeSearch.accounts;
        break;
    }
    _favoriteScreen = favoriteScreen;
  }

  TypeSearch _searchType;
  TypeSearch get searchType => _searchType;

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
      _searchType = TypeSearch.recipes;
      massageFlushBar(context, Languages.search_recipes());
    } else {
      _searchType = TypeSearch.products;
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
    final db = context.read(providerDatabase);
    switch (searchType) {
      case TypeSearch.recipes:
        return db.getRecipe(id);
        break;
      case TypeSearch.products:
        return db.getProduct(id: id);
        break;
      case TypeSearch.accounts:
        return db.getAccount(id);
        break;
      case TypeSearch.workouts:
        return db.getRecipe(id);
        break;
      default:
        return null;
    }
  }

  Future<AlgoliaQuerySnapshot> searchQuery(BuildContext context, String query) async {
    await context.read(providerPreference.last).then((preference) {
      if (favoriteScreen == TypeFavoriteScreen.onlyProducts || favoriteScreen == TypeFavoriteScreen.allFoods) {
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
      if (favoriteScreen == TypeFavoriteScreen.workouts) {
        _searchQuery = algolia.instance.index('workouts').query(query);
      }
      if (favoriteScreen == TypeFavoriteScreen.accounts) {
        _searchQuery = algolia.instance.index('accounts').query(query);
        if (isCoach) _searchQuery = _searchQuery.facetFilter('isCoach:true');
      }
    });

    return await _searchQuery.getObjects();
  }

  productDetails(BuildContext context, Product element) async {
    // selectedIndex = controller.index = 0;
    dynamic result = await Navigator.of(context).pushNamed(AppRoute.productDetailsScreen,
        arguments: ProductDetailsScreenArguments(
          element: Ingredient.transform(element),
        ));

    if (result != null) Navigator.pop(context, result);
  }

  recipeDetails(BuildContext context, Recipe element) async {
    // selectedIndex = controller.index = 0;
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
      final db = context.read(providerDatabase);
      Product product = await db.getProduct(barcode: barcode);

      if (product != null) {
        var result = await Navigator.of(context).pushNamed(AppRoute.productDetailsScreen,
            arguments: ProductDetailsScreenArguments(
              element: Ingredient.transform(product),
            ));
        Navigator.pop(context, result);
      } else {
        bool already = await context.read(providerDatabase).productImagesToCreateAlready(barcode);

        String desc = already ? Languages.product_not_found_desc_2() : Languages.product_not_found_desc_1();

        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(Languages.product_not_found()),
                content: Text(desc),
                actions: [
                  TextButton(
                    child: Text(Languages.cancel()),
                    onPressed: () => Navigator.pop(context),
                  ),
                  if (!already)
                    TextButton(
                      child: Row(
                        children: [
                          FaIcon(FontAwesomeIcons.images),
                          Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Text(Languages.send()),
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, AppRoute.productNotFound, arguments: ProductNotFoundArguments(barcode));
                      },
                    ),
                  TextButton(
                    child: Row(
                      children: [
                        FaIcon(FontAwesomeIcons.file),
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
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
                ],
              );
            });
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
          arguments: ProductDetailsScreenArguments(element: value),
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
