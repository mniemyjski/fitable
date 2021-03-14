import 'package:fitable/common_widgets/build_main_app_bar.dart';
import 'package:fitable/common_widgets/custom_list_view.dart';
import 'package:fitable/common_widgets/custom_scaffold.dart';
import 'package:fitable/common_widgets/main_drawer.dart';
import 'package:fitable/routers/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class RecipesScreen extends StatelessWidget {
  _buildHeading(String text) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(left: 8, top: 8),
        child: Text(text, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: buildMainAppBar('recipes'.tr()),
      drawer: MainDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeading('new_recipes'),
            Container(
              height: 235,
              padding: const EdgeInsets.all(4.0),
              child: CustomListView(
                list: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'],
                type: EnumTileType.imageRecipe,
                scrollDirection: Axis.horizontal,
                onPressed: (element) => Navigator.pushNamed(context, AppRoute.recipeDetailsScreen),
              ),
            ),
            _buildHeading('best_recipes'),
            Container(
              height: 235,
              padding: const EdgeInsets.all(4.0),
              child: CustomListView(
                list: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'],
                type: EnumTileType.imageRecipe,
                scrollDirection: Axis.horizontal,
                onPressed: (element) => Navigator.pushNamed(context, AppRoute.recipeDetailsScreen),
              ),
            ),
            _buildHeading('popular_recipes'),
            Container(
              height: 235,
              padding: const EdgeInsets.all(4.0),
              child: CustomListView(
                list: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'],
                type: EnumTileType.imageRecipe,
                scrollDirection: Axis.horizontal,
                onPressed: (element) => Navigator.pushNamed(context, AppRoute.recipeDetailsScreen),
              ),
            ),
            SizedBox(height: 120),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => Navigator.pushNamed(context, AppRoute.recipeCreateScreen),
      //   child: Icon(Icons.add, color: Colors.white),
      // ),
    );
  }
}
