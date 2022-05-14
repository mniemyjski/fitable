import 'package:auto_route/auto_route.dart';
import 'package:fitable/app/favorites/widgets/favorite_tab_bar.dart';
import 'package:fitable/app/home/widgets/head_activities.dart';
import 'package:fitable/app/home/widgets/head_meals.dart';
import 'package:fitable/app/home/widgets/head_measurement.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/routes/routes.gr.dart';
import '../../../utilities/utilities.dart';
import '../../../widgets/tile_expansion.dart';
import '../../../widgets/widgets.dart';
import '../cubit/change_date/change_date_cubit.dart';
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
        body: BlocProvider(
          create: (context) => ChangeDateCubit(),
          child: _buildBody(),
        ),
        bottomSheet: NutritionalBasicValue(),
        bottomNavigationBar: BottomAppBar(),
      ),
    );
  }

  Builder _buildBody() {
    return Builder(builder: (context) {
      return Column(
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
      );
    });
  }

  void _onPushToFavoriteProduct(BuildContext context) {
    context.router.push(FavoritesRoute(eTypeTabBar: ETypeTabBar.food));
  }
}
