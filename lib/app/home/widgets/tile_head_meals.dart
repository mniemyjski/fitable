import 'package:easy_localization/easy_localization.dart';
import 'package:fitable/app/home/view_models/app_view_model.dart';
import 'package:fitable/app/home/view_models/home_view_model.dart';
import 'package:fitable/app/home/widgets/tile_expansion.dart';
import 'package:fitable/app/meal/models/meal_model.dart';
import 'package:fitable/app/product/product_details_screen.dart';
import 'package:fitable/app/search/search_screen.dart';
import 'package:fitable/common_widgets/custom_list_view.dart';
import 'package:fitable/routers/route_generator.dart';
import 'package:fitable/services/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TileHeadMeals extends StatelessWidget {
  final MealType mealType;

  const TileHeadMeals({Key key, @required this.mealType}) : super(key: key);

  _buildHead(List<Meal> list) {
    return Consumer(builder: (context, watch, child) {
      final model = watch(providerHomeViewModel);
      model.mealList = list;

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            child: Text(Meal.toText(mealType).tr(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          ),
          SizedBox(height: 5),
          Row(
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
                    Text('kcal'.tr() + ':', style: TextStyle(fontSize: 12)),
                    SizedBox(width: 2),
                    Text(model.calories.toString(), style: TextStyle(fontSize: 12)),
                  ])),
              Expanded(
                  flex: 1,
                  child: Row(children: <Widget>[
                    Text('p'.tr() + ':', style: TextStyle(fontSize: 12)),
                    SizedBox(width: 2),
                    Text('${model.proteins.toStringAsFixed(1)}g', style: TextStyle(fontSize: 12)),
                  ])),
              Expanded(
                  flex: 1,
                  child: Row(children: <Widget>[
                    Text('c'.tr() + ':', style: TextStyle(fontSize: 12)),
                    SizedBox(width: 2),
                    Text('${model.carbs.toStringAsFixed(1)}g', style: TextStyle(fontSize: 12)),
                  ])),
              Expanded(
                  flex: 1,
                  child: Row(children: <Widget>[
                    Text('f'.tr() + ':', style: TextStyle(fontSize: 12)),
                    SizedBox(width: 2),
                    Text('${model.fats.toStringAsFixed(1)}g', style: TextStyle(fontSize: 12)),
                  ])),
            ],
          ),
        ],
      );
    });
  }

  _onPressed(BuildContext context, dynamic element) {
    Navigator.of(context).pushNamed(AppRoute.productDetailsScreen,
        arguments: ProductDetailsScreenArguments(
          meal: element,
          mealType: mealType,
        ));
  }

  _onDismissed(BuildContext context, dynamic element) {
    context.read(providerDatabase).deleteMeal(element);
  }

  _onSearch(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoute.searchScreen, arguments: SearchScreenArguments(typeSearch: SearchType.allFoods, mealType: mealType));
  }

  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final meals = watch(providerMeals);
      final app = watch(providerAppViewModel);

      return meals.when(
        data: (data) {
          List _list = data.where((element) => element.mealType == mealType && element.dateTime == app.chosenDate).toList();
          _list.sort((a, b) => a.dateCreation.compareTo(b.dateCreation));

          return TileExpansion(
              head: _buildHead(_list),
              onPressed: () => _onSearch(context),
              listView: CustomListView(
                list: _list,
                type: EnumTileType.meal,
                onDismissed: (element) => _onDismissed(context, element),
                onPressed: (element) => _onPressed(context, element),
              ));
        },
        loading: () => Center(child: Container(height: 100, width: 100, child: CircularProgressIndicator())),
        error: (err, stack) => Center(child: Text('Error: $err')),
      );
    });
  }
}
