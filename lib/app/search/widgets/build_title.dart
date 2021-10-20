import 'package:fitable/app/account/widgets/tile_account.dart';
import 'package:fitable/app/meal/widgets/tile_product.dart';
import 'package:fitable/models/ingredient_model.dart';
import 'package:fitable/utilities/languages.dart';
import 'package:fitable/utilities/enums.dart';
import 'package:flutter/material.dart';

Widget getTitleType(ETypeSearch searchType, dynamic data) {
  switch (searchType) {
    case ETypeSearch.recipes:
      return Container(margin: EdgeInsets.only(left: 5, right: 5), child: TileProduct(element: Ingredient.transform(data)));
      break;
    case ETypeSearch.products:
      return Container(margin: EdgeInsets.only(left: 5, right: 5), child: TileProduct(element: Ingredient.transform(data)));
      break;
    case ETypeSearch.accounts:
      return Container(margin: EdgeInsets.only(left: 5, right: 5), child: TileAccount(data));
      break;
    case ETypeSearch.workouts:
      return Text(data.name);
      break;
    default:
      return Text(Languages.error());
  }
}
