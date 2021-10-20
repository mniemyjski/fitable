import 'package:easy_localization/easy_localization.dart';
import 'package:fitable/app/home/view_models/app_view_model.dart';
import 'package:fitable/app/home/view_models/home_view_model.dart';
import 'package:fitable/app/home/widgets/tile_expansion.dart';
import 'package:fitable/models/meal_model.dart';
import 'package:fitable/common_widgets/custom_list_view.dart';
import 'package:fitable/services/services.dart';
import 'package:fitable/utilities/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TileHeadMeals extends StatelessWidget {
  final ETypeMeal mealType;

  const TileHeadMeals({Key key, @required this.mealType}) : super(key: key);

  _buildHead(List<Meal> meals) {
    return Consumer(builder: (context, watch, child) {
      int _calories = 0;
      double _proteins = 0;
      double _carbs = 0;
      double _fats = 0;

      meals.forEach((element) {
        _calories += element.getCalories();
        _proteins += element.getProteins();
        _carbs += element.getCarbs();
        _fats += element.getFats();
      });

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            child: Text(Enums.toText(mealType).tr(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          ),
          SizedBox(height: 5),
          Row(
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
                    Text('kcal'.tr() + ':', style: TextStyle(fontSize: 12)),
                    SizedBox(width: 2),
                    Text(_calories.toString(), style: TextStyle(fontSize: 12)),
                  ])),
              Expanded(
                  flex: 1,
                  child: Row(children: <Widget>[
                    Text('p'.tr() + ':', style: TextStyle(fontSize: 12)),
                    SizedBox(width: 2),
                    Text('${_proteins.toStringAsFixed(1)}g', style: TextStyle(fontSize: 12)),
                  ])),
              Expanded(
                  flex: 1,
                  child: Row(children: <Widget>[
                    Text('c'.tr() + ':', style: TextStyle(fontSize: 12)),
                    SizedBox(width: 2),
                    Text('${_carbs.toStringAsFixed(1)}g', style: TextStyle(fontSize: 12)),
                  ])),
              Expanded(
                  flex: 1,
                  child: Row(children: <Widget>[
                    Text('f'.tr() + ':', style: TextStyle(fontSize: 12)),
                    SizedBox(width: 2),
                    Text('${_fats.toStringAsFixed(1)}g', style: TextStyle(fontSize: 12)),
                  ])),
            ],
          ),
        ],
      );
    });
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
              onPressed: () => context.read(providerHomeViewModel).onSearch(context, mealType),
              listView: CustomListView(
                list: _list,
                type: EnumTileType.meal,
                onDismissed: (element) => context.read(providerHomeViewModel).onDismissed(context, element),
                onPressed: (element) => context.read(providerHomeViewModel).onPressed(context, element, mealType),
              ));
        },
        loading: () => Center(child: Container(height: 100, width: 100, child: CircularProgressIndicator())),
        error: (err, stack) => Center(child: Text('Error: $err')),
      );
    });
  }
}
