import 'package:fitable/app/home/widgets/chooser_date.dart';
import 'package:fitable/app/home/widgets/macro_aggregation.dart';
import 'package:fitable/app/home/widgets/tile_head_meals.dart';
import 'package:fitable/app/home/widgets/tile_head_measurement.dart';
import 'package:fitable/app/home/widgets/tile_head_workouts.dart';
import 'package:fitable/common_widgets/custom_app_bar.dart';
import 'package:fitable/common_widgets/monetize_ad.dart';
import 'package:fitable/common_widgets/main_drawer.dart';
import 'package:fitable/utilities/enums.dart';
import 'package:fitable/utilities/languages.dart';
import 'package:fitable/services/health_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read(providerHealthService).checkAuthorizationHealth();
    context.read(providerHealthService).getHealthData(
          DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
          ),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(Languages.home()),
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
                ChooserDate(-1),
                ChooserDate(0),
                ChooserDate(1),
              ],
            )),
        Expanded(
            child: ListView(
          children: [
            MonetizeAd(),
            TileHeadMeals(mealType: ETypeMeal.breakfast),
            TileHeadMeals(mealType: ETypeMeal.lunch),
            TileHeadMeals(mealType: ETypeMeal.dinner),
            TileHeadMeals(mealType: ETypeMeal.supper),
            TileHeadMeals(mealType: ETypeMeal.snack),
            TileHeadWorkouts(),
            TileHeadMeasurement(),
            SizedBox(height: 40)
          ],
        ))
      ]),
      bottomNavigationBar: BottomAppBar(child: MacroAggregation()),
    );
  }
}
