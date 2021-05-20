import 'package:fitable/models/favorite_model.dart';
import 'package:fitable/models/ingredient_model.dart';
import 'package:fitable/models/portion_model.dart';
import 'package:fitable/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitable/utilities/enums.dart';

final providerProductDetailsViewModel = ChangeNotifierProvider.autoDispose<ProductDetailsViewModel>((ref) {
  return ProductDetailsViewModel();
});

class ProductDetailsViewModel extends ChangeNotifier {
  int _calories;
  int get calories => _calories;
  double _proteins;
  double get proteins => _proteins;
  double _carbs;
  double get carbs => _carbs;
  double _fats;
  double get fats => _fats;
  bool initState = true;
  Portion _selectedPortion;
  Portion get selectedPortion => _selectedPortion;
  Ingredient element;

  set selectedPortion(Portion selectedPortion) {
    _selectedPortion = selectedPortion;
    notifyListeners();
  }

  bool _isFavorite;
  bool _createScreen = true;
  bool get createScreen => _createScreen;
  double _sizeListener;

  double get sizeListener => _sizeListener;

  set sizeListener(double sizeListener) {
    _sizeListener = sizeListener != null ? sizeListener : element.size;
    notifyListeners();
  }

  bool get isFavorite => _isFavorite;

  List<Ingredient> isIngredient() {
    return element.runtimeType == Ingredient ? element.toList() : null;
  }

  init(Ingredient element, List<Favorite> favorites) {
    _createScreen = true;

    if (initState) {
      this.element = element;
      _sizeListener = element.size;
      _selectedPortion = element.selectedPortion;
      initState = false;
    }

    _calories = 0;
    _proteins = 0;
    _carbs = 0;
    _fats = 0;
    _calories = element.getCalories(portionSize: sizeListener, selectedSize: selectedPortion.size);
    _proteins = element.getProteins(portionSize: sizeListener, selectedSize: selectedPortion.size);
    _carbs = element.getCarbs(portionSize: sizeListener, selectedSize: selectedPortion.size);
    _fats = element.getFats(portionSize: sizeListener, selectedSize: selectedPortion.size);

    _isFavorite = false;

    favorites.where((e) => (e.id == element.getId() && e.type == TypeFavorite.products) ? _isFavorite = true : null);

    _createScreen = false;
  }

  submit({@required BuildContext context}) {
    Ingredient result = Ingredient(selectedPortion: selectedPortion, product: element.product, size: sizeListener);

    Navigator.pop(context, result);
  }
}
