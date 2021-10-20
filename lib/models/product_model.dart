import 'package:equatable/equatable.dart';
import 'package:fitable/models/portion_model.dart';
import 'package:fitable/utilities/enums.dart';

class Product extends Equatable {
  const Product(
      {this.id,
      this.barcode,
      this.withBarcode,
      this.name,
      this.categoryPrimary,
      this.categorySecondary,
      this.localeBase,
      this.keyWords,
      this.portions,
      this.verification,
      this.calories,
      this.proteins,
      this.carbs,
      this.fats,
      this.dateCreation,
      this.dateLastUpdate,
      this.photosUrl,
      this.sugar,
      this.animalProteins,
      this.plantProteins,
      this.saturated,
      this.unsaturated,
      this.omega3,
      this.omega6,
      this.fiber,
      this.caffeine,
      this.cholesterol,
      this.salt,
      this.vitaminA,
      this.vitaminC,
      this.vitaminD,
      this.vitaminE,
      this.vitaminK,
      this.vitaminB1,
      this.vitaminB2,
      this.vitaminB3,
      this.vitaminB5,
      this.vitaminB6,
      this.vitaminB7,
      this.vitaminB9,
      this.vitaminB12,
      this.potassium,
      this.sodium,
      this.calcium,
      this.magnesium,
      this.phosphorus,
      this.iron,
      this.copper,
      this.zinc,
      this.selenium,
      this.manganese,
      this.iodine,
      this.chromium});

  final String id;
  final String barcode;
  final bool withBarcode;
  final String name;
  final String categoryPrimary;
  final String categorySecondary;
  final String localeBase;
  final List<String> keyWords;
  final List<Portion> portions;
  final bool verification;
  final DateTime dateCreation;
  final DateTime dateLastUpdate;
  final Map photosUrl;
  final int calories;
  final double proteins, carbs, fats;
  final double sugar, animalProteins, plantProteins, saturated, unsaturated, omega3, omega6;
  final double fiber, caffeine, cholesterol, salt;
  final double vitaminA, vitaminC, vitaminD, vitaminE, vitaminK;
  final double vitaminB1, vitaminB2, vitaminB3, vitaminB5, vitaminB6, vitaminB7, vitaminB9, vitaminB12;
  final double potassium, sodium, calcium, magnesium, phosphorus;
  final double iron, copper, zinc, selenium, manganese, iodine, chromium;

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

  static const empty = Product(
    barcode: '',
    withBarcode: true,
    name: '',
    localeBase: '',
    keyWords: [],
    portions: [Portion(type: 'g', size: 1, unit: ETypeUnit.g)],
    verification: false,
    calories: 0,
    proteins: 0,
    carbs: 0,
    fats: 0,
    photosUrl: {},
    sugar: 0,
    animalProteins: 0,
    plantProteins: 0,
    saturated: 0,
    unsaturated: 0,
    omega3: 0,
    omega6: 0,
    fiber: 0,
    caffeine: 0,
    cholesterol: 0,
    salt: 0,
    vitaminA: 0,
    vitaminC: 0,
    vitaminD: 0,
    vitaminE: 0,
    vitaminK: 0,
    vitaminB1: 0,
    vitaminB2: 0,
    vitaminB3: 0,
    vitaminB5: 0,
    vitaminB6: 0,
    vitaminB7: 0,
    vitaminB9: 0,
    vitaminB12: 0,
    potassium: 0,
    sodium: 0,
    calcium: 0,
    magnesium: 0,
    phosphorus: 0,
    iron: 0,
    copper: 0,
    zinc: 0,
    selenium: 0,
    manganese: 0,
    iodine: 0,
    chromium: 0,
  );

  Map<String, dynamic> toMap({String id}) {
    return {
      'id': id ?? this.id,
      'barcode': barcode,
      'withBarcode': barcode != null ? true : false,
      'name': name,
      'categoryPrimary': categoryPrimary,
      'categorySecondary': categorySecondary,
      'localeBase': localeBase,
      'keyWords': List.from(keyWords),
      'portions': Portion.convertPortionsToMapList(portions),
      'verification': verification,
      'dateCreation': dateCreation == null ? DateTime.now() : dateCreation,
      'dateLastUpdate': dateLastUpdate == null ? DateTime.now() : dateLastUpdate,
      'calories': calories,
      'proteins': proteins,
      'carbs': carbs,
      'fats': fats,
      'photosUrl': photosUrl,
      'sugar': sugar,
      'animalProteins': animalProteins,
      'plantProteins': plantProteins,
      'saturated': saturated,
      'unsaturated': unsaturated,
      'omega3': omega3,
      'omega6': omega6,
      'fiber': fiber,
      'caffeine': caffeine,
      'cholesterol': cholesterol,
      'salt': salt,
      'vitaminA': vitaminA,
      'vitaminC': vitaminC,
      'vitaminD': vitaminD,
      'vitaminE': vitaminE,
      'vitaminK': vitaminK,
      'vitaminB1': vitaminB1,
      'vitaminB2': vitaminB2,
      'vitaminB3': vitaminB3,
      'vitaminB5': vitaminB5,
      'vitaminB6': vitaminB6,
      'vitaminB7': vitaminB7,
      'vitaminB9': vitaminB9,
      'vitaminB12': vitaminB12,
      'potassium': potassium,
      'sodium': sodium,
      'calcium': calcium,
      'magnesium': magnesium,
      'phosphorus': phosphorus,
      'iron': iron,
      'copper': copper,
      'zinc': zinc,
      'selenium': selenium,
      'manganese': manganese,
      'iodine': iodine,
      'chromium': chromium,
    };
  }

  factory Product.fromMap(Map<String, dynamic> data) {
    if (data == null) {
      return null;
    }

    return Product(
      id: data['id'],
      barcode: data['barcode'],
      name: data['name'],
      categoryPrimary: data['categoryPrimary'],
      categorySecondary: data['categorySecondary'],
      localeBase: data['localeBase'],
      keyWords: List.from(data['keyWords']),
      portions: Portion.convertPortionsToModelList(data['portions']),
      verification: data['verification'],
      dateCreation: data['dateCreation'].toDate(),
      dateLastUpdate: data['dateLastUpdate'].toDate(),
      calories: data['calories'],
      proteins: data['proteins'],
      carbs: data['carbs'],
      fats: data['fats'],
      sugar: data['sugar'],
      animalProteins: data['animalProteins'],
      plantProteins: data['plantProteins'],
      saturated: data['saturated'],
      unsaturated: data['unsaturated'],
      omega3: data['omega3'],
      omega6: data['omega6'],
      fiber: data['fiber'],
      caffeine: data['caffeine'],
      cholesterol: data['cholesterol'],
      salt: data['salt'],
      vitaminA: data['vitaminA'],
      vitaminC: data['vitaminC'],
      vitaminD: data['vitaminD'],
      vitaminE: data['vitaminE'],
      vitaminK: data['vitaminK'],
      vitaminB1: data['vitaminB1'],
      vitaminB2: data['vitaminB2'],
      vitaminB3: data['vitaminB3'],
      vitaminB5: data['vitaminB5'],
      vitaminB6: data['vitaminB6'],
      vitaminB7: data['vitaminB7'],
      vitaminB9: data['vitaminB9'],
      vitaminB12: data['vitaminB12'],
      potassium: data['potassium'],
      sodium: data['sodium'],
      calcium: data['calcium'],
      magnesium: data['magnesium'],
      phosphorus: data['phosphorus'],
      iron: data['iron'],
      copper: data['copper'],
      zinc: data['zinc'],
      selenium: data['selenium'],
      manganese: data['manganese'],
      iodine: data['iodine'],
      chromium: data['chromium'],
      photosUrl: {},
    );
  }

  int getCalories(double portionSize, double selectedSize) {
    return (calories * portionSize * selectedSize / 100).round();
  }

  double getProteins(double portionSize, double selectedSize) {
    return (proteins * portionSize * selectedSize / 100);
  }

  double getCarbs(double portionSize, double selectedSize) {
    return (carbs * portionSize * selectedSize / 100);
  }

  double getFats(double portionSize, double selectedSize) {
    return (fats * portionSize * selectedSize / 100);
  }

  List getPortionsStrings() {
    List<String> list = [];
    portions.forEach((element) {
      list.add('${element.name}');
    });
    return list;
  }

  Product copyWith({
    String id,
    String barcode,
    bool withBarcode,
    String name,
    String categoryPrimary,
    String categorySecondary,
    String localeBase,
    List<String> keyWords,
    List<Portion> portions,
    bool verification,
    DateTime dateCreation,
    DateTime dateLastUpdate,
    Map photosUrl,
    int calories,
    double proteins,
    double carbs,
    double fats,
    double sugar,
    double animalProteins,
    double plantProteins,
    double saturated,
    double unsaturated,
    double omega3,
    double omega6,
    double fiber,
    double caffeine,
    double cholesterol,
    double salt,
    double vitaminA,
    double vitaminC,
    double vitaminD,
    double vitaminE,
    double vitaminK,
    double vitaminB1,
    double vitaminB2,
    double vitaminB3,
    double vitaminB5,
    double vitaminB6,
    double vitaminB7,
    double vitaminB9,
    double vitaminB12,
    double potassium,
    double sodium,
    double calcium,
    double magnesium,
    double phosphorus,
    double iron,
    double copper,
    double zinc,
    double selenium,
    double manganese,
    double iodine,
    double chromium,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (barcode == null || identical(barcode, this.barcode)) &&
        (withBarcode == null || identical(withBarcode, this.withBarcode)) &&
        (name == null || identical(name, this.name)) &&
        (categoryPrimary == null || identical(categoryPrimary, this.categoryPrimary)) &&
        (categorySecondary == null || identical(categorySecondary, this.categorySecondary)) &&
        (localeBase == null || identical(localeBase, this.localeBase)) &&
        (keyWords == null || identical(keyWords, this.keyWords)) &&
        (portions == null || identical(portions, this.portions)) &&
        (verification == null || identical(verification, this.verification)) &&
        (dateCreation == null || identical(dateCreation, this.dateCreation)) &&
        (dateLastUpdate == null || identical(dateLastUpdate, this.dateLastUpdate)) &&
        (photosUrl == null || identical(photosUrl, this.photosUrl)) &&
        (calories == null || identical(calories, this.calories)) &&
        (proteins == null || identical(proteins, this.proteins)) &&
        (carbs == null || identical(carbs, this.carbs)) &&
        (fats == null || identical(fats, this.fats)) &&
        (sugar == null || identical(sugar, this.sugar)) &&
        (animalProteins == null || identical(animalProteins, this.animalProteins)) &&
        (plantProteins == null || identical(plantProteins, this.plantProteins)) &&
        (saturated == null || identical(saturated, this.saturated)) &&
        (unsaturated == null || identical(unsaturated, this.unsaturated)) &&
        (omega3 == null || identical(omega3, this.omega3)) &&
        (omega6 == null || identical(omega6, this.omega6)) &&
        (fiber == null || identical(fiber, this.fiber)) &&
        (caffeine == null || identical(caffeine, this.caffeine)) &&
        (cholesterol == null || identical(cholesterol, this.cholesterol)) &&
        (salt == null || identical(salt, this.salt)) &&
        (vitaminA == null || identical(vitaminA, this.vitaminA)) &&
        (vitaminC == null || identical(vitaminC, this.vitaminC)) &&
        (vitaminD == null || identical(vitaminD, this.vitaminD)) &&
        (vitaminE == null || identical(vitaminE, this.vitaminE)) &&
        (vitaminK == null || identical(vitaminK, this.vitaminK)) &&
        (vitaminB1 == null || identical(vitaminB1, this.vitaminB1)) &&
        (vitaminB2 == null || identical(vitaminB2, this.vitaminB2)) &&
        (vitaminB3 == null || identical(vitaminB3, this.vitaminB3)) &&
        (vitaminB5 == null || identical(vitaminB5, this.vitaminB5)) &&
        (vitaminB6 == null || identical(vitaminB6, this.vitaminB6)) &&
        (vitaminB7 == null || identical(vitaminB7, this.vitaminB7)) &&
        (vitaminB9 == null || identical(vitaminB9, this.vitaminB9)) &&
        (vitaminB12 == null || identical(vitaminB12, this.vitaminB12)) &&
        (potassium == null || identical(potassium, this.potassium)) &&
        (sodium == null || identical(sodium, this.sodium)) &&
        (calcium == null || identical(calcium, this.calcium)) &&
        (magnesium == null || identical(magnesium, this.magnesium)) &&
        (phosphorus == null || identical(phosphorus, this.phosphorus)) &&
        (iron == null || identical(iron, this.iron)) &&
        (copper == null || identical(copper, this.copper)) &&
        (zinc == null || identical(zinc, this.zinc)) &&
        (selenium == null || identical(selenium, this.selenium)) &&
        (manganese == null || identical(manganese, this.manganese)) &&
        (iodine == null || identical(iodine, this.iodine)) &&
        (chromium == null || identical(chromium, this.chromium))) {
      return this;
    }

    print(categorySecondary == null && this.categoryPrimary != categoryPrimary);
    return new Product(
      id: id ?? this.id,
      barcode: barcode ?? this.barcode,
      withBarcode: withBarcode ?? this.withBarcode,
      name: name ?? this.name,
      categoryPrimary: categoryPrimary ?? this.categoryPrimary,
      categorySecondary: categorySecondary ?? (this.categoryPrimary != categoryPrimary && categoryPrimary != null ? null : this.categorySecondary),
      localeBase: localeBase ?? this.localeBase,
      keyWords: keyWords ?? this.keyWords,
      portions: portions ?? this.portions,
      verification: verification ?? this.verification,
      dateCreation: dateCreation ?? this.dateCreation,
      dateLastUpdate: dateLastUpdate ?? this.dateLastUpdate,
      photosUrl: photosUrl ?? this.photosUrl,
      calories: calories ?? this.calories,
      proteins: proteins ?? this.proteins,
      carbs: carbs ?? this.carbs,
      fats: fats ?? this.fats,
      sugar: sugar ?? this.sugar,
      animalProteins: animalProteins ?? this.animalProteins,
      plantProteins: plantProteins ?? this.plantProteins,
      saturated: saturated ?? this.saturated,
      unsaturated: unsaturated ?? this.unsaturated,
      omega3: omega3 ?? this.omega3,
      omega6: omega6 ?? this.omega6,
      fiber: fiber ?? this.fiber,
      caffeine: caffeine ?? this.caffeine,
      cholesterol: cholesterol ?? this.cholesterol,
      salt: salt ?? this.salt,
      vitaminA: vitaminA ?? this.vitaminA,
      vitaminC: vitaminC ?? this.vitaminC,
      vitaminD: vitaminD ?? this.vitaminD,
      vitaminE: vitaminE ?? this.vitaminE,
      vitaminK: vitaminK ?? this.vitaminK,
      vitaminB1: vitaminB1 ?? this.vitaminB1,
      vitaminB2: vitaminB2 ?? this.vitaminB2,
      vitaminB3: vitaminB3 ?? this.vitaminB3,
      vitaminB5: vitaminB5 ?? this.vitaminB5,
      vitaminB6: vitaminB6 ?? this.vitaminB6,
      vitaminB7: vitaminB7 ?? this.vitaminB7,
      vitaminB9: vitaminB9 ?? this.vitaminB9,
      vitaminB12: vitaminB12 ?? this.vitaminB12,
      potassium: potassium ?? this.potassium,
      sodium: sodium ?? this.sodium,
      calcium: calcium ?? this.calcium,
      magnesium: magnesium ?? this.magnesium,
      phosphorus: phosphorus ?? this.phosphorus,
      iron: iron ?? this.iron,
      copper: copper ?? this.copper,
      zinc: zinc ?? this.zinc,
      selenium: selenium ?? this.selenium,
      manganese: manganese ?? this.manganese,
      iodine: iodine ?? this.iodine,
      chromium: chromium ?? this.chromium,
    );
  }
}
