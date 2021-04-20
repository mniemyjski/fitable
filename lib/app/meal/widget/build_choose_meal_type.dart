import 'package:fitable/app/meal/recipe_details_screen.dart';
import 'package:fitable/app/meal/view_models/recipe_details_view_model.dart';
import 'package:fitable/common_widgets/custom_drop_down_button.dart';
import 'package:fitable/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

buildChooseMealType(BuildContext context) {
  final RecipeDetailsScreenArguments args = ModalRoute.of(context).settings.arguments;

  if (args.chooseMealType)
    return Consumer(builder: (context, watch, child) {
      final model = watch(providerRecipeDetailsViewModel);
      return CustomDropDownButton(
        name: Constants.meal_type(),
        value: model.getMealTypeString(),
        list: model.listMealType,
        onChanged: (v) {
          model.chooseMealType(v);
        },
      );
    });

  return Container();
}
