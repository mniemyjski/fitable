import 'package:fitable/app/home/widgets/tile_expansion.dart';
import 'package:fitable/app/product/models/ingredient_model.dart';
import 'package:fitable/app/product/models/product_model.dart';
import 'package:fitable/app/recipe/view_models/recipe_create_view_model.dart';
import 'package:fitable/common_widgets/custom_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';

class TileHeadIngredients extends StatelessWidget {
  _buildHead() {
    return Consumer(builder: (context, watch, child) {
      final model = watch(providerRecipeCreateViewModel);
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            child: Text('products'.tr(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
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

  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final model = watch(providerRecipeCreateViewModel);
      return TileExpansion(
          head: _buildHead(),
          onPressed: () => context.read(providerRecipeCreateViewModel).onSearch(context),
          listView: CustomListView(
            list: model.ingredients,
            type: EnumTileType.ingredient,
            onDismissed: (element) => context.read(providerRecipeCreateViewModel).onDismissed(context, element),
            onPressed: (element) => context.read(providerRecipeCreateViewModel).onPressed(context, element),
          ));
    });
  }
}
