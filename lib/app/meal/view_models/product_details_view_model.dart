import 'package:easy_localization/easy_localization.dart';
import 'package:fitable/app/favorite/models/favorite_model.dart';
import 'package:fitable/app/home/view_models/app_view_model.dart';
import 'package:fitable/app/meal/models/ingredient_model.dart';
import 'package:fitable/app/meal/models/meal_model.dart';
import 'package:fitable/app/meal/models/portion_model.dart';
import 'package:fitable/app/meal/models/product_model.dart';
import 'package:fitable/app/meal/product_create_screen.dart';
import 'package:fitable/constants/enums.dart';
import 'package:fitable/routers/route_generator.dart';
import 'package:fitable/services/macro.dart';
import 'package:fitable/services/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

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
  dynamic element;

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
    _sizeListener = sizeListener != null ? sizeListener : Macro.getSize(element);
    notifyListeners();
  }

  bool get isFavorite => _isFavorite;

  List<Ingredient> isIngredient() {
    return element.runtimeType == Ingredient ? element.toList() : null;
  }

  build(dynamic element, List<Favorite> favorites) {
    _createScreen = true;

    if (initState) {
      this.element = element;
      _sizeListener = Macro.getSize(element);
      _selectedPortion = Macro.getSelectedPortion(element);
      initState = false;
    }

    _calories = Macro.calculateCalories(element, sizeListener, _selectedPortion).round();
    _proteins = Macro.calculateProteins(element, sizeListener, _selectedPortion);
    _carbs = Macro.calculateCarbs(element, sizeListener, _selectedPortion);
    _fats = Macro.calculateFats(element, sizeListener, _selectedPortion);

    _isFavorite = false;

    favorites.forEach((e) {
      if (e.id == Macro.getId(element) && e.type == EnumFavorite.products) _isFavorite = true;
    });

    _createScreen = false;
  }

  submit({@required BuildContext context}) {
    Ingredient result = Ingredient(selectedPortion: selectedPortion, product: Macro.getProduct(element), size: sizeListener);

    Navigator.pop(context, result);
  }

  bugReport(BuildContext context) {
    Product product = Macro.getProduct(element);

    Navigator.of(context)
        .pushNamed(AppRoute.createProductScreen, arguments: ProductCreateScreenArguments(product: product, barcode: product.barcode));
  }
}
