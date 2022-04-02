import 'package:auto_route/auto_route.dart';
import 'package:fitable/app/home/widgets/head_meals.dart';
import 'package:fitable/app/home/widgets/head_measurement.dart';
import 'package:fitable/app/home/widgets/head_workout.dart';
import 'package:flutter/material.dart';

import '../../../config/routes/routes.gr.dart';
import '../../../constants/constants.dart';
import '../../../widgets/tile_expansion.dart';
import '../../../widgets/widgets.dart';
import '../widgets/date_chooser.dart';
import '../widgets/element_meal.dart';
import '../widgets/nutritional_value.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: customAppBar(title: Strings.home()),
        drawer: CustomDrawer(),
        body: Column(
          children: [
            DateChooser(),
            Expanded(
              child: ListView(
                children: [
                  TileExpansion(
                    head: HeadMeals(
                        name: Strings.breakfast(), kcal: 0, proteins: 0, carbs: 0, fats: 0),
                    list: [
                      ElementMeal(style: Theme.of(context).textTheme.bodyText2),
                      ElementMeal(style: Theme.of(context).textTheme.bodyText2),
                      ElementMeal(style: Theme.of(context).textTheme.bodyText2),
                      ElementMeal(style: Theme.of(context).textTheme.bodyText2),
                    ],
                    onPressed: () => context.router.push(FavoritesRoute()),
                  ),
                  TileExpansion(
                      head:
                          HeadMeals(name: Strings.lunch(), kcal: 0, proteins: 0, carbs: 0, fats: 0),
                      list: [
                        ElementMeal(style: Theme.of(context).textTheme.bodyText2),
                        ElementMeal(style: Theme.of(context).textTheme.bodyText2),
                      ],
                      onPressed: () => context.router.push(FavoritesRoute())),
                  TileExpansion(
                      head: HeadMeals(
                          name: Strings.dinner(), kcal: 0, proteins: 0, carbs: 0, fats: 0),
                      list: [
                        ElementMeal(style: Theme.of(context).textTheme.bodyText2),
                        ElementMeal(style: Theme.of(context).textTheme.bodyText2),
                        ElementMeal(style: Theme.of(context).textTheme.bodyText2),
                      ],
                      onPressed: () => context.router.push(FavoritesRoute())),
                  TileExpansion(
                      head: HeadMeals(
                          name: Strings.supper(), kcal: 0, proteins: 0, carbs: 0, fats: 0),
                      list: [
                        ElementMeal(style: Theme.of(context).textTheme.bodyText2),
                      ],
                      onPressed: () => context.router.push(FavoritesRoute())),
                  TileExpansion(
                      head:
                          HeadMeals(name: Strings.snack(), kcal: 0, proteins: 0, carbs: 0, fats: 0),
                      list: [
                        ElementMeal(style: Theme.of(context).textTheme.bodyText2),
                        ElementMeal(style: Theme.of(context).textTheme.bodyText2),
                      ],
                      onPressed: () => context.router.push(FavoritesRoute())),
                  TileExpansion(
                      head: HeadWorkout(),
                      list: [],
                      onPressed: () => context.router.push(FavoritesRoute())),
                  TileExpansion(
                      head: HeadMeasurement(),
                      list: [],
                      onPressed: () => context.router.push(FavoritesRoute())),
                  SizedBox(
                    height: 100,
                  )
                ],
              ),
            ),
          ],
        ),
        bottomSheet: NutritionalValue(),
      ),
    );
  }
}
