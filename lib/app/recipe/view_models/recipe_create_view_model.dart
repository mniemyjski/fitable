import 'dart:async';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fitable/app/product/add_key_words_screen.dart';
import 'package:fitable/app/product/add_portions_screen.dart';
import 'package:fitable/app/product/models/ingredient_model.dart';
import 'package:fitable/app/product/product_details_screen.dart';
import 'package:fitable/app/search/search_screen.dart';
import 'package:fitable/routers/route_generator.dart';
import 'package:fitable/services/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

final providerRecipeCreateViewModel = ChangeNotifierProvider.autoDispose<RecipeCreateViewModel>((ref) {
  return RecipeCreateViewModel();
});

class RecipeCreateViewModel extends ChangeNotifier {
  List<Ingredient> ingredients = [];
  List<String> sliderList = [
    '',
    '1',
  ];

  Map _portions;
  List _keyWords;
  String _unit;
  String _visible;
  bool _mute;
  final CarouselController carouselController = CarouselController();
  YoutubePlayerController controller;
  int _current;

  int get current => _current != null ? _current : _current = 0;

  set current(int current) {
    if (current == 0 && sliderList[0] != '') {
      Future.delayed(Duration(seconds: 1)).then((value) => controller.load(sliderList[0]));
    }
    _current = current;
    notifyListeners();
  }

  addImage() async {
    final picker = ImagePicker();
    var pickedFile = await picker.getImage(source: ImageSource.gallery);
    File file = File(pickedFile.path);
    sliderList[_current] = file.path;

    if (sliderList.length == _current + 1 && sliderList.length < 7) {
      sliderList.add((_current + 1).toString());
      carouselController.nextPage();
    }
    notifyListeners();
  }

  cropImage() async {
    File file = File(sliderList[_current]);
    File cropped = await ImageCropper.cropImage(sourcePath: file.path);
    sliderList[_current] = cropped.path;
    notifyListeners();
  }

  removeImage() {
    if (sliderList.length > 2) {
      int _item = _current;
      carouselController.previousPage();
      sliderList.removeAt(_item);
    } else
      sliderList[1] = '1';
    notifyListeners();
  }

  String get videoId => sliderList[0];

  set videoId(String videoId) {
    sliderList[0] = videoId;
    controller.load(sliderList[0]);
    notifyListeners();
  }

  bool get mute => _mute != null ? _mute : _mute = true;

  set mute(bool mute) {
    _mute = mute;
    notifyListeners();
  }

  String get visible => _visible != null ? _visible : _visible = 'private';

  set visible(String visible) {
    if (visible.isNotEmpty) {
      _visible = visible;
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
    final model = context.read(providerRecipeCreateViewModel);

    List result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return AddKeyWordsScreen(model.keyWords);
      }),
    );

    if (result != null) {
      model.keyWords = result;
    }
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
    var result = await Navigator.of(context).pushNamed(AppRoute.searchScreen, arguments: SearchScreenArguments(typeSearch: SearchType.onlyProducts));
    if (result != null) ingredients.add(result);
    _calc();
  }
}
