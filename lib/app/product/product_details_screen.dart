import 'package:auto_size_text/auto_size_text.dart';
import 'package:fitable/app/favorite/models/favorite_model.dart';
import 'package:fitable/app/home/widgets/macro_aggregation.dart';
import 'package:fitable/app/meal/models/meal_model.dart';
import 'package:fitable/app/product/models/product_model.dart';
import 'package:fitable/app/product/view_models/product_details_view_model.dart';
import 'package:fitable/app/product/widget/nutritional.dart';
import 'package:fitable/common_widgets/custom_drop_down_button.dart';
import 'package:fitable/common_widgets/custom_scaffold.dart';
import 'package:fitable/common_widgets/custom_text_field.dart';
import 'package:fitable/services/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

enum DetailsType { product, meal, return_value }

class ProductDetailsScreenArguments {
  final Product product;
  final MealType mealType;
  final Meal meal;

  ProductDetailsScreenArguments({this.product, this.mealType, this.meal});
}

_buildFloatingActionButton(BuildContext context) {
  final ProductDetailsScreenArguments args = ModalRoute.of(context).settings.arguments;
  final model = context.read(providerProductDetailsViewModel);

  if (args.meal != null) {
    return FloatingActionButton(
      onPressed: () => model.submit(context: context, meal: args.meal, mealType: args.mealType),
      child: Icon(Icons.edit, color: Colors.white),
    );
  } else {
    return FloatingActionButton(
      onPressed: () => model.submit(context: context, product: args.product, mealType: args.mealType),
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
      final model = watch(providerProductDetailsViewModel);
      watch(providerFavorite).whenData((favorites) => model.build(args.product, args.meal, favorites));

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
                meal: args.meal,
              )),
              Row(
                children: [
                  Container(
                    width: 150,
                    child: CustomTextField(
                      keyboardType: TextInputType.number,
                      hintText: args?.meal?.portionSize?.toString() ?? '100',
                      onChanged: (v) {
                        model.portionSize = double.tryParse(v);
                      },
                    ),
                  ),
                  Expanded(
                      child: CustomDropDownButton(
                          name: '',
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
              if (args.meal == null)
                FlatButton(
                    onPressed: () => model.bugReport(context, args.product),
                    child: Text(
                      'bug_report'.tr(),
                      style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
                    )),
              nutritional(product: args.product, recipe: null, meal: args.meal)
            ],
          ),
        ),
        floatingActionButton: _buildFloatingActionButton(context),
      );
    });
  }
}