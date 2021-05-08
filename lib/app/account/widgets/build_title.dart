import 'package:fitable/app/account/widgets/tile_account.dart';
import 'package:fitable/app/meal/widgets/tile_product.dart';
import 'package:fitable/utilities/languages.dart';
import 'package:fitable/utilities/enums.dart';
import 'package:flutter/material.dart';

Widget getTitleType(SearchType searchType, dynamic data) {
  print(data);
  switch (searchType) {
    case SearchType.recipes:
      return Container(margin: EdgeInsets.only(left: 5, right: 5), child: TileProduct(element: data));
      break;
    case SearchType.products:
      return Container(margin: EdgeInsets.only(left: 5, right: 5), child: TileProduct(element: data));
      break;
    case SearchType.accounts:
      return Container(margin: EdgeInsets.only(left: 5, right: 5), child: TileAccount(data));
      break;
    case SearchType.workouts:
      return Text(data.name);
      break;
    default:
      return Text(Languages.error());
  }
}
