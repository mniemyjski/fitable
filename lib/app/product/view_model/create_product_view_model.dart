import 'package:fitable/app/product/models/product_model.dart';
import 'package:fitable/services/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final providerCreateProductViewModel = ChangeNotifierProvider<CreateProductViewModel>((ref) {
  return CreateProductViewModel();
});

class CreateProductViewModel extends ChangeNotifier {
  String _productName;
  String _categoryPrimary;
  String _categorySecondary;
  String _localeBase;
  String _unit;
  List<String> _keyWords;
  Map<String, double> _portions;
  int _calories;
  double _proteins;
  double _carbs;
  double _fats;
  double _sugar;
  double _animalProteins;
  double _plantProteins;
  double _saturated;
  double _unsaturated;
  double _omega3;
  double _omega6;
  double _fiber;
  double _caffeine;
  double _cholesterol;
  double _salt;
  double _vitaminA;
  double _vitaminC;
  double _vitaminD;
  double _vitaminE;
  double _vitaminK;
  double _vitaminB1;
  double _vitaminB2;
  double _vitaminB3;
  double _vitaminB5;
  double _vitaminB6;
  double _vitaminB7;
  double _vitaminB9;
  double _vitaminB12;
  double _potassium;
  double _sodium;
  double _calcium;
  double _magnesium;
  double _phosphorus;
  double _iron;
  double _copper;
  double _zinc;
  double _selenium;
  double _manganese;
  double _iodine;
  double _chromium;
  Map _photosUrl;

  void clear() {
    _productName = null;
    _categoryPrimary = null;
    _categorySecondary = null;
    _localeBase = null;
    _unit = null;
    _keyWords = null;
    _portions = null;
    _calories = null;
    _proteins = null;
    _carbs = null;
    _fats = null;
    _sugar = null;
    _animalProteins = null;
    _plantProteins = null;
    _saturated = null;
    _unsaturated = null;
    _omega3 = null;
    _omega6 = null;
    _fiber = null;
    _caffeine = null;
    _cholesterol = null;
    _salt = null;
    _vitaminA = null;
    _vitaminC = null;
    _vitaminD = null;
    _vitaminE = null;
    _vitaminK = null;
    _vitaminB1 = null;
    _vitaminB2 = null;
    _vitaminB3 = null;
    _vitaminB5 = null;
    _vitaminB6 = null;
    _vitaminB7 = null;
    _vitaminB9 = null;
    _vitaminB12 = null;
    _potassium = null;
    _sodium = null;
    _calcium = null;
    _magnesium = null;
    _phosphorus = null;
    _iron = null;
    _copper = null;
    _zinc = null;
    _selenium = null;
    _manganese = null;
    _iodine = null;
    _chromium = null;
    _photosUrl = null;
    notifyListeners();
  }

  List<String> get listSecondary {
    switch (_categoryPrimary) {
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

  submit({@required BuildContext context, @required String barcode}) {
    Product product = Product(
        productID: null,
        barcode: barcode,
        productName: _productName,
        categoryPrimary: _categoryPrimary,
        categorySecondary: _categorySecondary,
        localeBase: _localeBase,
        keyWords: _keyWords,
        portions: null,
        unit: _unit,
        verification: false,
        calories: _calories,
        proteins: _proteins,
        carbs: _carbs,
        fats: _fats,
        photosUrl: _photosUrl,
        sugar: _sugar != null ? _sugar : 0.0,
        animalProteins: _animalProteins != null ? _animalProteins : 0.0,
        plantProteins: _plantProteins != null ? _plantProteins : 0.0,
        saturated: _saturated != null ? _saturated : 0.0,
        unsaturated: _unsaturated != null ? _unsaturated : 0.0,
        omega3: _omega3 != null ? _omega3 : 0.0,
        omega6: _omega6 != null ? _omega6 : 0.0,
        fiber: _fiber != null ? _fiber : 0.0,
        caffeine: _caffeine != null ? _caffeine : 0.0,
        cholesterol: _cholesterol != null ? _cholesterol : 0.0,
        salt: _salt != null ? _salt : 0.0,
        vitaminA: _vitaminA != null ? _vitaminA : 0.0,
        vitaminC: _vitaminC != null ? _vitaminC : 0.0,
        vitaminD: _vitaminD != null ? _vitaminD : 0.0,
        vitaminE: _vitaminE != null ? _vitaminE : 0.0,
        vitaminK: _vitaminK != null ? _vitaminK : 0.0,
        vitaminB1: _vitaminB1 != null ? _vitaminB1 : 0.0,
        vitaminB2: _vitaminB2 != null ? _vitaminB2 : 0.0,
        vitaminB3: _vitaminB3 != null ? _vitaminB3 : 0.0,
        vitaminB5: _vitaminB5 != null ? _vitaminB5 : 0.0,
        vitaminB6: _vitaminB6 != null ? _vitaminB6 : 0.0,
        vitaminB7: _vitaminB7 != null ? _vitaminB7 : 0.0,
        vitaminB9: _vitaminB9 != null ? _vitaminB9 : 0.0,
        vitaminB12: _vitaminB12 != null ? _vitaminB12 : 0.0,
        potassium: _potassium != null ? _potassium : 0.0,
        sodium: _sodium != null ? _sodium : 0.0,
        calcium: _calcium != null ? _calcium : 0.0,
        magnesium: _magnesium != null ? _magnesium : 0.0,
        phosphorus: _phosphorus != null ? _phosphorus : 0.0,
        iron: _iron != null ? _iron : 0.0,
        copper: _copper != null ? _copper : 0.0,
        zinc: _zinc != null ? _zinc : 0.0,
        selenium: _selenium != null ? _selenium : 0.0,
        manganese: _manganese != null ? _manganese : 0.0,
        iodine: _iodine != null ? _iodine : 0.0,
        chromium: _chromium != null ? _chromium : 0.0);

    final db = context.read(providerDatabase);
    db.createProduct(product);
  }

  List<String> get keyWords {
    if (_keyWords == null) _keyWords = [];
    return _keyWords;
  }

  set keyWords(List<String> keywords) {
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

  Map<String, double> get portions {
    if (_portions == null) _portions = new Map<String, double>();
    return _portions;
  }

  set portions(Map<String, double> portions) {
    _portions = portions;
    notifyListeners();
  }

  String get productName => _productName;
  set productName(String productName) {
    if (productName.isNotEmpty) _productName = productName;
  }

  String get categoryPrimary => _categoryPrimary;
  set categoryPrimary(String categoryPrimary) {
    if (categoryPrimary.isNotEmpty) {
      _categoryPrimary = categoryPrimary;
      _categorySecondary = null;
      notifyListeners();
    }
  }

  String get categorySecondary => _categorySecondary;
  set categorySecondary(String categorySecondary) {
    if (categorySecondary.isNotEmpty) {
      _categorySecondary = categorySecondary;
      notifyListeners();
    }
  }

  String get localeBase => _localeBase;
  set localeBase(String localeBase) {
    if (localeBase.isNotEmpty) _localeBase = localeBase;
  }

  int get calories => _calories;
  set calories(int calories) {
    if (calories != null) _calories = calories;
  }

  double get proteins => _proteins;
  set proteins(double proteins) {
    if (proteins != null) _proteins = proteins;
  }

  double get carbs => _carbs;
  set carbs(double carbs) {
    if (carbs != null) _carbs = carbs;
  }

  double get fats => _fats;
  set fats(double fats) {
    if (fats != null) _fats = fats;
  }

  double get sugar => _sugar;
  set sugar(double sugar) {
    if (sugar != null) _sugar = sugar;
  }

  double get animalProteins => _animalProteins;
  set animalProteins(double animalProteins) {
    if (animalProteins != null) _animalProteins = animalProteins;
  }

  double get plantProteins => _plantProteins;
  set plantProteins(double plantProteins) {
    if (plantProteins != null) _plantProteins = plantProteins;
  }

  double get saturated => _saturated;
  set saturated(double saturated) {
    if (saturated != null) _saturated = saturated;
  }

  double get unsaturated => _unsaturated;
  set unsaturated(double unsaturated) {
    if (unsaturated != null) _unsaturated = unsaturated;
  }

  double get omega3 => _omega3;
  set omega3(double omega3) {
    if (omega3 != null) _omega3 = omega3;
  }

  double get omega6 => _omega6;
  set omega6(double omega6) {
    if (omega6 != null) _omega6 = omega6;
  }

  double get fiber => _fiber;
  set fiber(double fiber) {
    if (fiber != null) _fiber = fiber;
  }

  double get caffeine => _caffeine;
  set caffeine(double caffeine) {
    if (caffeine != null) _caffeine = caffeine;
  }

  double get cholesterol => _cholesterol;
  set cholesterol(double cholesterol) {
    if (cholesterol != null) _cholesterol = cholesterol;
  }

  double get salt => _salt;
  set salt(double salt) {
    if (salt != null) _salt = salt;
  }

  double get vitaminA => _vitaminA;
  set vitaminA(double vitaminA) {
    if (vitaminA != null) _vitaminA = vitaminA;
  }

  double get vitaminC => _vitaminC;
  set vitaminC(double vitaminC) {
    if (vitaminC != null) _vitaminC = vitaminC;
  }

  double get vitaminD => _vitaminD;
  set vitaminD(double vitaminD) {
    if (vitaminD != null) _vitaminD = vitaminD;
  }

  double get vitaminE => _vitaminE;
  set vitaminE(double vitaminE) {
    if (vitaminE != null) _vitaminE = vitaminE;
  }

  double get vitaminK => _vitaminK;
  set vitaminK(double vitaminK) {
    if (vitaminK != null) _vitaminK = vitaminK;
  }

  double get vitaminB1 => _vitaminB1;
  set vitaminB1(double vitaminB1) {
    if (vitaminB1 != null) _vitaminB1 = vitaminB1;
  }

  double get vitaminB2 => _vitaminB2;
  set vitaminB2(double vitaminB2) {
    if (vitaminB2 != null) _vitaminB2 = vitaminB2;
  }

  double get vitaminB3 => _vitaminB3;
  set vitaminB3(double vitaminB3) {
    if (vitaminB3 != null) _vitaminB3 = vitaminB3;
  }

  double get vitaminB5 => _vitaminB5;
  set vitaminB5(double vitaminB5) {
    if (vitaminB5 != null) _vitaminB5 = vitaminB5;
  }

  double get vitaminB6 => _vitaminB6;
  set vitaminB6(double vitaminB6) {
    if (vitaminB6 != null) _vitaminB6 = vitaminB6;
  }

  double get vitaminB7 => _vitaminB7;
  set vitaminB7(double vitaminB7) {
    if (vitaminB7 != null) _vitaminB7 = vitaminB7;
  }

  double get vitaminB9 => _vitaminB9;
  set vitaminB9(double vitaminB9) {
    if (vitaminB9 != null) _vitaminB9 = vitaminB9;
  }

  double get vitaminB12 => _vitaminB12;
  set vitaminB12(double vitaminB12) {
    if (vitaminB12 != null) _vitaminB12 = vitaminB12;
  }

  double get potassium => _potassium;
  set potassium(double potassium) {
    if (potassium != null) _potassium = potassium;
  }

  double get sodium => _sodium;
  set sodium(double sodium) {
    if (sodium != null) _sodium = sodium;
  }

  double get calcium => _calcium;
  set calcium(double calcium) {
    if (calcium != null) _calcium = calcium;
  }

  double get magnesium => _magnesium;
  set magnesium(double magnesium) {
    if (magnesium != null) _magnesium = magnesium;
  }

  double get phosphorus => _phosphorus;
  set phosphorus(double phosphorus) {
    if (phosphorus != null) _phosphorus = phosphorus;
  }

  double get iron => _iron;
  set iron(double iron) {
    if (iron != null) _iron = iron;
  }

  double get copper => _copper;
  set copper(double copper) {
    if (copper != null) _copper = copper;
  }

  double get zinc => _zinc;
  set zinc(double zinc) {
    if (zinc != null) _zinc = zinc;
  }

  double get selenium => _selenium;
  set selenium(double selenium) {
    if (selenium != null) _selenium = selenium;
  }

  double get manganese => _manganese;
  set manganese(double manganese) {
    if (manganese != null) _manganese = manganese;
  }

  double get iodine => _iodine;
  set iodine(double iodine) {
    if (iodine != null) _iodine = iodine;
  }

  double get chromium => _chromium;
  set chromium(double chromium) {
    if (chromium != null) _chromium = chromium;
  }
}
