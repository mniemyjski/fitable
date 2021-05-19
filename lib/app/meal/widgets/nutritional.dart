import 'package:fitable/app/meal/models/meal_model.dart';
import 'package:fitable/app/meal/models/product_model.dart';
import 'package:fitable/app/meal/models/recipe_model.dart';
import 'package:fitable/utilities/enums.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:logger/logger.dart';

nutritional({dynamic element}) {
  TypeUnit _unit;
  int _calories = 0;
  double _proteins = 0;
  double _carbs = 0;
  double _fats = 0;
  double _sugar = 0;
  double _animalProteins = 0;
  double _plantProteins = 0;
  double _saturated = 0;
  double _unsaturated = 0;
  double _omega3 = 0;
  double _omega6 = 0;
  double _fiber = 0;
  double _caffeine = 0;
  double _cholesterol = 0;
  double _salt = 0;
  double _vitaminA = 0;
  double _vitaminC = 0;
  double _vitaminD = 0;
  double _vitaminE = 0;
  double _vitaminK = 0;
  double _vitaminB1 = 0;
  double _vitaminB2 = 0;
  double _vitaminB3 = 0;
  double _vitaminB5 = 0;
  double _vitaminB6 = 0;
  double _vitaminB7 = 0;
  double _vitaminB9 = 0;
  double _vitaminB12 = 0;
  double _potassium = 0;
  double _sodium = 0;
  double _calcium = 0;
  double _magnesium = 0;
  double _phosphorus = 0;
  double _iron = 0;
  double _copper = 0;
  double _zinc = 0;
  double _selenium = 0;
  double _manganese = 0;
  double _iodine = 0;
  double _chromium = 0;
  if (element.runtimeType == Product) {
    _unit = element.portions.first.unit;
    _calories = element.calories;
    _proteins = element.proteins;
    _carbs = element.carbs;
    _fats = element.fats;
    _sugar = element.sugar;
    _animalProteins = element.animalProteins;
    _plantProteins = element.plantProteins;
    _saturated = element.saturated;
    _unsaturated = element.unsaturated;
    _omega3 = element.omega3;
    _omega6 = element.omega6;
    _fiber = element.fiber;
    _caffeine = element.caffeine;
    _cholesterol = element.cholesterol;
    _salt = element.salt;
    _vitaminA = element.vitaminA;
    _vitaminC = element.vitaminC;
    _vitaminD = element.vitaminD;
    _vitaminE = element.vitaminE;
    _vitaminK = element.vitaminK;
    _vitaminB1 = element.vitaminB1;
    _vitaminB2 = element.vitaminB2;
    _vitaminB3 = element.vitaminB3;
    _vitaminB5 = element.vitaminB5;
    _vitaminB6 = element.vitaminB6;
    _vitaminB7 = element.vitaminB7;
    _vitaminB9 = element.vitaminB9;
    _vitaminB12 = element.vitaminB12;
    _potassium = element.potassium;
    _sodium = element.sodium;
    _calcium = element.calcium;
    _magnesium = element.magnesium;
    _phosphorus = element.phosphorus;
    _iron = element.iron;
    _copper = element.copper;
    _zinc = element.zinc;
    _selenium = element.selenium;
    _manganese = element.manganese;
    _iodine = element.iodine;
    _chromium = element.chromium;
  }
  if (element.runtimeType == Recipe) {
    _unit = element.portions.first.unit;

    element.ingredients.forEach((element) {
      _calories = element.product.calories;
      _proteins = element.product.proteins;
      _carbs = element.product.carbs;
      _fats = element.product.fats;
      _sugar = element.product.sugar;
      _animalProteins = element.product.animalProteins;
      _plantProteins = element.product.plantProteins;
      _saturated = element.product.saturated;
      _unsaturated = element.product.unsaturated;
      _omega3 = element.product.omega3;
      _omega6 = element.product.omega6;
      _fiber = element.product.fiber;
      _caffeine = element.product.caffeine;
      _cholesterol = element.product.cholesterol;
      _salt = element.product.salt;
      _vitaminA = element.product.vitaminA;
      _vitaminC = element.product.vitaminC;
      _vitaminD = element.product.vitaminD;
      _vitaminE = element.product.vitaminE;
      _vitaminK = element.product.vitaminK;
      _vitaminB1 = element.product.vitaminB1;
      _vitaminB2 = element.product.vitaminB2;
      _vitaminB3 = element.product.vitaminB3;
      _vitaminB5 = element.product.vitaminB5;
      _vitaminB6 = element.product.vitaminB6;
      _vitaminB7 = element.product.vitaminB7;
      _vitaminB9 = element.product.vitaminB9;
      _vitaminB12 = element.product.vitaminB12;
      _potassium = element.product.potassium;
      _sodium = element.product.sodium;
      _calcium = element.product.calcium;
      _magnesium = element.product.magnesium;
      _phosphorus = element.product.phosphorus;
      _iron = element.product.iron;
      _copper = element.product.copper;
      _zinc = element.product.zinc;
      _selenium = element.product.selenium;
      _manganese = element.product.manganese;
      _iodine = element.product.iodine;
      _chromium = element.product.chromium;
    });
  }

  return ExpansionTile(
    title: Container(
      margin: EdgeInsets.only(bottom: 5),
      width: double.infinity,
      child: Text(
        'nutritional_values_out_of_100'.tr() + '${Enums.toText(_unit)}:',
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
