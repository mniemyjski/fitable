import 'package:fitable/app/product/models/product_model.dart';
import 'package:fitable/services/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final providerCreateProductViewModel = ChangeNotifierProvider.autoDispose<CreateProductViewModel>((ref) {
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
    final db = context.read(providerDatabase);

    Product product = Product(
        productID: null,
        barcode: barcode,
        productName: productName,
        categoryPrimary: categoryPrimary,
        categorySecondary: categorySecondary,
        localeBase: localeBase,
        keyWords: keyWords,
        portions: portions,
        unit: unit,
        verification: false,
        calories: calories,
        proteins: proteins,
        carbs: carbs,
        fats: fats,
        photosUrl: _photosUrl,
        sugar: sugar != null ? sugar : 0.0,
        animalProteins: animalProteins != null ? animalProteins : 0.0,
        plantProteins: plantProteins != null ? plantProteins : 0.0,
        saturated: saturated != null ? saturated : 0.0,
        unsaturated: unsaturated != null ? unsaturated : 0.0,
        omega3: omega3 != null ? omega3 : 0.0,
        omega6: omega6 != null ? omega6 : 0.0,
        fiber: fiber != null ? fiber : 0.0,
        caffeine: caffeine != null ? caffeine : 0.0,
        cholesterol: cholesterol != null ? cholesterol : 0.0,
        salt: salt != null ? salt : 0.0,
        vitaminA: vitaminA != null ? vitaminA : 0.0,
        vitaminC: vitaminC != null ? vitaminC : 0.0,
        vitaminD: vitaminD != null ? vitaminD : 0.0,
        vitaminE: vitaminE != null ? vitaminE : 0.0,
        vitaminK: vitaminK != null ? vitaminK : 0.0,
        vitaminB1: vitaminB1 != null ? vitaminB1 : 0.0,
        vitaminB2: vitaminB2 != null ? vitaminB2 : 0.0,
        vitaminB3: vitaminB3 != null ? vitaminB3 : 0.0,
        vitaminB5: vitaminB5 != null ? vitaminB5 : 0.0,
        vitaminB6: vitaminB6 != null ? vitaminB6 : 0.0,
        vitaminB7: vitaminB7 != null ? vitaminB7 : 0.0,
        vitaminB9: vitaminB9 != null ? vitaminB9 : 0.0,
        vitaminB12: vitaminB12 != null ? vitaminB12 : 0.0,
        potassium: potassium != null ? potassium : 0.0,
        sodium: sodium != null ? sodium : 0.0,
        calcium: calcium != null ? calcium : 0.0,
        magnesium: magnesium != null ? magnesium : 0.0,
        phosphorus: phosphorus != null ? phosphorus : 0.0,
        iron: iron != null ? iron : 0.0,
        copper: copper != null ? copper : 0.0,
        zinc: zinc != null ? zinc : 0.0,
        selenium: selenium != null ? selenium : 0.0,
        manganese: manganese != null ? manganese : 0.0,
        iodine: iodine != null ? iodine : 0.0,
        chromium: chromium != null ? chromium : 0.0);

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

  String get localeBase {
    if (_localeBase == null) _localeBase = 'pl_PL';
    return _localeBase;
  }

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
