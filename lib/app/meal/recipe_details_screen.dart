import 'package:fitable/app/account/models/account_model.dart';
import 'package:fitable/app/meal/models/ingredient_model.dart';
import 'package:fitable/common_widgets/build_show_dialog.dart';
import 'package:fitable/common_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:fitable/app/meal/models/portion_model.dart';
import 'package:fitable/app/meal/models/recipe_model.dart';

import 'package:fitable/app/favorite/models/favorite_model.dart';
import 'package:fitable/app/home/widgets/macro_aggregation.dart';
import 'package:fitable/app/issue/issue_report.dart';
import 'package:fitable/app/meal/view_models/recipe_details_view_model.dart';
import 'package:fitable/app/meal/widgets/build_choose_meal_type.dart';
import 'package:fitable/app/meal/widgets/build_icon.dart';
import 'package:fitable/app/meal/widgets/build_title.dart';
import 'package:fitable/common_widgets/carousel/carousel.dart';
import 'package:fitable/app/meal/widgets/nutritional.dart';
import 'package:fitable/app/rating/vew_models/rating_view_model.dart';
import 'package:fitable/common_widgets/custom_drop_down_button.dart';
import 'package:fitable/common_widgets/custom_list_view.dart';
import 'package:fitable/common_widgets/custom_text_field.dart';
import 'package:fitable/utilities/languages.dart';
import 'package:fitable/utilities/enums.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:fitable/utilities/providers.dart';

class RecipeDetailsScreenArguments {
  final Ingredient element;
  final bool chooseMealType;
  final bool isMeal;

  RecipeDetailsScreenArguments({@required this.element, this.chooseMealType = false, this.isMeal = false});
}

_areYouSure(BuildContext context, Recipe recipe) {
  buildShowDialog(
      context: context,
      height: 138,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(Languages.are_you_sure_delete_recipe()),
          Row(
            children: [
              Expanded(
                  child: CustomButton(
                child: Text(Languages.no()),
                color: Colors.indigo,
                textColor: Colors.white,
                onPressed: () => Navigator.pop(context),
              )),
              SizedBox(width: 10),
              Expanded(
                child: CustomButton(
                    child: Text(Languages.yes()),
                    color: Colors.indigo,
                    textColor: Colors.white,
                    onPressed: () => context.read(providerRecipeDetailsViewModel).deleteRecipe(context, recipe)),
              ),
            ],
          ),
        ],
      ));
}

Widget _buildReportButton({@required Recipe recipe, @required bool isMeal}) {
  return Consumer(builder: (context, watch, child) {
    return watch(providerAccount).when(
      data: (account) {
        if (!isMeal && account.uid != recipe.uid)
          return TextButton(
              onPressed: () => issueReport(context, recipe, TypeElement.recipe),
              child: Text(
                Languages.bug_report(),
                style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
              ));

        if (!isMeal && account.uid == recipe.uid)
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () => context.read(providerRecipeDetailsViewModel).editRecipe(context, recipe),
                  child: Text(
                    Languages.edit(),
                    style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
                  )),
              TextButton(
                  onPressed: () => _areYouSure(context, recipe),
                  child: Text(
                    Languages.delete_recipe(),
                    style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
                  )),
            ],
          );

        return Container();
      },
      loading: () => Container(),
      error: (e, v) => Container(),
    );
  });
}

class RecipeDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final RecipeDetailsScreenArguments args = ModalRoute.of(context).settings.arguments;

      final model = watch(providerRecipeDetailsViewModel);
      watch(providerFavorite).whenData((favorites) => model.init(args.element, favorites));

      // if (model.createScreen)
      //   return Scaffold(
      //     body: Center(
      //       child: Container(height: 100, width: 100, child: CircularProgressIndicator()),
      //     ),
      //   );

      return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: model.isFavorite ? Icon(FontAwesomeIcons.solidHeart) : Icon(FontAwesomeIcons.heart),
              onPressed: () => context.read(providerRecipeDetailsViewModel).submitFavorite(context, args.element.getId()),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Carousel(
                photosUrl: args.element.recipe.photosUrl,
                videoUrl: args.element.recipe.videoUrl,
                isShow: !args.isMeal,
              ),
              buildTitle(context),
              Card(
                  child: MacroAggregation(
                calories: model.calories,
                proteins: model.proteins,
                carbs: model.carbs,
                fats: model.fats,
                ingredients: args.element.recipe.ingredients,
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
                          list: args.element.getPortionsStrings(),
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
                        Text(Languages.key_words() + ":", style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(
                          args.element.getKeyWords().toString().substring(1, args.element.getKeyWords().toString().length - 1),
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
                        onRated: (value) => context.read(providerRatingViewModel).setRating(context, args.element.getId(), value),
                        starCount: 5,
                        rating: args.element.recipe.ratingsAvg,
                        size: 40.0,
                        defaultIconData: FontAwesomeIcons.star,
                        filledIconData: FontAwesomeIcons.solidStar,
                        halfFilledIconData: FontAwesomeIcons.starHalfAlt,
                        color: Colors.indigo,
                        borderColor: Colors.black54,
                        spacing: 8.0),
                  ),
                ),
              _buildReportButton(recipe: args.element.recipe, isMeal: args.isMeal),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(Languages.ingredients() + ":", style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      CustomListView(
                        list: args.element.recipe.ingredients,
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
                        child: Text(Languages.description() + ":", style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Text(args.element.recipe.description),
                    ],
                  ),
                ),
              ),
              nutritional(element: args.element.recipe),
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
