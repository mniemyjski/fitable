import 'package:auto_size_text/auto_size_text.dart';
import 'package:fitable/app/favorite/models/favorite_model.dart';
import 'package:fitable/app/home/widgets/macro_aggregation.dart';
import 'package:fitable/app/meal/models/ingredient_model.dart';
import 'package:fitable/app/meal/models/product_model.dart';
import 'package:fitable/app/meal/view_models/product_details_view_model.dart';
import 'package:fitable/app/meal/widget/nutritional.dart';

import 'package:fitable/common_widgets/custom_drop_down_button.dart';
import 'package:fitable/common_widgets/custom_scaffold.dart';
import 'package:fitable/common_widgets/custom_text_field.dart';
import 'package:fitable/services/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

class ProductDetailsScreenArguments {
  final Product product;
  final Ingredient ingredient;
  final bool edit;
  final bool isMeal;

  ProductDetailsScreenArguments({this.product, this.ingredient, this.edit = true, this.isMeal = false});
}

_buildFloatingActionButton(BuildContext context) {
  final ProductDetailsScreenArguments args = ModalRoute.of(context).settings.arguments;
  Product _product = args?.product ?? args.ingredient.product;

  if (!args.edit) return null;

  if (args.ingredient != null) {
    return FloatingActionButton(
      onPressed: () => context.read(providerProductDetailsViewModel).submit(context: context, product: _product),
      child: Icon(Icons.edit, color: Colors.white),
    );
  } else {
    return FloatingActionButton(
      onPressed: () => context.read(providerProductDetailsViewModel).submit(context: context, product: _product),
      child: Icon(Icons.add, color: Colors.white),
    );
  }
}

_submitFavorite(BuildContext context) {
  final model = context.read(providerProductDetailsViewModel);
  Favorite _favorite = Favorite(type: EnumFavorite.products, id: model.id);
  context.read(providerDatabase).updateFavorite(context, _favorite);
}

class ProductDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final ProductDetailsScreenArguments args = ModalRoute.of(context).settings.arguments;
      Product _product = args?.product ?? args.ingredient.product;

      final model = watch(providerProductDetailsViewModel);
      watch(providerFavorite).whenData((favorites) => model.build(args.product, args.ingredient, favorites));

      if (model.createScreen)
        return Scaffold(
          body: Center(
            child: Container(height: 100, width: 100, child: CircularProgressIndicator()),
          ),
        );

      return CustomScaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: model.isFavorite ? Icon(FontAwesomeIcons.solidHeart) : Icon(FontAwesomeIcons.heart),
              onPressed: () => _submitFavorite(context),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                child: Container(
                  height: 55,
                  width: double.infinity,
                  child: Center(
                      child: AutoSizeText(
                    model.name,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    maxLines: 1,
                  )),
                ),
              ),
              Card(
                  child: MacroAggregation(
                calories: model.calories,
                proteins: model.proteins,
                carbs: model.carbs,
                fats: model.fats,
                ingredients: args.ingredient?.toList() ?? null,
              )),
              Row(
                children: [
                  Container(
                    width: 150,
                    child: CustomTextField(
                      enabled: args.edit,
                      keyboardType: TextInputType.number,
                      hintText: args?.ingredient?.portionSize?.toString() ?? '100',
                      onChanged: (v) {
                        model.portionSize = double.tryParse(v);
                      },
                    ),
                  ),
                  Expanded(
                      child: CustomDropDownButton(
                          name: '',
                          enabled: args.edit,
                          value: model.portionChosen,
                          list: model.portions.keys.toList(),
                          onChanged: (v) {
                            model.portionChosen = v;
                          }))
                ],
              ),
              Card(
                child: Container(
                  padding: EdgeInsets.all(4),
                  width: double.infinity,
                  // child: Center(child: Text(model.name)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("key_words".tr() + ":", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(
                        model.keyWords.toString().substring(1, model.keyWords.toString().length - 1),
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),
              ),
              if (args.ingredient == null)
                TextButton(
                    onPressed: () => model.bugReport(context, args.product),
                    child: Text(
                      'bug_report'.tr(),
                      style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
                    )),
              nutritional(product: _product, recipe: null)
            ],
          ),
        ),
        floatingActionButton: _buildFloatingActionButton(context),
      );
    });
  }
}
