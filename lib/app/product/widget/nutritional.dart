import 'package:fitable/app/product/models/meal_model.dart';
import 'package:fitable/app/product/models/product_model.dart';
import 'package:fitable/app/product/models/recipe_model.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

nutritional({@required Product product, @required Recipe recipe, @required Meal meal}) {
  String _unit;
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

  if (product != null) {
    _unit = product.unit;
    _calories = product.calories;
    _proteins = product.proteins;
    _carbs = product.carbs;
    _fats = product.fats;
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
  }
  if (recipe != null) {
    _unit = product.unit;
    _calories = product.calories;
    _proteins = product.proteins;
    _carbs = product.carbs;
    _fats = product.fats;
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
  }
  if (meal != null) {
    _unit = meal.product.unit;
    _calories = meal.product.calories;
    _proteins = meal.product.proteins;
    _carbs = meal.product.carbs;
    _fats = meal.product.fats;
    _sugar = meal.product.sugar;
    _animalProteins = meal.product.animalProteins;
    _plantProteins = meal.product.plantProteins;
    _saturated = meal.product.saturated;
    _unsaturated = meal.product.unsaturated;
    _omega3 = meal.product.omega3;
    _omega6 = meal.product.omega6;
    _fiber = meal.product.fiber;
    _caffeine = meal.product.caffeine;
    _cholesterol = meal.product.cholesterol;
    _salt = meal.product.salt;
    _vitaminA = meal.product.vitaminA;
    _vitaminC = meal.product.vitaminC;
    _vitaminD = meal.product.vitaminD;
    _vitaminE = meal.product.vitaminE;
    _vitaminK = meal.product.vitaminK;
    _vitaminB1 = meal.product.vitaminB1;
    _vitaminB2 = meal.product.vitaminB2;
    _vitaminB3 = meal.product.vitaminB3;
    _vitaminB5 = meal.product.vitaminB5;
    _vitaminB6 = meal.product.vitaminB6;
    _vitaminB7 = meal.product.vitaminB7;
    _vitaminB9 = meal.product.vitaminB9;
    _vitaminB12 = meal.product.vitaminB12;
    _potassium = meal.product.potassium;
    _sodium = meal.product.sodium;
    _calcium = meal.product.calcium;
    _magnesium = meal.product.magnesium;
    _phosphorus = meal.product.phosphorus;
    _iron = meal.product.iron;
    _copper = meal.product.copper;
    _zinc = meal.product.zinc;
    _selenium = meal.product.selenium;
    _manganese = meal.product.manganese;
    _iodine = meal.product.iodine;
    _chromium = meal.product.chromium;
  }

  return ExpansionTile(
    title: Container(
      margin: EdgeInsets.only(bottom: 5),
      width: double.infinity,
      child: Text(
        'nutritional_values_out_of_100'.tr() + '$_unit:',
        style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
      ),
    ),
    children: <Widget>[
      Container(
        margin: EdgeInsets.only(left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[Text('calories'.tr()), Text(_calories.toString())]),
            Divider(),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text('proteins'.tr()), Text(_proteins.toStringAsFixed(1) + ' g')]),
            Divider(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(width: 20),
                  Text('animal_proteins'.tr()),
                ],
              ),
              Text(_animalProteins.toStringAsFixed(1) + ' g')
            ]),
            Divider(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(width: 20),
                  Text('plant_proteins'.tr()),
                ],
              ),
              Text(_plantProteins.toStringAsFixed(1) + ' g')
            ]),
            Divider(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[Text('carbs'.tr()), Text(_carbs.toStringAsFixed(1) + ' g')]),
            Divider(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(width: 20),
                  Text('sugar'.tr()),
                ],
              ),
              Text(_sugar.toStringAsFixed(1) + ' g')
            ]),
            Divider(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[Text('fats'.tr()), Text(_fats.toStringAsFixed(1) + ' g')]),
            Divider(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(width: 20),
                  Text('saturated'.tr()),
                ],
              ),
              Text(_saturated.toStringAsFixed(1) + ' g')
            ]),
            Divider(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(width: 20),
                  Text('unsaturated'.tr()),
                ],
              ),
              Text(_unsaturated.toStringAsFixed(1) + ' g')
            ]),
            Divider(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(width: 20),
                  Text('omega3'.tr()),
                ],
              ),
              Text(_omega3.toStringAsFixed(1) + ' g')
            ]),
            Divider(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(width: 20),
                  Text('omega6'.tr()),
                ],
              ),
              Text(_omega6.toStringAsFixed(1) + ' g')
            ]),
            Divider(),
            Container(margin: EdgeInsets.only(top: 10, bottom: 5), child: Text('other'.tr() + ':', style: TextStyle(fontWeight: FontWeight.bold))),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[Text('fiber'.tr()), Text(_fiber.toStringAsFixed(1) + ' g')]),
            Divider(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[Text('salt'.tr()), Text(_salt.toStringAsFixed(1) + ' g')]),
            Divider(),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text('caffeine'.tr()), Text(_caffeine.toStringAsFixed(1) + ' g')]),
            Divider(),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text('cholesterol'.tr()), Text(_cholesterol.toStringAsFixed(1) + ' g')]),
            Divider(),
            Container(margin: EdgeInsets.only(top: 10, bottom: 5), child: Text('vitamins'.tr() + ':', style: TextStyle(fontWeight: FontWeight.bold))),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text('vitamin_a'.tr()), Text(_vitaminA.toStringAsFixed(1) + ' g')]),
            Divider(),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text('vitamin_c'.tr()), Text(_vitaminC.toStringAsFixed(1) + ' g')]),
            Divider(),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text('vitamin_d'.tr()), Text(_vitaminD.toStringAsFixed(1) + ' g')]),
            Divider(),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text('vitamin_e'.tr()), Text(_vitaminE.toStringAsFixed(1) + ' g')]),
            Divider(),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text('vitamin_k'.tr()), Text(_vitaminK.toStringAsFixed(1) + ' g')]),
            Divider(),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text('vitamin_b1'.tr()), Text(_vitaminB1.toStringAsFixed(1) + ' g')]),
            Divider(),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text('vitamin_b2'.tr()), Text(_vitaminB2.toStringAsFixed(1) + ' g')]),
            Divider(),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text('vitamin_b3'.tr()), Text(_vitaminB3.toStringAsFixed(1) + ' g')]),
            Divider(),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text('vitamin_b5'.tr()), Text(_vitaminB5.toStringAsFixed(1) + ' g')]),
            Divider(),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text('vitamin_b6'.tr()), Text(_vitaminB6.toStringAsFixed(1) + ' g')]),
            Divider(),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text('vitamin_b7'.tr()), Text(_vitaminB7.toStringAsFixed(1) + ' g')]),
            Divider(),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text('vitamin_b9'.tr()), Text(_vitaminB9.toStringAsFixed(1) + ' g')]),
            Divider(),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text('vitamin_b12'.tr()), Text(_vitaminB12.toStringAsFixed(1) + ' g')]),
            Divider(),
            Container(margin: EdgeInsets.only(top: 10, bottom: 5), child: Text('minerals'.tr() + ':', style: TextStyle(fontWeight: FontWeight.bold))),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text('potassium'.tr()), Text(_potassium.toStringAsFixed(1) + ' g')]),
            Divider(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[Text('sodium'.tr()), Text(_sodium.toStringAsFixed(1) + ' g')]),
            Divider(),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text('calcium'.tr()), Text(_calcium.toStringAsFixed(1) + ' g')]),
            Divider(),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text('magnesium'.tr()), Text(_magnesium.toStringAsFixed(1) + ' g')]),
            Divider(),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text('phosphorus'.tr()), Text(_phosphorus.toStringAsFixed(1) + ' g')]),
            Divider(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[Text('iron'.tr()), Text(_iron.toStringAsFixed(1) + ' g')]),
            Divider(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[Text('copper'.tr()), Text(_copper.toStringAsFixed(1) + ' g')]),
            Divider(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[Text('zinc'.tr()), Text(_zinc.toStringAsFixed(1) + ' g')]),
            Divider(),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text('selenium'.tr()), Text(_selenium.toStringAsFixed(1) + ' g')]),
            Divider(),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text('manganese'.tr()), Text(_manganese.toStringAsFixed(1) + ' g')]),
            Divider(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[Text('iodine'.tr()), Text(_iodine.toStringAsFixed(1) + ' g')]),
            Divider(),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text('chromium'.tr()), Text(_chromium.toStringAsFixed(1) + ' g')]),
            SizedBox(height: 5)
          ],
        ),
      ),
    ],
  );
}
