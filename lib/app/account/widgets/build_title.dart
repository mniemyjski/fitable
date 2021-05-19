import 'package:fitable/app/account/widgets/tile_account.dart';
import 'package:fitable/app/meal/widgets/tile_product.dart';
import 'package:fitable/utilities/languages.dart';
import 'package:fitable/utilities/enums.dart';
import 'package:flutter/material.dart';

Widget getTitleType(TypeSearch searchType, dynamic data) {
  switch (searchType) {
    case TypeSearch.recipes:
      return Container(margin: EdgeInsets.only(left: 5, right: 5), child: TileProduct(element: data));
      break;
    case TypeSearch.products:
      return Container(margin: EdgeInsets.only(left: 5, right: 5), child: TileProduct(element: data));
      break;
    case TypeSearch.accounts:
      return Container(margin: EdgeInsets.only(left: 5, right: 5), child: TileAccount(data));
      break;
    case TypeSearch.workouts:
      return Text(data.name);
      break;
    default:
      return Text(Languages.error());
  }
}
