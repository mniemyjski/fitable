import 'package:fitable/app/recipe/recipe_details_screen.dart';
import 'package:flutter/material.dart';

Icon buildIcon(BuildContext context) {
  final RecipeDetailsScreenArguments args = ModalRoute.of(context).settings.arguments;
  if (args.isMeal) {
    return Icon(Icons.edit, color: Colors.white);
  } else {
    return Icon(Icons.add, color: Colors.white);
  }
}
