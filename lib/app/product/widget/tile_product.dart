import 'package:fitable/app/meal/models/meal_model.dart';
import 'package:fitable/app/product/models/ingredient_model.dart';
import 'package:fitable/app/product/models/product_model.dart';
import 'package:fitable/app/recipe/models/recipe_model.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

enum getV { name, size, calories, proteins, carbs, fats }

class TileProduct extends StatelessWidget {
  final element;

  const TileProduct(this.element);

  String _getValue(getV v) {
    String _name;
    String _size;
    String _calories;
    String _proteins;
    String _carbs;
    String _fats;

    double _kcal = 0;
    double _p = 0;
    double _c = 0;
    double _f = 0;

    if (element.runtimeType == Product) {
      _name = element.name;
      _size = '100${element.unit}';
      _calories = element.calories.toStringAsFixed(0);
      _proteins = element.proteins.toStringAsFixed(1);
      _carbs = element.carbs.toStringAsFixed(1);
      _fats = element.fats.toStringAsFixed(1);
    }
    if (element.runtimeType == Ingredient) {
      _name = element.product.name;
      _size = (element.portionSize * element.product.portions[element.portionChosen]).toStringAsFixed(0) + element.product.unit;
      _calories = (element.product.calories * element.portionSize * element.product.portions[element.portionChosen] / 100).toStringAsFixed(0);
      _proteins = (element.product.proteins * element.portionSize * element.product.portions[element.portionChosen] / 100).toStringAsFixed(1);
      _carbs = (element.product.carbs * element.portionSize * element.product.portions[element.portionChosen] / 100).toStringAsFixed(1);
      _fats = (element.product.fats * element.portionSize * element.product.portions[element.portionChosen] / 100).toStringAsFixed(1);
    }
    if (element.runtimeType == Meal) {
      if (element.product != null) {
        _name = element.product.name;
        _size = (element.portionSize * element.product.portions[element.portionChosen]).toStringAsFixed(0) + element.product.unit;
        _calories = (element.product.calories * element.portionSize * element.product.portions[element.portionChosen] / 100).toStringAsFixed(0);
        _proteins = (element.product.proteins * element.portionSize * element.product.portions[element.portionChosen] / 100).toStringAsFixed(1);
        _carbs = (element.product.carbs * element.portionSize * element.product.portions[element.portionChosen] / 100).toStringAsFixed(1);
        _fats = (element.product.fats * element.portionSize * element.product.portions[element.portionChosen] / 100).toStringAsFixed(1);
      }
      if (element.recipe != null) {
        _name = element.recipe.name;
        _size = (element.portionSize * element.recipe.portions[element.portionChosen]).toStringAsFixed(0) + element.recipe.unit;
        element.recipe.ingredients.forEach((element) {
          _kcal = (element.product.calories * element.portionSize * element.product.portions[element.portionChosen] / 100);
          _p = (element.product.proteins * element.portionSize * element.product.portions[element.portionChosen] / 100);
          _c = (element.product.carbs * element.portionSize * element.product.portions[element.portionChosen] / 100);
          _f = (element.product.fats * element.portionSize * element.product.portions[element.portionChosen] / 100);
        });
        _calories = (_kcal * element.portionSize * element.recipe.portions[element.portionChosen] / 100).toStringAsFixed(0);
        _proteins = (_p * element.portionSize * element.recipe.portions[element.portionChosen] / 100).toStringAsFixed(1);
        _carbs = (_c * element.portionSize * element.recipe.portions[element.portionChosen] / 100).toStringAsFixed(1);
        _fats = (_f * element.portionSize * element.recipe.portions[element.portionChosen] / 100).toStringAsFixed(1);
      }
    }
    if (element.runtimeType == Recipe) {
      _name = element.name;
      _size = '100${element.unit}';
      element.ingredients.forEach((element) {
        _kcal = (element.product.calories * element.portionSize * element.product.portions[element.portionChosen] / 100);
        _p = (element.product.proteins * element.portionSize * element.product.portions[element.portionChosen] / 100);
        _c = (element.product.carbs * element.portionSize * element.product.portions[element.portionChosen] / 100);
        _f = (element.product.fats * element.portionSize * element.product.portions[element.portionChosen] / 100);
      });
      _calories = _kcal.toStringAsFixed(0);
      _proteins = _p.toStringAsFixed(1);
      _carbs = _c.toStringAsFixed(1);
      _fats = _f.toStringAsFixed(1);
    }

    switch (v) {
      case getV.name:
        return _name;
        break;
      case getV.size:
        return _size;
        break;
      case getV.calories:
        return 'kcal'.tr() + ': $_calories';
        break;
      case getV.proteins:
        return 'p'.tr() + ': $_proteins g';
        break;
      case getV.carbs:
        return 'c'.tr() + ': $_carbs g';
        break;
      case getV.fats:
        return 'f'.tr() + ': $_fats g';
        break;
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            margin: EdgeInsets.all(1),
            decoration: BoxDecoration(),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 0),
                        width: double.infinity,
                        child: Text(_getValue(getV.name),
                            style: TextStyle(fontSize: 12, color: Theme.of(context).textTheme.bodyText2.color, fontStyle: FontStyle.italic)),
                      ),
                      Container(
                          margin: EdgeInsets.only(bottom: 0),
                          width: double.infinity,
                          child: Text(_getValue(getV.size),
                              style: TextStyle(fontSize: 12, color: Theme.of(context).textTheme.bodyText2.color, fontStyle: FontStyle.italic))),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Text(_getValue(getV.calories),
                              style: TextStyle(fontSize: 12, color: Theme.of(context).textTheme.bodyText2.color, fontStyle: FontStyle.italic)),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(_getValue(getV.proteins),
                              style: TextStyle(fontSize: 12, color: Theme.of(context).textTheme.bodyText2.color, fontStyle: FontStyle.italic)),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(_getValue(getV.carbs),
                              style: TextStyle(fontSize: 12, color: Theme.of(context).textTheme.bodyText2.color, fontStyle: FontStyle.italic)),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(_getValue(getV.fats),
                              style: TextStyle(fontSize: 12, color: Theme.of(context).textTheme.bodyText2.color, fontStyle: FontStyle.italic)),
                        ),
                      ]),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
