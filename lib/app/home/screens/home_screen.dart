import 'package:auto_route/auto_route.dart';
import 'package:fitable/app/favorites/widgets/favorite_tab_bar.dart';
import 'package:fitable/app/home/widgets/head_activities.dart';
import 'package:fitable/app/home/widgets/head_meals.dart';
import 'package:fitable/app/home/widgets/head_measurement.dart';
import 'package:flutter/material.dart';

import '../../../config/routes/routes.gr.dart';
import '../../../utilities/utilities.dart';
import '../../../widgets/tile_expansion.dart';
import '../../../widgets/widgets.dart';
import '../widgets/date_chooser.dart';
import '../widgets/element_meal.dart';
import '../widgets/nutritional_basic_value.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: customAppBar(title: AppLocalizations.of(context)!.home),
        drawer: CustomDrawer(),
        body: Column(
          children: [
            DateChooser(),
            Expanded(
              child: ListView(
                children: [
                  TileExpansion(
                    head: HeadMeals(
                        name: AppLocalizations.of(context)!.breakfast,
                        kcal: 0,
                        proteins: 0,
                        carbs: 0,
                        fats: 0),
                    list: [
                      ElementMeal(style: Theme.of(context).textTheme.bodyText2),
                      ElementMeal(style: Theme.of(context).textTheme.bodyText2),
                      ElementMeal(style: Theme.of(context).textTheme.bodyText2),
                      ElementMeal(style: Theme.of(context).textTheme.bodyText2),
                    ],
                    onPressed: () => _onPushToFavoriteProduct(context),
                  ),
                  TileExpansion(
                      head: HeadMeals(
                          name: AppLocalizations.of(context)!.lunch,
                          kcal: 0,
                          proteins: 0,
                          carbs: 0,
                          fats: 0),
                      list: [
                        ElementMeal(style: Theme.of(context).textTheme.bodyText2),
                      ],
                      onPressed: () => _onPushToFavoriteProduct(context)),
                  TileExpansion(
                      head: HeadMeals(
                          name: AppLocalizations.of(context)!.dinner,
                          kcal: 0,
                          proteins: 0,
                          carbs: 0,
                          fats: 0),
                      list: [
                        ElementMeal(style: Theme.of(context).textTheme.bodyText2),
                      ],
                      onPressed: () => _onPushToFavoriteProduct(context)),
                  TileExpansion(
                      head: HeadMeals(
                          name: AppLocalizations.of(context)!.supper,
                          kcal: 0,
                          proteins: 0,
                          carbs: 0,
                          fats: 0),
                      list: [
                        ElementMeal(style: Theme.of(context).textTheme.bodyText2),
                      ],
                      onPressed: () => _onPushToFavoriteProduct(context)),
                  TileExpansion(
                      head: HeadMeals(
                          name: AppLocalizations.of(context)!.snack,
                          kcal: 0,
                          proteins: 0,
                          carbs: 0,
                          fats: 0),
                      list: [
                        ElementMeal(style: Theme.of(context).textTheme.bodyText2),
                      ],
                      onPressed: () => _onPushToFavoriteProduct(context)),
                  TileExpansion(
                      head: HeadActivities(),
                      list: [],
                      onPressed: () => context.router.push(
                            FavoritesRoute(
                              eTypeTabBar: ETypeTabBar.workout,
                            ),
                          )),
                  TileExpansion(head: HeadMeasurement(), list: [], onPressed: () => null),
                  SizedBox(
                    height: 100,
                  )
                ],
              ),
            ),
          ],
        ),
        bottomSheet: NutritionalBasicValue(),
        bottomNavigationBar: BottomAppBar(),
      ),
    );
  }

  void _onPushToFavoriteProduct(BuildContext context) {
    context.router.push(FavoritesRoute(eTypeTabBar: ETypeTabBar.food));
  }
}
