import 'package:fitable/app/meal/recipe_details_screen.dart';
import 'package:fitable/common_widgets/build_main_app_bar.dart';
import 'package:fitable/common_widgets/custom_list_view.dart';
import 'package:fitable/common_widgets/custom_scaffold.dart';
import 'package:fitable/common_widgets/main_drawer.dart';
import 'package:fitable/constants/constants.dart';
import 'package:fitable/constants/enums.dart';
import 'package:fitable/routers/route_generator.dart';
import 'package:fitable/services/providers.dart';
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
              child: Text(Constants.see_everything(), style: TextStyle(color: Colors.blueAccent, fontStyle: FontStyle.italic, fontSize: 14)),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: buildMainAppBar(context: context, name: Constants.recipes()),
      drawer: MainDrawer(),
      body: SingleChildScrollView(
        child: Consumer(builder: (context, watch, child) {
          final db = watch(providerDatabase);

          return Column(
            children: [
              _buildHeading(Constants.last()),
              Container(
                height: 235,
                padding: const EdgeInsets.all(4.0),
                child: StreamBuilder(
                    stream: db.streamRecipes(SortType.last),
                    builder: (context, snapshot) {
                      if (snapshot.hasData)
                        return CustomListView(
                          list: snapshot.data,
                          type: EnumTileType.imageRecipe,
                          scrollDirection: Axis.horizontal,
                          onPressed: (element) => Navigator.of(context).pushNamed(AppRoute.recipeDetailsScreen,
                              arguments: RecipeDetailsScreenArguments(
                                recipe: element,
                                chooseMealType: true,
                              )),
                        );

                      return Container();
                    }),
              ),
              _buildHeading(Constants.best()),
              Container(
                height: 235,
                padding: const EdgeInsets.all(4.0),
                child: StreamBuilder(
                    stream: db.streamRecipes(SortType.best),
                    builder: (context, snapshot) {
                      if (snapshot.hasData)
                        return CustomListView(
                          list: snapshot.data,
                          type: EnumTileType.imageRecipe,
                          scrollDirection: Axis.horizontal,
                          onPressed: (element) => Navigator.of(context).pushNamed(AppRoute.recipeDetailsScreen,
                              arguments: RecipeDetailsScreenArguments(
                                recipe: element,
                                chooseMealType: true,
                              )),
                        );

                      return Container();
                    }),
              ),
              _buildHeading(Constants.popular()),
              Container(
                height: 235,
                padding: const EdgeInsets.all(4.0),
                child: StreamBuilder(
                    stream: db.streamRecipes(SortType.popular),
                    builder: (context, snapshot) {
                      if (snapshot.hasData)
                        return CustomListView(
                          list: snapshot.data,
                          type: EnumTileType.imageRecipe,
                          scrollDirection: Axis.horizontal,
                          onPressed: (element) => Navigator.of(context).pushNamed(AppRoute.recipeDetailsScreen,
                              arguments: RecipeDetailsScreenArguments(
                                recipe: element,
                                chooseMealType: true,
                              )),
                        );

                      return Container();
                    }),
              ),
              _buildHeading(Constants.ketogenic()),
              Container(
                height: 235,
                padding: const EdgeInsets.all(4.0),
                child: StreamBuilder(
                    stream: db.streamRecipes(SortType.popular),
                    builder: (context, snapshot) {
                      if (snapshot.hasData)
                        return CustomListView(
                          list: snapshot.data,
                          type: EnumTileType.imageRecipe,
                          scrollDirection: Axis.horizontal,
                          onPressed: (element) => Navigator.of(context).pushNamed(AppRoute.recipeDetailsScreen,
                              arguments: RecipeDetailsScreenArguments(
                                recipe: element,
                                chooseMealType: true,
                              )),
                        );

                      return Container();
                    }),
              ),
              _buildHeading(Constants.high_protein()),
              Container(
                height: 235,
                padding: const EdgeInsets.all(4.0),
                child: StreamBuilder(
                    stream: db.streamRecipes(SortType.popular),
                    builder: (context, snapshot) {
                      if (snapshot.hasData)
                        return CustomListView(
                          list: snapshot.data,
                          type: EnumTileType.imageRecipe,
                          scrollDirection: Axis.horizontal,
                          onPressed: (element) => Navigator.of(context).pushNamed(AppRoute.recipeDetailsScreen,
                              arguments: RecipeDetailsScreenArguments(
                                recipe: element,
                                chooseMealType: true,
                              )),
                        );

                      return Container();
                    }),
              ),
              _buildHeading(Constants.low_fats()),
              Container(
                height: 235,
                padding: const EdgeInsets.all(4.0),
                child: StreamBuilder(
                    stream: db.streamRecipes(SortType.popular),
                    builder: (context, snapshot) {
                      if (snapshot.hasData)
                        return CustomListView(
                          list: snapshot.data,
                          type: EnumTileType.imageRecipe,
                          scrollDirection: Axis.horizontal,
                          onPressed: (element) => Navigator.of(context).pushNamed(AppRoute.recipeDetailsScreen,
                              arguments: RecipeDetailsScreenArguments(
                                recipe: element,
                                chooseMealType: true,
                              )),
                        );

                      return Container();
                    }),
              ),
              SizedBox(height: 40),
            ],
          );
        }),
      ),
    );
  }
}
