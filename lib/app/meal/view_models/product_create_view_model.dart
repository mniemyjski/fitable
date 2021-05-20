import 'package:fitable/models/preference_model.dart';
import 'package:fitable/app/add_to_list/add_to_list_screen.dart';
import 'package:fitable/models/issue_report_model.dart';
import 'package:fitable/models/portion_model.dart';
import 'package:fitable/models/product_model.dart';
import 'package:fitable/app/meal/product_create_screen.dart';
import 'package:fitable/common_widgets/custom_list_view.dart';
import 'package:fitable/common_widgets/show_input_picker.dart';
import 'package:fitable/utilities/languages.dart';
import 'package:fitable/utilities/enums.dart';
import 'package:fitable/utilities/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:logger/logger.dart';

final providerProductCreateViewModel = ChangeNotifierProvider.autoDispose<ProductCreateViewModel>((ref) {
  return ProductCreateViewModel();
});

class ProductCreateViewModel extends ChangeNotifier {
  Product _oldProduct;
  String _categoryPrimary;
  String _categorySecondary;
  String _localeBase;
  ETypeUnit _unit;
  List _keyWords = [];
  List<Portion> _portions;
  Map _photosUrl;
  String barcode;
  Product product;

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

  List get keyWords {
    if (_keyWords == null) _keyWords = [];
    return _keyWords;
  }

  set keyWords(List keywords) {
    _keyWords = keywords;
    notifyListeners();
  }

  ETypeUnit get unit => _unit != null ? _unit : _unit = ETypeUnit.g;
  set unit(ETypeUnit unit) {
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

  String _productName;
  Color _productNameColor;
  Color get productNameColor => _productNameColor;
  String get productName => _productName;
  set productName(String productName) {
    _productNameColor = (_oldProduct != null && _oldProduct.name != productName) ? Colors.indigo : null;
    if (productName.isNotEmpty) _productName = productName;
    notifyListeners();
  }

  int _calories;
  Color _caloriesColor;
  Color get caloriesColor => _caloriesColor;
  int get calories => _calories ?? 0;
  set calories(int calories) {
    _caloriesColor = (_oldProduct != null && _oldProduct.calories != calories) ? Colors.indigo : null;
    if (calories != null) _calories = calories;
    notifyListeners();
  }

  double _proteins;
  Color _proteinsColor;
  Color get proteinsColor => _proteinsColor;
  double get proteins => _proteins ?? 0;
  set proteins(double proteins) {
    _proteinsColor = (_oldProduct != null && _oldProduct.proteins != proteins) ? Colors.indigo : null;
    if (proteins != null) _proteins = proteins;
    notifyListeners();
  }

  double _carbs;
  Color _carbsColor;
  Color get carbsColor => _carbsColor;
  double get carbs => _carbs ?? 0;
  set carbs(double carbs) {
    _carbsColor = (_oldProduct != null && _oldProduct.carbs != carbs) ? Colors.indigo : null;
    if (carbs != null) _carbs = carbs;
    notifyListeners();
  }

  double _fats;
  Color _fatsColor;
  Color get fatsColor => _fatsColor;
  double get fats => _fats ?? 0;
  set fats(double fats) {
    _fatsColor = (_oldProduct != null && _oldProduct.calories != calories) ? Colors.indigo : null;
    if (fats != null) _fats = fats;
    notifyListeners();
  }

  double _sugar;
  Color _sugarColor;
  Color get sugarColor => _sugarColor;
  double get sugar => _sugar ?? 0;
  set sugar(double sugar) {
    _sugarColor = (_oldProduct != null && _oldProduct.sugar != sugar) ? Colors.indigo : null;
    if (sugar != null) _sugar = sugar;
    notifyListeners();
  }

  double _animalProteins;
  Color _animalProteinsColor;
  Color get animalProteinsColor => _animalProteinsColor;
  double get animalProteins => _animalProteins ?? 0;
  set animalProteins(double animalProteins) {
    _animalProteinsColor = (_oldProduct != null && _oldProduct.animalProteins != animalProteins) ? Colors.indigo : null;
    if (animalProteins != null) _animalProteins = animalProteins;
    notifyListeners();
  }

  double _plantProteins;
  Color _plantProteinsColor;
  Color get plantProteinsColor => _plantProteinsColor;
  double get plantProteins => _plantProteins ?? 0;
  set plantProteins(double plantProteins) {
    _plantProteinsColor = (_oldProduct != null && _oldProduct.plantProteins != plantProteins) ? Colors.indigo : null;
    if (plantProteins != null) _plantProteins = plantProteins;
    notifyListeners();
  }

  double _saturated;
  Color _saturatedColor;
  Color get saturatedColor => _saturatedColor;
  double get saturated => _saturated ?? 0;
  set saturated(double saturated) {
    _saturatedColor = (_oldProduct != null && _oldProduct.saturated != saturated) ? Colors.indigo : null;
    if (saturated != null) _saturated = saturated;
    notifyListeners();
  }

  double _unsaturated;
  Color _unsaturatedColor;
  Color get unsaturatedColor => _unsaturatedColor;
  double get unsaturated => _unsaturated ?? 0;
  set unsaturated(double unsaturated) {
    _unsaturatedColor = (_oldProduct != null && _oldProduct.unsaturated != unsaturated) ? Colors.indigo : null;
    if (unsaturated != null) _unsaturated = unsaturated;
    notifyListeners();
  }

  double _omega3;
  Color _omega3Color;
  Color get omega3Color => _omega3Color;
  double get omega3 => _omega3 ?? 0;
  set omega3(double omega3) {
    _omega3Color = (_oldProduct != null && _oldProduct.omega3 != omega3) ? Colors.indigo : null;
    if (omega3 != null) _omega3 = omega3;
    notifyListeners();
  }

  double _omega6;
  Color _omega6Color;
  Color get omega6Color => _omega6Color;
  double get omega6 => _omega6 ?? 0;
  set omega6(double omega6) {
    _omega6Color = (_oldProduct != null && _oldProduct.omega6 != omega6) ? Colors.indigo : null;
    if (omega6 != null) _omega6 = omega6;
    notifyListeners();
  }

  double _fiber;
  Color _fiberColor;
  Color get fiberColor => _fiberColor;
  double get fiber => _fiber ?? 0;
  set fiber(double fiber) {
    _fiberColor = (_oldProduct != null && _oldProduct.fiber != fiber) ? Colors.indigo : null;
    if (fiber != null) _fiber = fiber;
    notifyListeners();
  }

  double _caffeine;
  Color _caffeineColor;
  Color get caffeineColor => _caffeineColor;
  double get caffeine => _caffeine ?? 0;
  set caffeine(double caffeine) {
    _caffeineColor = (_oldProduct != null && _oldProduct.caffeine != caffeine) ? Colors.indigo : null;
    if (caffeine != null) _caffeine = caffeine;
    notifyListeners();
  }

  double _cholesterol;
  Color _cholesterolColor;
  Color get cholesterolColor => _cholesterolColor;
  double get cholesterol => _cholesterol ?? 0;
  set cholesterol(double cholesterol) {
    _cholesterolColor = (_oldProduct != null && _oldProduct.cholesterol != cholesterol) ? Colors.indigo : null;
    if (cholesterol != null) _cholesterol = cholesterol;
    notifyListeners();
  }

  double _salt;
  Color _saltColor;
  Color get saltColor => _saltColor;
  double get salt => _salt ?? 0;
  set salt(double salt) {
    _saltColor = (_oldProduct != null && _oldProduct.salt != salt) ? Colors.indigo : null;
    if (salt != null) _salt = salt;
    notifyListeners();
  }

  double _vitaminA;
  Color _vitaminAColor;
  Color get vitaminAColor => _vitaminAColor;
  double get vitaminA => _vitaminA ?? 0;
  set vitaminA(double vitaminA) {
    _vitaminAColor = (_oldProduct != null && _oldProduct.vitaminA != vitaminA) ? Colors.indigo : null;
    if (vitaminA != null) _vitaminA = vitaminA;
    notifyListeners();
  }

  double _vitaminC;
  Color _vitaminCColor;
  Color get vitaminCColor => _vitaminCColor;
  double get vitaminC => _vitaminC ?? 0;
  set vitaminC(double vitaminC) {
    _vitaminCColor = (_oldProduct != null && _oldProduct.vitaminC != vitaminC) ? Colors.indigo : null;
    if (vitaminC != null) _vitaminC = vitaminC;
    notifyListeners();
  }

  double _vitaminD;
  Color _vitaminDColor;
  Color get vitaminDColor => _vitaminDColor;
  double get vitaminD => _vitaminD ?? 0;
  set vitaminD(double vitaminD) {
    _vitaminDColor = (_oldProduct != null && _oldProduct.vitaminD != vitaminD) ? Colors.indigo : null;
    if (vitaminD != null) _vitaminD = vitaminD;
    notifyListeners();
  }

  double _vitaminE;
  Color _vitaminEColor;
  Color get vitaminEColor => _vitaminEColor;
  double get vitaminE => _vitaminE ?? 0;
  set vitaminE(double vitaminE) {
    _vitaminEColor = (_oldProduct != null && _oldProduct.vitaminE != vitaminE) ? Colors.indigo : null;
    if (vitaminE != null) _vitaminE = vitaminE;
    notifyListeners();
  }

  double _vitaminK;
  Color _vitaminKColor;
  Color get vitaminKColor => _vitaminKColor;
  double get vitaminK => _vitaminK ?? 0;
  set vitaminK(double vitaminK) {
    _vitaminKColor = (_oldProduct != null && _oldProduct.vitaminK != vitaminK) ? Colors.indigo : null;
    if (vitaminK != null) _vitaminK = vitaminK;
    notifyListeners();
  }

  double _vitaminB1;
  Color _vitaminB1Color;
  Color get vitaminB1Color => _vitaminB1Color;
  double get vitaminB1 => _vitaminB1 ?? 0;
  set vitaminB1(double vitaminB1) {
    _vitaminB1Color = (_oldProduct != null && _oldProduct.vitaminB1 != vitaminB1) ? Colors.indigo : null;
    if (vitaminB1 != null) _vitaminB1 = vitaminB1;
    notifyListeners();
  }

  double _vitaminB2;
  Color _vitaminB2Color;
  Color get vitaminB2Color => _vitaminB2Color;
  double get vitaminB2 => _vitaminB2 ?? 0;
  set vitaminB2(double vitaminB2) {
    _vitaminB2Color = (_oldProduct != null && _oldProduct.vitaminB2 != vitaminB2) ? Colors.indigo : null;
    if (vitaminB2 != null) _vitaminB2 = vitaminB2;
    notifyListeners();
  }

  double _vitaminB3;
  Color _vitaminB3Color;
  Color get vitaminB3Color => _vitaminB3Color;
  double get vitaminB3 => _vitaminB3 ?? 0;
  set vitaminB3(double vitaminB3) {
    _vitaminB3Color = (_oldProduct != null && _oldProduct.vitaminB3 != vitaminB3) ? Colors.indigo : null;
    if (vitaminB3 != null) _vitaminB3 = vitaminB3;
    notifyListeners();
  }

  double _vitaminB5;
  Color _vitaminB5Color;
  Color get vitaminB5Color => _vitaminB5Color;
  double get vitaminB5 => _vitaminB5 ?? 0;
  set vitaminB5(double vitaminB5) {
    _vitaminB5Color = (_oldProduct != null && _oldProduct.vitaminB5 != vitaminB5) ? Colors.indigo : null;
    if (vitaminB5 != null) _vitaminB5 = vitaminB5;
    notifyListeners();
  }

  double _vitaminB6;
  Color _vitaminB6Color;
  Color get vitaminB6Color => _vitaminB6Color;
  double get vitaminB6 => _vitaminB6 ?? 0;
  set vitaminB6(double vitaminB6) {
    _vitaminB6Color = (_oldProduct != null && _oldProduct.vitaminB6 != vitaminB6) ? Colors.indigo : null;
    if (vitaminB6 != null) _vitaminB6 = vitaminB6;
    notifyListeners();
  }

  double _vitaminB7;
  Color _vitaminB7Color;
  Color get vitaminB7Color => _vitaminB7Color;
  double get vitaminB7 => _vitaminB7 ?? 0;
  set vitaminB7(double vitaminB7) {
    _vitaminB7Color = (_oldProduct != null && _oldProduct.vitaminB7 != vitaminB7) ? Colors.indigo : null;
    if (vitaminB7 != null) _vitaminB7 = vitaminB7;
    notifyListeners();
  }

  double _vitaminB9;
  Color _vitaminB9Color;
  Color get vitaminB9Color => _vitaminB9Color;
  double get vitaminB9 => _vitaminB9 ?? 0;
  set vitaminB9(double vitaminB9) {
    _vitaminB9Color = (_oldProduct != null && _oldProduct.vitaminB9 != vitaminB9) ? Colors.indigo : null;
    if (vitaminB9 != null) _vitaminB9 = vitaminB9;
    notifyListeners();
  }

  double _vitaminB12;
  Color _vitaminB12Color;
  Color get vitaminB12eColor => _vitaminB12Color;
  double get vitaminB12 => _vitaminB12 ?? 0;
  set vitaminB12(double vitaminB12) {
    _vitaminB12Color = (_oldProduct != null && _oldProduct.vitaminB12 != vitaminB12) ? Colors.indigo : null;
    if (vitaminB12 != null) _vitaminB12 = vitaminB12;
    notifyListeners();
  }

  double _potassium;
  Color _potassiumColor;
  Color get potassiumColor => _potassiumColor;
  double get potassium => _potassium ?? 0;
  set potassium(double potassium) {
    _potassiumColor = (_oldProduct != null && _oldProduct.potassium != potassium) ? Colors.indigo : null;
    if (potassium != null) _potassium = potassium;
    notifyListeners();
  }

  double _sodium;
  Color _sodiumColor;
  Color get sodiumColor => _sodiumColor;
  double get sodium => _sodium ?? 0;
  set sodium(double sodium) {
    _sodiumColor = (_oldProduct != null && _oldProduct.sodium != sodium) ? Colors.indigo : null;
    if (sodium != null) _sodium = sodium;
    notifyListeners();
  }

  double _calcium;
  Color _calciumColor;
  Color get calciumColor => _calciumColor;
  double get calcium => _calcium ?? 0;
  set calcium(double calcium) {
    _calciumColor = (_oldProduct != null && _oldProduct.calcium != calcium) ? Colors.indigo : null;
    if (calcium != null) _calcium = calcium;
    notifyListeners();
  }

  double _magnesium;
  Color _magnesiumColor;
  Color get magnesiumColor => _magnesiumColor;
  double get magnesium => _magnesium ?? 0;
  set magnesium(double magnesium) {
    _magnesiumColor = (_oldProduct != null && _oldProduct.magnesium != magnesium) ? Colors.indigo : null;
    if (magnesium != null) _magnesium = magnesium;
    notifyListeners();
  }

  double _phosphorus;
  Color _phosphorusColor;
  Color get phosphorusColor => _phosphorusColor;
  double get phosphorus => _phosphorus ?? 0;
  set phosphorus(double phosphorus) {
    _phosphorusColor = (_oldProduct != null && _oldProduct.phosphorus != phosphorus) ? Colors.indigo : null;
    if (phosphorus != null) _phosphorus = phosphorus;
    notifyListeners();
  }

  double _iron;
  Color _ironColor;
  Color get ironColor => _productNameColor;
  double get iron => _iron ?? 0;
  set iron(double iron) {
    _ironColor = (_oldProduct != null && _oldProduct.iron != iron) ? Colors.indigo : null;
    if (iron != null) _iron = iron;
    notifyListeners();
  }

  double _copper;
  Color _copperColor;
  Color get copperColor => _copperColor;
  double get copper => _copper ?? 0;
  set copper(double copper) {
    _copperColor = (_oldProduct != null && _oldProduct.copper != copper) ? Colors.indigo : null;
    if (copper != null) _copper = copper;
    notifyListeners();
  }

  double _zinc;
  Color _zincColor;
  Color get zincColor => _zincColor;
  double get zinc => _zinc ?? 0;
  set zinc(double zinc) {
    _zincColor = (_oldProduct != null && _oldProduct.zinc != zinc) ? Colors.indigo : null;
    if (zinc != null) _zinc = zinc;
    notifyListeners();
  }

  double _selenium;
  Color _seleniumColor;
  Color get seleniumColor => _seleniumColor;
  double get selenium => _selenium ?? 0;
  set selenium(double selenium) {
    _seleniumColor = (_oldProduct != null && _oldProduct.selenium != selenium) ? Colors.indigo : null;
    if (selenium != null) _selenium = selenium;
    notifyListeners();
  }

  double _manganese;
  Color _manganeseColor;
  Color get manganeseColor => _manganeseColor;
  double get manganese => _manganese ?? 0;
  set manganese(double manganese) {
    _manganeseColor = (_oldProduct != null && _oldProduct.manganese != manganese) ? Colors.indigo : null;
    if (manganese != null) _manganese = manganese;
    notifyListeners();
  }

  double _iodine;
  Color _iodineColor;
  Color get iodineColor => _iodineColor;
  double get iodine => _iodine ?? 0;
  set iodine(double iodine) {
    _iodineColor = (_oldProduct != null && _oldProduct.iodine != iodine) ? Colors.indigo : null;
    if (iodine != null) _iodine = iodine;
    notifyListeners();
  }

  double _chromium;
  Color _chromiumColor;
  Color get chromiumColor => _chromiumColor;
  double get chromium => _chromium ?? 0;
  set chromium(double chromium) {
    _chromiumColor = (_oldProduct != null && _oldProduct.chromium != chromium) ? Colors.indigo : null;
    if (chromium != null) _chromium = chromium;
    notifyListeners();
  }

  createProduct({@required BuildContext context, @required String barcode, String id, String description}) {
    final db = context.read(providerDatabase);

    context.read(providerPreference.last).then((preference) async {
      Product product = Product(
          barcode: barcode,
          id: id,
          name: productName,
          categoryPrimary: categoryPrimary,
          categorySecondary: categorySecondary,
          localeBase: preference.localeBase,
          keyWords: keyWords,
          portions: portions,
          verification: false,
          calories: calories,
          proteins: proteins,
          carbs: carbs,
          fats: fats,
          photosUrl: _photosUrl,
          sugar: sugar,
          animalProteins: animalProteins,
          plantProteins: plantProteins,
          saturated: saturated,
          unsaturated: unsaturated,
          omega3: omega3,
          omega6: omega6,
          fiber: fiber,
          caffeine: caffeine,
          cholesterol: cholesterol,
          salt: salt,
          vitaminA: vitaminA,
          vitaminC: vitaminC,
          vitaminD: vitaminD,
          vitaminE: vitaminE,
          vitaminK: vitaminK,
          vitaminB1: vitaminB1,
          vitaminB2: vitaminB2,
          vitaminB3: vitaminB3,
          vitaminB5: vitaminB5,
          vitaminB6: vitaminB6,
          vitaminB7: vitaminB7,
          vitaminB9: vitaminB9,
          vitaminB12: vitaminB12,
          potassium: potassium,
          sodium: sodium,
          calcium: calcium,
          magnesium: magnesium,
          phosphorus: phosphorus,
          iron: iron,
          copper: copper,
          zinc: zinc,
          selenium: selenium,
          manganese: manganese,
          iodine: iodine,
          chromium: chromium);

      if (id != null) {
        Issue issuesReport = Issue(
          elementType: ETypeElement.product,
          id: id,
          dateCreate: DateTime.now(),
          description: description,
          element: product,
          issueType: ETypeIssue.correct,
        );

        Navigator.pop(context, issuesReport);
      } else {
        db.createProduct(product);
      }
    });
  }

  initState(Product product, String barcode) {
    this.barcode = barcode;
    this.product = product;

    if (product != null) {
      _oldProduct = product;
      _productName = product.name;
      _categoryPrimary = product.categoryPrimary;
      _categorySecondary = product.categorySecondary;
      _keyWords = product.keyWords;
      _calories = product.calories;
      _proteins = product.proteins;
      _carbs = product.carbs;
      _fats = product.fats;
      _portions = product.portions;
      _unit = product.portions.first.unit;

      _sugar = product.sugar;
      _animalProteins = product.animalProteins;
      _plantProteins = product.plantProteins;
      _saturated = product.saturated;
      _unsaturated = product.unsaturated;
      _omega3 = product.omega3;
      _omega6 = product.omega6;
      _fiber = product.fiber;
      _caffeine = product.caffeine;
      _cholesterol = product.cholesterol;
      _salt = product.salt;
      _vitaminA = product.vitaminA;
      _vitaminC = product.vitaminC;
      _vitaminD = product.vitaminD;
      _vitaminE = product.vitaminE;
      _vitaminK = product.vitaminK;
      _vitaminB1 = product.vitaminB1;
      _vitaminB2 = product.vitaminB2;
      _vitaminB3 = product.vitaminB3;
      _vitaminB5 = product.vitaminB5;
      _vitaminB6 = product.vitaminB6;
      _vitaminB7 = product.vitaminB7;
      _vitaminB9 = product.vitaminB9;
      _vitaminB12 = product.vitaminB12;
      _potassium = product.potassium;
      _sodium = product.sodium;
      _calcium = product.calcium;
      _magnesium = product.magnesium;
      _phosphorus = product.phosphorus;
      _iron = product.iron;
      _copper = product.copper;
      _zinc = product.zinc;
      _selenium = product.selenium;
      _manganese = product.manganese;
      _iodine = product.iodine;
      _chromium = product.chromium;
      _photosUrl = product.photosUrl;
    }
  }

  save(BuildContext context) async {
    if (product != null) {
      String _value;
      return showInputPicker(
        context: context,
        hintText: Languages.describe_error(),
        multiLine: true,
        isCancel: true,
        buttonTextYes: Languages.send(),
        onPressed: () {
          createProduct(context: context, barcode: barcode, id: product.id, description: _value);
          Navigator.pop(context);
        },
        onChanged: (String v) {
          _value = v;
        },
      );
    } else {
      createProduct(context: context, barcode: barcode);
    }

    Navigator.pop(context);
  }

  submitKeyWords(BuildContext context) async {
    List result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return AddToListScreen(tileType: EnumTileType.keyWord, list: keyWords, title: Languages.key_words());
      }),
    );

    if (result != null) keyWords = result;
  }

  String portionsTXT() {
    String portionsTXT = '';
    portions.forEach((element) => portionsTXT += '${Enums.toText(element.type).tr()}: ${element.size}${Enums.toText(element.unit)}, ');
    return portionsTXT;
  }

  submitPortions(BuildContext context) async {
    dynamic result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return AddToListScreen(tileType: EnumTileType.portion, list: portions, title: Languages.portion(), unit: unit);
      }),
    );

    if (result != null) {
      List<Portion> list = [];
      result.forEach((element) => list.add(element));
      portions = list;
    }
  }
}
