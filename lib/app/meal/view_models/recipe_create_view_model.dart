import 'package:fitable/app/account/models/account_model.dart';
import 'package:fitable/app/account/models/preference_model.dart';
import 'package:fitable/app/add_to_list/add_to_list_screen.dart';
import 'package:fitable/app/meal/models/ingredient_model.dart';
import 'package:fitable/app/meal/models/portion_model.dart';
import 'package:fitable/app/meal/product_details_screen.dart';
import 'package:fitable/app/media/view_models/image_slider_view_model.dart';
import 'package:fitable/app/search/search_screen.dart';
import 'package:fitable/common_widgets/custom_list_view.dart';
import 'package:fitable/common_widgets/massage_flush_bar.dart';
import 'package:fitable/constants/constants.dart';
import 'package:fitable/constants/enums.dart';
import 'package:fitable/routers/route_generator.dart';
import 'package:fitable/services/macro.dart';
import 'package:fitable/services/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';

final providerRecipeCreateViewModel = ChangeNotifierProvider.autoDispose<RecipeCreateViewModel>((ref) {
  return RecipeCreateViewModel();
});

class RecipeCreateViewModel extends ChangeNotifier {
  List<Ingredient> ingredients = [];

  List<Portion> _portions = [new Portion(name: '${Enums.toText(UnitType.g)}', type: Enums.toText(UnitType.g), size: 1, unit: UnitType.g)];
  List _keyWords;
  UnitType _unit;
  String _access;
  String _videoId;

  String get videoId => _videoId;

  set videoId(String videoId) {
    _videoId = convertUrlToId(videoId);
    notifyListeners();
  }

  static String convertUrlToId(String url, {bool trimWhitespaces = true}) {
    assert(url?.isNotEmpty ?? false, 'Url cannot be empty');
    if (!url.contains("http") && (url.length == 11)) return url;
    if (trimWhitespaces) url = url.trim();

    for (var exp in [
      RegExp(r"^https:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$"),
      RegExp(r"^https:\/\/(?:www\.|m\.)?youtube(?:-nocookie)?\.com\/embed\/([_\-a-zA-Z0-9]{11}).*$"),
      RegExp(r"^https:\/\/youtu\.be\/([_\-a-zA-Z0-9]{11}).*$")
    ]) {
      Match match = exp.firstMatch(url);
      if (match != null && match.groupCount >= 1) return match.group(1);
    }

    return null;
  }

  Duration _timePreparation = Duration(seconds: 0);

  Duration get timePreparation => _timePreparation;

  set timePreparation(Duration timePreparation) {
    _timePreparation = timePreparation;
    notifyListeners();
  }

  String name;
  String description;

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

  UnitType get unit => _unit != null ? _unit : _unit = UnitType.g;
  set unit(UnitType unit) {
    _unit = unit;
    _portions.clear();
    _portions.add(new Portion(name: '${Enums.toText(unit)}', type: Enums.toText(unit), size: 1, unit: unit));
    notifyListeners();
  }

  List<Portion> get portions {
    if (_portions == null) _portions = [];
    return _portions;
  }

  set portions(List<Portion> portions) {
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

  createRecipe(BuildContext context) {
    //TODO Replace string to constants
    FocusScope.of(context).unfocus();

    if ((name?.length ?? 0) < 4) {
      massageFlushBar(context, 'The name of the recipe cannot be empty and must contain more than 3 characters.');
      return;
    }

    if ((description?.length ?? 0) < 11) {
      massageFlushBar(context, 'The description of the recipe cannot be empty and must contain more than 10 characters.');
      return;
    }

    if (ingredients.length < 2) {
      massageFlushBar(context, 'The recipe must consist of at least 2 ingredients.');
      return;
    }

    List sliderList = context.read(providerImageSliderViewModel).sliderList;

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
              portions: portions,
            );

        Navigator.pop(context);
      });
    });
  }

  _calc() {
    _calories = 0;
    _proteins = 0;
    _carbs = 0;
    _fats = 0;

    ingredients.forEach((element) {
      _calories += Macro.calculateCalories(element, element.size, element.selectedPortion);
      _proteins += Macro.calculateProteins(element, element.size, element.selectedPortion);
      _carbs += Macro.calculateCarbs(element, element.size, element.selectedPortion);
      _fats += Macro.calculateFats(element, element.size, element.selectedPortion);
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
    dynamic result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return AddToListScreen(tileType: EnumTileType.portion, list: portions, title: Constants.portion(), unit: unit);
      }),
    );

    if (result != null) {
      List<Portion> list = [];
      result.forEach((element) => list.add(element));
      portions = list;
    }
  }

  String portionsTXT() {
    String portionsTXT = '';
    _portions.forEach((element) => portionsTXT += '${Enums.toText(element.type).tr()}: ${element.size}${Enums.toText(element.unit)}, ');
    return portionsTXT;
  }

  onPressed(BuildContext context, dynamic element) async {
    var result = await Navigator.of(context).pushNamed(
      AppRoute.productDetailsScreen,
      arguments: ProductDetailsScreenArguments(element: element),
    );

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
