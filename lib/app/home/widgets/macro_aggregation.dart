import 'package:fitable/app/account/models/preference_model.dart';
import 'package:fitable/app/home/view_models/app_view_model.dart';
import 'package:fitable/app/home/view_models/home_view_model.dart';
import 'package:fitable/app/home/widgets/progress_bar.dart';
import 'package:fitable/app/meal/models/ingredient_model.dart';
import 'package:fitable/app/meal/models/meal_model.dart';
import 'package:fitable/app/meal/models/portion_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MacroAggregation extends ConsumerWidget {
  final int calories;
  final double proteins;
  final double carbs;
  final double fats;
  final List<Ingredient> ingredients;

  const MacroAggregation({Key key, this.calories = 0, this.proteins = 0.0, this.carbs = 0.0, this.fats = 0.0, this.ingredients}) : super(key: key);

  _buildBody(List<Meal> data) {
    return Consumer(builder: (context, watch, child) {
      final model = watch(providerHomeViewModel);
      final app = watch(providerAppViewModel);
      model.mealList = data.where((element) => element.dateTime == app.chosenDate).toList();
      model.calculateBMR(context: context);

      int _oldCalories;
      double _oldProteins;
      double _oldCarbs;
      double _oldFats;

      if (ingredients != null) {
        ingredients.forEach((element) {
          Portion portion;
          element.product.portions.forEach((v) {
            if (v.name == element.selectedPortion.name) {
              portion = v;
            }
            return;
          });

          _oldCalories = (element.product.calories * element.selectedPortion.size * portion.size / 100).round();
          _oldProteins = element.product.proteins * element.selectedPortion.size * portion.size / 100;
          _oldCarbs = element.product.carbs * element.selectedPortion.size * portion.size / 100;
          _oldFats = element.product.fats * element.selectedPortion.size * portion.size / 100;
        });
      }

      return Container(
          height: 60,
          margin: EdgeInsets.only(top: 5, bottom: 5),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ProgressBar(
                  mainBar: true,
                  name: 'calories',
                  value: double.tryParse(calories?.toString()),
                  valueTotal: model.calories.roundToDouble() - (ingredients != null ? _oldCalories : 0),
                  valueTarget: model.goalCalories.roundToDouble(),
                  proteins: proteins + model.proteins,
                  carbs: carbs + model.carbs,
                  fats: fats + model.fats,
                  colorVolume: Colors.blue[700],
                  colorTotal: Colors.lightBlue),
              ProgressBar(
                  mainBar: false,
                  name: 'proteins',
                  value: proteins,
                  valueTotal: model.proteins - (ingredients != null ? _oldProteins : 0),
                  valueTarget: model.goalProteins,
                  proteins: proteins,
                  carbs: carbs,
                  fats: fats,
                  colorVolume: Colors.green[700],
                  colorTotal: Colors.lightGreen),
              ProgressBar(
                  mainBar: false,
                  name: 'carbs',
                  value: carbs,
                  valueTotal: model.carbs - (ingredients != null ? _oldCarbs : 0),
                  valueTarget: model.goalCarbs,
                  proteins: proteins,
                  carbs: carbs,
                  fats: fats,
                  colorVolume: Colors.orange[700],
                  colorTotal: Colors.orangeAccent),
              ProgressBar(
                  mainBar: false,
                  name: 'fats',
                  value: fats,
                  valueTotal: model.fats - (ingredients != null ? _oldFats : 0),
                  valueTarget: model.goalFats,
                  proteins: proteins,
                  carbs: carbs,
                  fats: fats,
                  colorVolume: Colors.red[700],
                  colorTotal: Colors.redAccent),
            ],
          ));
    });
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final meals = watch(providerMeals);
    final preference = watch(providerPreference);

    return meals.when(
      data: (data) {
        return preference.when(
          data: (pref) => _buildBody(data),
          loading: () => Center(
            child: Container(height: 100, width: 100, child: CircularProgressIndicator()),
          ),
          error: (err, stack) => Center(child: Text('Error: $err')),
        );
      },
      loading: () => Center(
        child: Container(height: 100, width: 100, child: CircularProgressIndicator()),
      ),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }
}
