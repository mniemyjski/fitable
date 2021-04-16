import 'package:algolia/algolia.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fitable/app/account/account_details_screen.dart';
import 'package:fitable/app/account/models/account_model.dart';
import 'package:fitable/app/account/models/preference_model.dart';
import 'package:fitable/app/account/widgets/massage_flush_bar.dart';
import 'package:fitable/app/product/product_create_screen.dart';
import 'package:fitable/app/product/models/product_model.dart';
import 'package:fitable/app/product/product_details_screen.dart';
import 'package:fitable/app/recipe/models/recipe_model.dart';
import 'package:fitable/app/recipe/recipe_details_screen.dart';
import 'package:fitable/app/search/search_screen.dart';
import 'package:fitable/app/search/widgets/data_search.dart';
import 'package:fitable/constants/constants.dart';
import 'package:fitable/constants/enum.dart';
import 'package:fitable/routers/route_generator.dart';
import 'package:fitable/services/application.dart';
import 'package:fitable/services/providers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final providerSearchViewModel = ChangeNotifierProvider.autoDispose<SearchViewModel>((ref) {
  return SearchViewModel();
});

class SearchViewModel extends ChangeNotifier {
  TabController controller;
  int selectedIndex;
  List<Widget> tabBar = [];
  Algolia algolia = Application.algolia;
  AlgoliaQuery _searchQuery;
  FavoriteScreen _favoriteScreen;
  String title;

  FavoriteScreen get favoriteScreen => _favoriteScreen;

  set favoriteScreen(FavoriteScreen favoriteScreen) {
    switch (favoriteScreen) {
      case FavoriteScreen.onlyProducts:
        _searchType = SearchType.products;
        break;
      case FavoriteScreen.allFoods:
        _searchType = SearchType.products;
        break;
      case FavoriteScreen.workouts:
        _searchType = SearchType.workouts;
        break;
      case FavoriteScreen.accounts:
        _searchType = SearchType.accounts;
        break;
    }
    _favoriteScreen = favoriteScreen;
  }

  SearchType _searchType;
  SearchType get searchType => _searchType;

  bool _verification = false;
  bool get verification => _verification;
  setVerification(BuildContext context, bool state) {
    _verification = state;
    if (_verification) massageFlushBar(context, Constants.search_verification_product_only());
    notifyListeners();
  }

  bool _isCoach = false;
  bool get isCoach => _isCoach;
  setIsCoach(BuildContext context, bool state) {
    _isCoach = state;
    if (_isCoach) massageFlushBar(context, Constants.only_look_for_coaches());
    notifyListeners();
  }

  bool _withBarcode = true;
  bool get withBarcode => _withBarcode;
  setWithBarcode(BuildContext context, bool state) {
    _withBarcode = state;
    if (_withBarcode) massageFlushBar(context, Constants.search_product_only_with_barcode());
    notifyListeners();
  }

  bool _recipes = false;
  bool get recipes => _recipes;
  setRecipes(BuildContext context, bool state) {
    _recipes = state;
    if (state) {
      _searchType = SearchType.products;
      massageFlushBar(context, Constants.search_recipes());
    } else {
      _searchType = SearchType.recipes;
      massageFlushBar(context, Constants.search_products());
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
      case SearchType.recipes:
        return db.getRecipe(id);
        break;
      case SearchType.products:
        return db.getProduct(id: id);
        break;
      case SearchType.accounts:
        return db.getAccount(id);
        break;
      case SearchType.workouts:
        return db.getRecipe(id);
        break;
      default:
        return null;
    }
  }

  Future<AlgoliaQuerySnapshot> searchQuery(BuildContext context, String query) async {
    await context.read(providerPreference.last).then((preference) {
      if (favoriteScreen == FavoriteScreen.onlyProducts || favoriteScreen == FavoriteScreen.allFoods) {
        if (recipes) {
          _searchQuery = algolia.instance.index('recipes').search(query);
          _searchQuery = _searchQuery.setFilters('localeBase:${preference.localeBase} AND verification:true');
        } else {
          _searchQuery = algolia.instance.index('products').search(query);
          if (verification && !withBarcode) {
            _searchQuery = _searchQuery.setFilters('localeBase:${preference.localeBase} AND verification:${verification.toString()}');
          } else if (withBarcode && !verification) {
            _searchQuery = _searchQuery.setFilters('localeBase:${preference.localeBase} AND withBarcode:${withBarcode.toString()}');
          } else if (withBarcode && verification) {
            _searchQuery = _searchQuery.setFilters(
                'localeBase:${preference.localeBase} AND withBarcode:${withBarcode.toString()} AND verification:${verification.toString()}');
          } else {
            _searchQuery = _searchQuery.setFilters('localeBase:${preference.localeBase}');
          }
        }
      }
      if (favoriteScreen == FavoriteScreen.workouts) {
        _searchQuery = algolia.instance.index('workouts').search(query);
      }
      if (favoriteScreen == FavoriteScreen.accounts) {
        _searchQuery = algolia.instance.index('accounts').search(query);
        if (isCoach) _searchQuery = _searchQuery.setFilters('isCoach:true');
      }
    });
    return await _searchQuery.getObjects();
  }

  productDetails(BuildContext context, Product element) async {
    // selectedIndex = controller.index = 0;
    dynamic result = await Navigator.of(context).pushNamed(AppRoute.productDetailsScreen,
        arguments: ProductDetailsScreenArguments(
          product: element,
        ));

    if (result != null) Navigator.pop(context, result);
  }

  recipeDetails(BuildContext context, Recipe element) async {
    // selectedIndex = controller.index = 0;
    dynamic result = await Navigator.of(context).pushNamed(AppRoute.recipeDetailsScreen,
        arguments: RecipeDetailsScreenArguments(
          recipe: element,
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
    String result = await FlutterBarcodeScanner.scanBarcode("#ff6666", "CANCEL", true, ScanMode.BARCODE);
    final SearchScreenArguments args = ModalRoute.of(context).settings.arguments;
    selectedIndex = controller.index = 0;
    if (result != '-1') {
      final db = context.read(providerDatabase);
      Product product = await db.getProduct(barcode: result);

      if (product != null) {
        var result = await Navigator.of(context).pushNamed(AppRoute.productDetailsScreen,
            arguments: ProductDetailsScreenArguments(
              product: product,
            ));
        Navigator.pop(context, result);
      } else {
        Navigator.of(context).pushNamed(AppRoute.createProductScreen,
            arguments: ProductCreateScreenArguments(
              barcode: result,
            ));
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
          arguments: ProductDetailsScreenArguments(product: value),
        );

        Navigator.pop(context, result);
      }

      if (value.runtimeType == Recipe) {
        var result = await Navigator.of(context).pushNamed(
          AppRoute.recipeDetailsScreen,
          arguments: RecipeDetailsScreenArguments(recipe: value),
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
