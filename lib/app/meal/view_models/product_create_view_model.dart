import 'package:fitable/app/add_to_list/add_to_list_screen.dart';
import 'package:fitable/models/issue_report_model.dart';
import 'package:fitable/models/portion_model.dart';
import 'package:fitable/models/product_model.dart';

import 'package:fitable/common_widgets/custom_list_view.dart';
import 'package:fitable/common_widgets/show_input_picker.dart';
import 'package:fitable/services/services.dart';
import 'package:fitable/utilities/languages.dart';
import 'package:fitable/utilities/enums.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:logger/logger.dart';

final providerProductCreateViewModel = ChangeNotifierProvider.autoDispose<ProductCreateViewModel>((ref) {
  return ProductCreateViewModel();
});

class ProductCreateViewModel extends ChangeNotifier {
  Product _oldProduct;
  Product get oldProduct => _oldProduct;

  Product _newProduct;
  Product get newProduct => _newProduct;
  set newProduct(Product newProduct) {
    _newProduct = newProduct;

    if (oldProduct != null) {
      Color _color = Colors.indigo;
      _nameColor = oldProduct.name != newProduct.name ? _color : null;
      _caloriesColor = oldProduct.calories != newProduct.calories ? _color : null;
      _proteinsColor = oldProduct.proteins != newProduct.proteins ? _color : null;
      _carbsColor = oldProduct.carbs != newProduct.carbs ? _color : null;
      _fatsColor = oldProduct.fats != newProduct.fats ? _color : null;
      _sugarColor = oldProduct.sugar != newProduct.sugar ? _color : null;
      _animalProteinsColor = oldProduct.animalProteins != newProduct.animalProteins ? _color : null;
      _plantProteinsColor = oldProduct.plantProteins != newProduct.plantProteins ? _color : null;
      _saturatedColor = oldProduct.saturated != newProduct.saturated ? _color : null;
      _unsaturatedColor = oldProduct.unsaturated != newProduct.unsaturated ? _color : null;
      _omega3Color = oldProduct.omega3 != newProduct.omega3 ? _color : null;
      _omega6Color = oldProduct.omega6 != newProduct.omega6 ? _color : null;
      _fiberColor = oldProduct.fiber != newProduct.fiber ? _color : null;
      _caffeineColor = oldProduct.caffeine != newProduct.caffeine ? _color : null;
      _cholesterolColor = oldProduct.cholesterol != newProduct.cholesterol ? _color : null;
      _saltColor = oldProduct.salt != newProduct.salt ? _color : null;
      _vitaminAColor = oldProduct.vitaminA != newProduct.vitaminA ? _color : null;
      _vitaminCColor = oldProduct.vitaminC != newProduct.vitaminC ? _color : null;
      _vitaminDColor = oldProduct.vitaminD != newProduct.vitaminD ? _color : null;
      _vitaminEColor = oldProduct.vitaminE != newProduct.vitaminE ? _color : null;
      _vitaminKColor = oldProduct.vitaminK != newProduct.vitaminK ? _color : null;
      _vitaminB1Color = oldProduct.vitaminB1 != newProduct.vitaminB1 ? _color : null;
      _vitaminB2Color = oldProduct.vitaminB2 != newProduct.vitaminB2 ? _color : null;
      _vitaminB3Color = oldProduct.vitaminB3 != newProduct.vitaminB3 ? _color : null;
      _vitaminB5Color = oldProduct.vitaminB5 != newProduct.vitaminB5 ? _color : null;
      _vitaminB6Color = oldProduct.vitaminB6 != newProduct.vitaminB6 ? _color : null;
      _vitaminB7Color = oldProduct.vitaminB7 != newProduct.vitaminB7 ? _color : null;
      _vitaminB9Color = oldProduct.vitaminB9 != newProduct.vitaminB9 ? _color : null;
      _vitaminB12Color = oldProduct.vitaminB12 != newProduct.vitaminB12 ? _color : null;
      _potassiumColor = oldProduct.potassium != newProduct.potassium ? _color : null;
      _sodiumColor = oldProduct.sodium != newProduct.sodium ? _color : null;
      _calciumColor = oldProduct.calcium != newProduct.calcium ? _color : null;
      _magnesiumColor = oldProduct.magnesium != newProduct.magnesium ? _color : null;
      _phosphorusColor = oldProduct.phosphorus != newProduct.phosphorus ? _color : null;
      _copperColor = oldProduct.copper != newProduct.copper ? _color : null;
      _zincColor = oldProduct.zinc != newProduct.zinc ? _color : null;
      _seleniumColor = oldProduct.selenium != newProduct.selenium ? _color : null;
      _manganeseColor = oldProduct.magnesium != newProduct.magnesium ? _color : null;
      _iodineColor = oldProduct.iodine != newProduct.iodine ? _color : null;
      _chromiumColor = oldProduct.chromium != newProduct.chromium ? _color : null;
    }

    notifyListeners();
  }

  List<String> get listPrimary {
    return [
      'fruits_vegetables_mushrooms',
      'dairy_eggs',
      'meat',
      'groceries',
      'frozen_foods',
      'supplements',
      'drinks',
      'other',
    ];
  }

  List<String> get listSecondary {
    switch (newProduct.categoryPrimary) {
      case "fruits_vegetables_mushrooms":
        return ['fruits', 'vegetables', 'mushrooms'];
        break;
      case 'dairy_eggs':
        return ['milk_cream', 'butter_margarine', 'yogurt_desserts', 'cheeses', 'cottage_cheeses', 'eggs', 'other'];
        break;
      case 'meat':
        return ['poultry', 'beef', 'pork', 'rabbit', 'venison', 'fishes_seafood', 'sausages'];
        break;
      case 'groceries':
        return ['ready_meals', 'canned', 'preserves', 'spices', 'sauces_oils_vinegar', 'loose_grain_products', 'snacks_sweets', 'bread', 'other'];
        break;
      case 'frozen_foods':
        return ['ready_meals', 'fishes_seafood', 'vegetables_fruits'];
        break;
      default:
        {
          return [];
        }
    }
  }

  Color _nameColor;
  Color get nameColor => _nameColor;

  Color _caloriesColor;
  Color get caloriesColor => _caloriesColor;

  Color _proteinsColor;
  Color get proteinsColor => _proteinsColor;

  Color _carbsColor;
  Color get carbsColor => _carbsColor;

  Color _fatsColor;
  Color get fatsColor => _fatsColor;

  Color _sugarColor;
  Color get sugarColor => _sugarColor;

  Color _animalProteinsColor;
  Color get animalProteinsColor => _animalProteinsColor;

  Color _plantProteinsColor;
  Color get plantProteinsColor => _plantProteinsColor;

  Color _saturatedColor;
  Color get saturatedColor => _saturatedColor;

  Color _unsaturatedColor;
  Color get unsaturatedColor => _unsaturatedColor;

  Color _omega3Color;
  Color get omega3Color => _omega3Color;

  Color _omega6Color;
  Color get omega6Color => _omega6Color;

  Color _fiberColor;
  Color get fiberColor => _fiberColor;

  Color _caffeineColor;
  Color get caffeineColor => _caffeineColor;

  Color _cholesterolColor;
  Color get cholesterolColor => _cholesterolColor;

  Color _saltColor;
  Color get saltColor => _saltColor;

  Color _vitaminAColor;
  Color get vitaminAColor => _vitaminAColor;

  Color _vitaminCColor;
  Color get vitaminCColor => _vitaminCColor;

  Color _vitaminDColor;
  Color get vitaminDColor => _vitaminDColor;

  Color _vitaminEColor;
  Color get vitaminEColor => _vitaminEColor;

  Color _vitaminKColor;
  Color get vitaminKColor => _vitaminKColor;

  Color _vitaminB1Color;
  Color get vitaminB1Color => _vitaminB1Color;

  Color _vitaminB2Color;
  Color get vitaminB2Color => _vitaminB2Color;

  Color _vitaminB3Color;
  Color get vitaminB3Color => _vitaminB3Color;

  Color _vitaminB5Color;
  Color get vitaminB5Color => _vitaminB5Color;

  Color _vitaminB6Color;
  Color get vitaminB6Color => _vitaminB6Color;

  Color _vitaminB7Color;
  Color get vitaminB7Color => _vitaminB7Color;

  Color _vitaminB9Color;
  Color get vitaminB9Color => _vitaminB9Color;

  Color _vitaminB12Color;
  Color get vitaminB12eColor => _vitaminB12Color;

  Color _potassiumColor;
  Color get potassiumColor => _potassiumColor;

  Color _sodiumColor;
  Color get sodiumColor => _sodiumColor;

  Color _calciumColor;
  Color get calciumColor => _calciumColor;

  Color _magnesiumColor;
  Color get magnesiumColor => _magnesiumColor;

  Color _phosphorusColor;
  Color get phosphorusColor => _phosphorusColor;

  Color _ironColor;
  Color get ironColor => _ironColor;

  Color _copperColor;
  Color get copperColor => _copperColor;

  Color _zincColor;
  Color get zincColor => _zincColor;

  Color _seleniumColor;
  Color get seleniumColor => _seleniumColor;

  Color _manganeseColor;
  Color get manganeseColor => _manganeseColor;

  Color _iodineColor;
  Color get iodineColor => _iodineColor;

  Color _chromiumColor;
  Color get chromiumColor => _chromiumColor;

  createProduct({@required BuildContext context, String description}) {
    context.read(providerPreference.last).then((preference) async {
      newProduct = newProduct.copyWith(localeBase: preference.localeBase);

      if (description != null) {
        Issue issuesReport = Issue(
          elementType: ETypeElement.product,
          id: newProduct.id,
          dateCreate: DateTime.now(),
          description: description,
          element: newProduct,
          issueType: ETypeIssue.correct,
        );

        Navigator.pop(context, issuesReport);
      } else {
        context.read(providerProductsService).createProduct(newProduct);
      }
    });
  }

  initState(Product product, String barcode) {
    _oldProduct = product;
    _newProduct = product ?? Product.empty;
    _newProduct = _newProduct.copyWith(barcode: barcode);
  }

  save(BuildContext context) async {
    if (_oldProduct != null) {
      String _value;
      return showInputPicker(
        context: context,
        hintText: Languages.describe_error(),
        multiLine: true,
        isCancel: true,
        buttonTextYes: Languages.send(),
        onPressed: () {
          createProduct(context: context, description: _value);
          Navigator.pop(context);
        },
        onChanged: (String v) {
          _value = v;
        },
      );
    } else {
      createProduct(context: context);
    }

    Navigator.pop(context);
  }

  setUnit(String unit) {
    newProduct = newProduct.copyWith(portions: [
      Portion(
          name: '${Enums.toText(unit)}',
          type: Enums.toText(unit),
          size: 1,
          unit: Enums.toEnum(
            unit,
            ETypeUnit.values,
          ))
    ]);
  }

  submitKeyWords(BuildContext context) async {
    List result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return AddToListScreen(tileType: EnumTileType.keyWord, list: newProduct.keyWords, title: Languages.key_words());
      }),
    );

    if (result != null) {
      newProduct = newProduct.copyWith(keyWords: result);
    }
  }

  String portionsTXT() {
    String portionsTXT = '';
    newProduct.portions.forEach((element) => portionsTXT += '${Enums.toText(element.type).tr()}: ${element.size}${Enums.toText(element.unit)}, ');
    return portionsTXT;
  }

  submitPortions(BuildContext context) async {
    dynamic result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return AddToListScreen(
            tileType: EnumTileType.portion, list: newProduct.portions, title: Languages.portion(), unit: newProduct.portions.first.unit);
      }),
    );

    if (result != null) {
      List<Portion> list = [];
      result.forEach((element) => list.add(element));
      newProduct = newProduct.copyWith(portions: list);
    }
  }
}
