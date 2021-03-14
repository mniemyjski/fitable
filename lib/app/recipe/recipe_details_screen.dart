import 'package:auto_size_text/auto_size_text.dart';
import 'package:fitable/app/favorite/models/favorite_model.dart';
import 'package:fitable/app/home/widgets/macro_aggregation.dart';
import 'package:fitable/app/product/models/ingredient_model.dart';
import 'package:fitable/app/product/widget/nutritional.dart';
import 'package:fitable/app/recipe/models/recipe_model.dart';
import 'package:fitable/app/recipe/view_models/recipe_details_view_model.dart';
import 'package:fitable/app/recipe/widgets/recipe_carousel_slider.dart';
import 'package:fitable/common_widgets/custom_drop_down_button.dart';
import 'package:fitable/common_widgets/custom_list_view.dart';
import 'package:fitable/common_widgets/custom_scaffold.dart';
import 'package:fitable/common_widgets/custom_text_field.dart';
import 'package:fitable/common_widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class RecipeDetailsScreenArguments {
  final Recipe recipe;
  final int value;

  RecipeDetailsScreenArguments({this.recipe, this.value});
}

Icon _buildIcon(BuildContext context) {
  final RecipeDetailsScreenArguments args = ModalRoute.of(context).settings.arguments;
  if (args.value != null) {
    return Icon(Icons.edit, color: Colors.white);
  } else {
    return Icon(Icons.add, color: Colors.white);
  }
}

class RecipeDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final RecipeDetailsScreenArguments args = ModalRoute.of(context).settings.arguments;

      final model = watch(providerRecipeDetailsViewModel);
      watch(providerFavorite).whenData((favorites) => model.build(args.recipe, favorites));

      return CustomScaffold(
        appBar: AppBar(
          title: Text('recipe_details'),
          actions: [
            IconButton(
              icon: model.isFavorite ? Icon(FontAwesomeIcons.solidHeart) : Icon(FontAwesomeIcons.heart),
              onPressed: () => context.read(providerRecipeDetailsViewModel).submitFavorite(context, args.recipe.id),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              RecipeCarouselSlider(),
              Card(
                child: Container(
                  height: 55,
                  width: double.infinity,
                  child: Center(
                      child: AutoSizeText(
                    model.name,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    maxLines: 1,
                  )),
                ),
              ),
              Card(
                  child: MacroAggregation(
                calories: model.calories,
                proteins: model.proteins,
                carbs: model.carbs,
                fats: model.fats,
                ingredients: args.recipe.ingredients,
              )),
              Row(
                children: [
                  Container(
                    width: 150,
                    child: CustomTextField(
                      keyboardType: TextInputType.number,
                      hintText: args.value ?? '100',
                      onChanged: (v) {
                        model.portionSize = double.tryParse(v);
                      },
                    ),
                  ),
                  Expanded(
                      child: CustomDropDownButton(
                          name: '',
                          value: model.portionChosen,
                          list: model.portions.keys.toList(),
                          onChanged: (v) {
                            model.portionChosen = v;
                          }))
                ],
              ),
              Card(
                child: Container(
                  padding: EdgeInsets.all(4),
                  width: double.infinity,
                  // child: Center(child: Text(model.name)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("key_words".tr() + ":", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(
                        model.keyWords.toString().substring(1, model.keyWords.toString().length - 1),
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SmoothStarRating(
                      allowHalfRating: true,
                      onRated: (v) {
                        // DatabaseService().updateRating(uid: auth.uid, id: args.recipe.id, rating: v);
                        // DatabaseService().getRating(uid: auth.uid, id: args.recipe.id).then((value) {
                        //   setState(() {
                        //     ratingUser = value;
                        //   });
                        // });
                      },
                      starCount: 5,
                      rating: 0,
                      size: 40.0,
                      filledIconData: Icons.star,
                      halfFilledIconData: Icons.star_half,
                      color: Colors.green[800],
                      borderColor: Colors.black54,
                      spacing: 0.0),
                ),
              ),
              if (args.value == null)
                TextButton(
                    onPressed: () => model.bugReport(context, args.recipe),
                    child: Text(
                      'bug_report'.tr(),
                      style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
                    )),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text('ingredients'.tr() + ":", style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      CustomListView(
                        list: args.recipe.ingredients,
                        type: EnumTileType.ingredient,
                        // onPressed: (element) => context.read(providerRecipeCreateViewModel).onPressed(context, element),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text('description'.tr() + ":", style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Text(args.recipe.description),
                    ],
                  ),
                ),
              ),
              nutritional(recipe: args.recipe),
              SizedBox(height: 100),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => model.submit(context: context, recipe: args.recipe),
          child: _buildIcon(context),
        ),
      );
    });
  }
}
