import 'package:fitable/app/product/models/meal_model.dart';
import 'package:fitable/app/product/models/product_model.dart';
import 'package:fitable/app/product/models/recipe_model.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';

class TileProduct extends StatelessWidget {
  final Product product;
  final Meal meal;
  final Recipe recipe;

  const TileProduct({Key key, this.product, this.meal, this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _name;
    String _size;
    String _calories;
    String _proteins;
    String _carbs;
    String _fats;

    if (product != null) {
      _name = product.name;
      _size = '100${product.unit}';
      _calories = product.calories.toStringAsFixed(0);
      _proteins = product.proteins.toStringAsFixed(1);
      _carbs = product.carbs.toStringAsFixed(1);
      _fats = product.fats.toStringAsFixed(1);
    }
    if (meal != null) {
      if (meal.product != null) {
        _name = meal.product.name;
        _size = (meal.portionSize * meal.product.portions[meal.portionChosen]).toStringAsFixed(0) + meal.product.unit;
        _calories = (meal.product.calories * meal.portionSize * meal.product.portions[meal.portionChosen] / 100).toStringAsFixed(0);
        _proteins = (meal.product.proteins * meal.portionSize * meal.product.portions[meal.portionChosen] / 100).toStringAsFixed(1);
        _carbs = (meal.product.carbs * meal.portionSize * meal.product.portions[meal.portionChosen] / 100).toStringAsFixed(1);
        _fats = (meal.product.fats * meal.portionSize * meal.product.portions[meal.portionChosen] / 100).toStringAsFixed(1);
      }
      if (meal.recipe != null) {
        _name = meal.recipe.name;
      }
    }
    if (recipe != null) {
      _name = recipe.name;
    }

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
                        child: Text(_name,
                            style: TextStyle(fontSize: 12, color: Theme.of(context).textTheme.bodyText2.color, fontStyle: FontStyle.italic)),
                      ),
                      Container(
                          margin: EdgeInsets.only(bottom: 0),
                          width: double.infinity,
                          child: Text(_size,
                              style: TextStyle(fontSize: 12, color: Theme.of(context).textTheme.bodyText2.color, fontStyle: FontStyle.italic))),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Text('kcal'.tr() + ': $_calories',
                              style: TextStyle(fontSize: 12, color: Theme.of(context).textTheme.bodyText2.color, fontStyle: FontStyle.italic)),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text('p'.tr() + ': $_proteins g',
                              style: TextStyle(fontSize: 12, color: Theme.of(context).textTheme.bodyText2.color, fontStyle: FontStyle.italic)),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text('c'.tr() + ': $_carbs g',
                              style: TextStyle(fontSize: 12, color: Theme.of(context).textTheme.bodyText2.color, fontStyle: FontStyle.italic)),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text('f'.tr() + ': $_fats g',
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
