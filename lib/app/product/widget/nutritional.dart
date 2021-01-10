import 'package:fitable/app/product/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

nutritional({Product product}) {
  String unit = product.unit;

  int calories = product.calories;
  double proteins = product.proteins;
  double carbs = product.carbs;
  double fats = product.fats;
  double sugar = product.sugar;
  double animalProteins = product.animalProteins;
  double plantProteins = product.plantProteins;
  double saturated = product.saturated;
  double unsaturated = product.unsaturated;
  double omega3 = product.omega3;
  double omega6 = product.omega6;
  double fiber = product.fiber;
  double caffeine = product.caffeine;
  double cholesterol = product.cholesterol;
  double salt = product.salt;
  double vitaminA = product.vitaminA;
  double vitaminC = product.vitaminC;
  double vitaminD = product.vitaminD;
  double vitaminE = product.vitaminE;
  double vitaminK = product.vitaminK;
  double vitaminB1 = product.vitaminB1;
  double vitaminB2 = product.vitaminB2;
  double vitaminB3 = product.vitaminB3;
  double vitaminB5 = product.vitaminB5;
  double vitaminB6 = product.vitaminB6;
  double vitaminB7 = product.vitaminB7;
  double vitaminB9 = product.vitaminB9;
  double vitaminB12 = product.vitaminB12;
  double potassium = product.potassium;
  double sodium = product.sodium;
  double calcium = product.calcium;
  double magnesium = product.magnesium;
  double phosphorus = product.phosphorus;
  double iron = product.iron;
  double copper = product.copper;
  double zinc = product.zinc;
  double selenium = product.selenium;
  double manganese = product.manganese;
  double iodine = product.iodine;
  double chromium = product.chromium;

  return ExpansionTile(
    title: Container(
      margin: EdgeInsets.only(bottom: 5),
      width: double.infinity,
      child: Text(
        'nutritional_values_out_of_100'.tr() + '$unit:',
        style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
      ),
    ),
    children: <Widget>[
      Container(
        margin: EdgeInsets.only(left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[Text('calories'.tr()), Text(calories.toString())]),
            Divider(),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text('proteins'.tr()), Text(proteins.toStringAsFixed(1) + ' g')]),
            Divider(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(width: 20),
                  Text('animal_proteins'.tr()),
                ],
              ),
              Text(animalProteins.toStringAsFixed(1) + ' g')
            ]),
            Divider(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(width: 20),
                  Text('plant_proteins'.tr()),
                ],
              ),
              Text(plantProteins.toStringAsFixed(1) + ' g')
            ]),
            Divider(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[Text('carbs'.tr()), Text(carbs.toStringAsFixed(1) + ' g')]),
            Divider(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(width: 20),
                  Text('sugar'.tr()),
                ],
              ),
              Text(sugar.toStringAsFixed(1) + ' g')
            ]),
            Divider(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[Text('fats'.tr()), Text(fats.toStringAsFixed(1) + ' g')]),
            Divider(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(width: 20),
                  Text('saturated'.tr()),
                ],
              ),
              Text(saturated.toStringAsFixed(1) + ' g')
            ]),
            Divider(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(width: 20),
                  Text('unsaturated'.tr()),
                ],
              ),
              Text(unsaturated.toStringAsFixed(1) + ' g')
            ]),
            Divider(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(width: 20),
                  Text('omega3'.tr()),
                ],
              ),
              Text(omega3.toStringAsFixed(1) + ' g')
            ]),
            Divider(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(width: 20),
                  Text('omega6'.tr()),
                ],
              ),
              Text(omega6.toStringAsFixed(1) + ' g')
            ]),
            Divider(),
            Container(margin: EdgeInsets.only(top: 10, bottom: 5), child: Text('other'.tr() + ':', style: TextStyle(fontWeight: FontWeight.bold))),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[Text('fiber'.tr()), Text(fiber.toStringAsFixed(1) + ' g')]),
            Divider(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[Text('salt'.tr()), Text(salt.toStringAsFixed(1) + ' g')]),
            Divider(),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text('caffeine'.tr()), Text(caffeine.toStringAsFixed(1) + ' g')]),
            Divider(),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text('cholesterol'.tr()), Text(cholesterol.toStringAsFixed(1) + ' g')]),
            Divider(),
            Container(margin: EdgeInsets.only(top: 10, bottom: 5), child: Text('vitamins'.tr() + ':', style: TextStyle(fontWeight: FontWeight.bold))),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text('vitamin_a'.tr()), Text(vitaminA.toStringAsFixed(1) + ' g')]),
            Divider(),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text('vitamin_c'.tr()), Text(vitaminC.toStringAsFixed(1) + ' g')]),
            Divider(),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text('vitamin_d'.tr()), Text(vitaminD.toStringAsFixed(1) + ' g')]),
            Divider(),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text('vitamin_e'.tr()), Text(vitaminE.toStringAsFixed(1) + ' g')]),
            Divider(),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text('vitamin_k'.tr()), Text(vitaminK.toStringAsFixed(1) + ' g')]),
            Divider(),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text('vitamin_b1'.tr()), Text(vitaminB1.toStringAsFixed(1) + ' g')]),
            Divider(),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text('vitamin_b2'.tr()), Text(vitaminB2.toStringAsFixed(1) + ' g')]),
            Divider(),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text('vitamin_b3'.tr()), Text(vitaminB3.toStringAsFixed(1) + ' g')]),
            Divider(),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text('vitamin_b5'.tr()), Text(vitaminB5.toStringAsFixed(1) + ' g')]),
            Divider(),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text('vitamin_b6'.tr()), Text(vitaminB6.toStringAsFixed(1) + ' g')]),
            Divider(),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text('vitamin_b7'.tr()), Text(vitaminB7.toStringAsFixed(1) + ' g')]),
            Divider(),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text('vitamin_b9'.tr()), Text(vitaminB9.toStringAsFixed(1) + ' g')]),
            Divider(),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text('vitamin_b12'.tr()), Text(vitaminB12.toStringAsFixed(1) + ' g')]),
            Divider(),
            Container(margin: EdgeInsets.only(top: 10, bottom: 5), child: Text('minerals'.tr() + ':', style: TextStyle(fontWeight: FontWeight.bold))),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text('potassium'.tr()), Text(potassium.toStringAsFixed(1) + ' g')]),
            Divider(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[Text('sodium'.tr()), Text(sodium.toStringAsFixed(1) + ' g')]),
            Divider(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[Text('calcium'.tr()), Text(calcium.toStringAsFixed(1) + ' g')]),
            Divider(),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text('magnesium'.tr()), Text(magnesium.toStringAsFixed(1) + ' g')]),
            Divider(),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text('phosphorus'.tr()), Text(phosphorus.toStringAsFixed(1) + ' g')]),
            Divider(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[Text('iron'.tr()), Text(iron.toStringAsFixed(1) + ' g')]),
            Divider(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[Text('copper'.tr()), Text(copper.toStringAsFixed(1) + ' g')]),
            Divider(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[Text('zinc'.tr()), Text(zinc.toStringAsFixed(1) + ' g')]),
            Divider(),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text('selenium'.tr()), Text(selenium.toStringAsFixed(1) + ' g')]),
            Divider(),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text('manganese'.tr()), Text(manganese.toStringAsFixed(1) + ' g')]),
            Divider(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[Text('iodine'.tr()), Text(iodine.toStringAsFixed(1) + ' g')]),
            Divider(),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text('chromium'.tr()), Text(chromium.toStringAsFixed(1) + ' g')]),
            SizedBox(height: 5)
          ],
        ),
      ),
    ],
  );
}
