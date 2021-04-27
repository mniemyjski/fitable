import 'package:fitable/app/favorite/models/favorite_model.dart';
import 'package:fitable/app/home/widgets/macro_aggregation.dart';
import 'package:fitable/app/issue/issue_report.dart';
import 'package:fitable/app/meal/models/portion_model.dart';
import 'package:fitable/app/meal/models/recipe_model.dart';
import 'package:fitable/app/meal/view_models/recipe_details_view_model.dart';
import 'package:fitable/app/meal/widgets/build_choose_meal_type.dart';
import 'package:fitable/app/meal/widgets/build_icon.dart';
import 'package:fitable/app/meal/widgets/build_title.dart';
import 'package:fitable/app/media/widgets/image_slider.dart';
import 'package:fitable/app/meal/widgets/nutritional.dart';
import 'package:fitable/app/rating/vew_models/rating_view_model.dart';
import 'package:fitable/common_widgets/custom_drop_down_button.dart';
import 'package:fitable/common_widgets/custom_list_view.dart';
import 'package:fitable/common_widgets/custom_scaffold.dart';
import 'package:fitable/common_widgets/custom_text_field.dart';
import 'package:fitable/constants/constants.dart';
import 'package:fitable/constants/enums.dart';
import 'package:fitable/services/macro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class RecipeDetailsScreenArguments {
  final Recipe recipe;
  final Portion selectedPortion;
  final bool chooseMealType;
  final bool isMeal;

  RecipeDetailsScreenArguments({@required this.recipe, this.selectedPortion, this.chooseMealType = false, this.isMeal = false});
}

class RecipeDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final RecipeDetailsScreenArguments args = ModalRoute.of(context).settings.arguments;

      final model = watch(providerRecipeDetailsViewModel);
      watch(providerFavorite).whenData((favorites) => model.build(args.recipe, favorites));

      if (model.createScreen)
        return Scaffold(
          body: Center(
            child: Container(height: 100, width: 100, child: CircularProgressIndicator()),
          ),
        );

      return CustomScaffold(
        appBar: AppBar(
          title: Text(Constants.recipe_details()),
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
              ImageSlider(photosUrl: args.recipe.photosUrl, videoUrl: args.recipe.videoUrl, edit: false),
              buildTitle(context),
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
                      hintText: model.sizeListener.toString(),
                      onChanged: (v) => model.sizeListener = double.tryParse(v),
                    ),
                  ),
                  Expanded(
                      child: CustomDropDownButton(
                          name: '',
                          value: model.selectedPortion.name,
                          list: Macro.getPortionsStrings(args.recipe),
                          onChanged: (v) => model.setSelectedPortion(v)))
                ],
              ),
              buildChooseMealType(context),
              if (!args.isMeal)
                Card(
                  child: Container(
                    padding: EdgeInsets.all(4),
                    width: double.infinity,
                    // child: Center(child: Text(model.name)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(Constants.key_words() + ":", style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(
                          args.recipe.keyWords.toString().substring(1, args.recipe.keyWords.toString().length - 1),
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  ),
                ),
              if (!args.isMeal)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SmoothStarRating(
                        allowHalfRating: true,
                        onRated: (value) => context.read(providerRatingViewModel).setRating(context, args.recipe.id, value),
                        starCount: 5,
                        rating: args.recipe.ratingsAvg,
                        size: 40.0,
                        defaultIconData: FontAwesomeIcons.star,
                        filledIconData: FontAwesomeIcons.solidStar,
                        halfFilledIconData: FontAwesomeIcons.starHalfAlt,
                        color: Colors.indigo,
                        borderColor: Colors.black54,
                        spacing: 8.0),
                  ),
                ),
              if (!args.isMeal)
                TextButton(
                    onPressed: () => issueReport(context, args.recipe, ElementType.recipe),
                    child: Text(
                      Constants.bug_report(),
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
                        child: Text(Constants.ingredients() + ":", style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      CustomListView(
                        list: args.recipe.ingredients,
                        type: EnumTileType.ingredient,
                        onPressed: (ingredient) => context.read(providerRecipeDetailsViewModel).seeProduct(
                              context,
                              ingredient,
                            ),
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
                        child: Text(Constants.description() + ":", style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Text(args.recipe.description),
                    ],
                  ),
                ),
              ),
              nutritional(element: args.recipe),
              SizedBox(height: 100),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => model.submit(context: context),
          child: buildIcon(context),
        ),
      );
    });
  }
}
