import 'package:fitable/models/ingredient_model.dart';
import 'package:fitable/app/meal/recipe_details_screen.dart';
import 'package:fitable/common_widgets/custom_app_bar.dart';
import 'package:fitable/common_widgets/custom_list_view.dart';
import 'package:fitable/common_widgets/main_drawer.dart';

import 'package:fitable/services/services.dart';
import 'package:fitable/utilities/languages.dart';

import 'package:fitable/routers/route_generator.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecipesScreen extends StatelessWidget {
  _buildHeading(String text) {
    return Column(
      children: [
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 8, top: 8),
                child: Text(text, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8, top: 8),
              child: Text(Languages.see_everything(), style: TextStyle(color: Colors.blueAccent, fontStyle: FontStyle.italic, fontSize: 14)),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(Languages.recipes()),
      drawer: MainDrawer(),
      body: SingleChildScrollView(
        child: Consumer(builder: (context, watch, child) {
          final recipesNew = watch(providerRecipesNew);
          final recipesPopular = watch(providerRecipesPopular);
          final recipesRatings = watch(providerRecipesRatings);

          return Column(
            children: [
              _buildHeading(Languages.last()),
              Container(
                height: 235,
                padding: const EdgeInsets.all(4.0),
                child: recipesNew.when(
                  data: (data) {
                    return CustomListView(
                        list: data,
                        type: EnumTileType.imageRecipe,
                        scrollDirection: Axis.horizontal,
                        onPressed: (element) => Navigator.of(context).pushNamed(AppRoute.recipeDetailsScreen,
                            arguments: RecipeDetailsScreenArguments(
                              element: Ingredient.transform(element),
                              chooseMealType: true,
                            )));
                  },
                  loading: () => Container(),
                  error: (e, r) => Container(),
                ),
              ),
              _buildHeading(Languages.best()),
              Container(
                height: 235,
                padding: const EdgeInsets.all(4.0),
                child: recipesRatings.when(
                  data: (data) {
                    return CustomListView(
                        list: data,
                        type: EnumTileType.imageRecipe,
                        scrollDirection: Axis.horizontal,
                        onPressed: (element) => Navigator.of(context).pushNamed(AppRoute.recipeDetailsScreen,
                            arguments: RecipeDetailsScreenArguments(
                              element: Ingredient.transform(element),
                              chooseMealType: true,
                            )));
                  },
                  loading: () => Container(),
                  error: (e, r) => Container(),
                ),
              ),
              _buildHeading(Languages.popular()),
              Container(
                height: 235,
                padding: const EdgeInsets.all(4.0),
                child: recipesPopular.when(
                  data: (data) {
                    return CustomListView(
                        list: data,
                        type: EnumTileType.imageRecipe,
                        scrollDirection: Axis.horizontal,
                        onPressed: (element) => Navigator.of(context).pushNamed(AppRoute.recipeDetailsScreen,
                            arguments: RecipeDetailsScreenArguments(
                              element: Ingredient.transform(element),
                              chooseMealType: true,
                            )));
                  },
                  loading: () => Container(),
                  error: (e, r) => Container(),
                ),
              ),
              _buildHeading(Languages.ketogenic()),
              // Container(
              //   height: 235,
              //   padding: const EdgeInsets.all(4.0),
              //   child: StreamBuilder(
              //       stream: db.streamRecipes(ETypeSort.popular),
              //       builder: (context, snapshot) {
              //         if (snapshot.hasData)
              //           return CustomListView(
              //             list: snapshot.data,
              //             type: EnumTileType.imageRecipe,
              //             scrollDirection: Axis.horizontal,
              //             onPressed: (element) => Navigator.of(context).pushNamed(AppRoute.recipeDetailsScreen,
              //                 arguments: RecipeDetailsScreenArguments(
              //                   element: Ingredient.transform(element),
              //                   chooseMealType: true,
              //                 )),
              //           );
              //
              //         return Container();
              //       }),
              // ),
              _buildHeading(Languages.high_protein()),
              // Container(
              //   height: 235,
              //   padding: const EdgeInsets.all(4.0),
              //   child: StreamBuilder(
              //       stream: db.streamRecipes(ETypeSort.popular),
              //       builder: (context, snapshot) {
              //         if (snapshot.hasData)
              //           return CustomListView(
              //             list: snapshot.data,
              //             type: EnumTileType.imageRecipe,
              //             scrollDirection: Axis.horizontal,
              //             onPressed: (element) => Navigator.of(context).pushNamed(AppRoute.recipeDetailsScreen,
              //                 arguments: RecipeDetailsScreenArguments(
              //                   element: Ingredient.transform(element),
              //                   chooseMealType: true,
              //                 )),
              //           );
              //
              //         return Container();
              //       }),
              // ),
              _buildHeading(Languages.low_fats()),
              // Container(
              //   height: 235,
              //   padding: const EdgeInsets.all(4.0),
              //   child: StreamBuilder(
              //       stream: db.streamRecipes(ETypeSort.popular),
              //       builder: (context, snapshot) {
              //         if (snapshot.hasData)
              //           return CustomListView(
              //             list: snapshot.data,
              //             type: EnumTileType.imageRecipe,
              //             scrollDirection: Axis.horizontal,
              //             onPressed: (element) => Navigator.of(context).pushNamed(AppRoute.recipeDetailsScreen,
              //                 arguments: RecipeDetailsScreenArguments(
              //                   element: Ingredient.transform(element),
              //                   chooseMealType: true,
              //                 )),
              //           );
              //
              //         return Container();
              //       }),
              // ),
              SizedBox(height: 40),
            ],
          );
        }),
      ),
    );
  }
}
