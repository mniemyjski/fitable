import 'package:fitable/app/account/models/account_model.dart';
import 'package:fitable/app/account/models/preference_model.dart';
import 'package:fitable/app/add_to_list/add_to_list_screen.dart';
import 'package:fitable/app/meal/add_portions_screen.dart';
import 'package:fitable/app/meal/models/ingredient_model.dart';
import 'package:fitable/app/meal/product_details_screen.dart';
import 'package:fitable/app/meal/view_models/carousel_view_model.dart';
import 'package:fitable/app/search/search_screen.dart';
import 'package:fitable/common_widgets/custom_list_view.dart';
import 'package:fitable/constants/constants.dart';
import 'package:fitable/constants/enums.dart';
import 'package:fitable/routers/route_generator.dart';
import 'package:fitable/services/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final providerRecipeCreateViewModel = ChangeNotifierProvider.autoDispose<RecipeCreateViewModel>((ref) {
  return RecipeCreateViewModel();
});

class RecipeCreateViewModel extends ChangeNotifier {
  List<Ingredient> ingredients = [];

  Map _portions;
  List _keyWords;
  String _unit;
  String _access;
  Duration _timePreparation = Duration(seconds: 0);

  Duration get timePreparation => _timePreparation;

  set timePreparation(Duration timePreparation) {
    _timePreparation = timePreparation;
    notifyListeners();
  }

  String name;
  String description;

  createRecipe(BuildContext context) {
    FocusScope.of(context).unfocus();

    if ((name?.length ?? 0) < 4) {
      final messenger = ScaffoldMessenger.of(context);
      messenger.showSnackBar(SnackBar(content: Text('The name of the recipe cannot be empty and must contain more than 3 characters.')));
      return;
    }

    if ((description?.length ?? 0) < 11) {
      final messenger = ScaffoldMessenger.of(context);
      messenger.showSnackBar(SnackBar(content: Text('The description of the recipe cannot be empty and must contain more than 10 characters.')));
      return;
    }

    if (ingredients.length < 2) {
      final messenger = ScaffoldMessenger.of(context);
      messenger.showSnackBar(SnackBar(content: Text('The recipe must consist of at least 2 ingredients.')));
      return;
    }

    List sliderList = context.read(providerCarouselViewModel).sliderList;

    List _photosUrl = new List.of(sliderList);
    _photosUrl.remove(sliderList[0]);
    _photosUrl.removeWhere((element) => element.toString().length < 2);

    context.read(providerAccount.last).then((account) {
      context.read(providerPreference.last).then((preference) {
        context.read(providerDatabase).createRecipe(
              authorName: account.name,
              localeBase: preference.localeBase,
              name: name,
              access: access,
              description: description,
              timePreparation: timePreparation,
              videoUrl: sliderList[0],
              keyWords: keyWords,
              photos: _photosUrl,
              ingredients: ingredients,
              unit: unit,
              portions: portions,
            );

        Navigator.pop(context);
      });
    });
  }

  String get access => _access != null ? _access : _access = 'private';

  set access(String access) {
    if (access.isNotEmpty) {
      _access = access;
      notifyListeners();
    }
  }

  List get keyWords {
    if (_keyWords == null) _keyWords = [];
    return _keyWords;
  }

  set keyWords(List keywords) {
    _keyWords = keywords;
    notifyListeners();
  }

  String get unit => _unit != null ? _unit : _unit = 'g';
  set unit(String unit) {
    if (unit.isNotEmpty) {
      _unit = unit;
      notifyListeners();
    }
  }

  Map get portions {
    if (_portions == null) _portions = new Map<String, double>();
    return _portions;
  }

  set portions(Map portions) {
    _portions = portions;
    notifyListeners();
  }

  int _calories = 0;
  int get calories => _calories;

  double _proteins = 0;
  double get proteins => _proteins;

  double _carbs = 0;
  double get carbs => _carbs;

  double _fats = 0;
  double get fats => _fats;

  _calc() {
    _calories = 0;
    _proteins = 0;
    _carbs = 0;
    _fats = 0;

    ingredients.forEach((element) {
      _calories = _calories + (element.product.calories * element.portionSize * element.product.portions[element.portionChosen] / 100).round();
      _proteins = _proteins + (element.product.proteins * element.portionSize * element.product.portions[element.portionChosen] / 100);
      _carbs = _carbs + (element.product.carbs * element.portionSize * element.product.portions[element.portionChosen] / 100);
      _fats = _fats + (element.product.fats * element.portionSize * element.product.portions[element.portionChosen] / 100);
    });

    notifyListeners();
  }

  submitKeyWords(BuildContext context) async {
    List result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return AddToListScreen(tileType: EnumTileType.keyWord, list: keyWords, title: Constants.key_words(), unit: unit);
      }),
    );

    if (result != null) keyWords = result;
  }

  submitPortions(BuildContext context) async {
    final model = context.read(providerRecipeCreateViewModel);

    Map result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return AddPortionsScreen(unit: model.unit, map: model.portions);
      }),
    );

    if (result != null) {
      model.portions = result;
    }
  }

  onPressed(BuildContext context, dynamic element) async {
    var result = await Navigator.of(context).pushNamed(AppRoute.productDetailsScreen,
        arguments: ProductDetailsScreenArguments(
          ingredient: element,
        ));

    if (result != null) {
      ingredients[ingredients.indexOf(element)] = result;
    }
    _calc();
  }

  onDismissed(BuildContext context, dynamic element) {
    ingredients.remove(element);
    _calc();
  }

  onSearch(BuildContext context) async {
    var result = await Navigator.of(context).pushNamed(AppRoute.searchScreen,
        arguments: SearchScreenArguments(favoriteScreen: FavoriteScreen.onlyProducts, title: Constants.favorites()));
    if (result != null) ingredients.add(result);
    _calc();
  }
}
