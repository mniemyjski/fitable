import 'package:fitable/app/account/models/preference_model.dart';
import 'package:fitable/app/home/view_models/app_view_model.dart';
import 'package:fitable/app/home/view_models/home_view_model.dart';
import 'package:fitable/app/home/widgets/chooser_date.dart';
import 'package:fitable/app/home/widgets/macro_aggregation.dart';
import 'package:fitable/app/home/widgets/tile_head_meals.dart';
import 'package:fitable/app/home/widgets/tile_head_measurement.dart';
import 'package:fitable/app/home/widgets/tile_head_workouts.dart';
import 'package:fitable/app/meal/models/meal_model.dart';
import 'package:fitable/app/measurement/models/measurement_model.dart';
import 'package:fitable/common_widgets/build_main_app_bar.dart';
import 'package:fitable/common_widgets/monetize_ad.dart';
import 'package:fitable/common_widgets/main_drawer.dart';
import 'package:fitable/utilities/enums.dart';
import 'package:fitable/utilities/languages.dart';
import 'package:fitable/utilities/providers.dart';
import 'package:fitable/services/sync_health.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatelessWidget {
  _buildBottomAppBar() {
    return BottomAppBar(
      child: Consumer(builder: (context, watch, child) {
        final meals = watch(providerMeals);
        final model = watch(providerHomeViewModel);
        final app = watch(providerAppViewModel);
        final db = watch(providerDatabase);

        watch(providerPreference).whenData((preference) {
          watch(providerMeasurement).whenData((measurement) {
            syncHealth(app.chosenDate, preference, measurement, db);
          });
        });

        return meals.when(
          data: (data) {
            model.mealList = data.where((element) => element.dateTime == app.chosenDate).toList();
            return MacroAggregation();
          },
          loading: () => Center(
            child: Container(height: 100, width: 100, child: CircularProgressIndicator()),
          ),
          error: (err, stack) => Center(child: Text('Error: $err')),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildMainAppBar(context: context, name: Languages.home()),
      drawer: MainDrawer(),
      body: Column(children: [
        Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).primaryColorDark.withOpacity(0.6),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              children: <Widget>[
                chooserDate(-1),
                chooserDate(0),
                chooserDate(1),
              ],
            )),
        Expanded(
            child: ListView(
          children: [
            MonetizeAd(),
            TileHeadMeals(mealType: TypeMeal.breakfast),
            TileHeadMeals(mealType: TypeMeal.lunch),
            TileHeadMeals(mealType: TypeMeal.dinner),
            TileHeadMeals(mealType: TypeMeal.supper),
            TileHeadMeals(mealType: TypeMeal.snack),
            TileHeadWorkouts(),
            TileHeadMeasurement(),
            SizedBox(height: 40)
          ],
        ))
      ]),
      bottomNavigationBar: _buildBottomAppBar(),
    );
  }
}
