import 'package:auto_size_text/auto_size_text.dart';
import 'package:fitable/app/favorite/models/favorite_model.dart';
import 'package:fitable/app/home/widgets/macro_aggregation.dart';
import 'package:fitable/app/issue/issue_report.dart';
import 'package:fitable/app/meal/models/ingredient_model.dart';
import 'package:fitable/app/meal/models/product_model.dart';
import 'package:fitable/app/meal/view_models/product_details_view_model.dart';
import 'package:fitable/app/meal/widgets/nutritional.dart';
import 'package:fitable/common_widgets/custom_drop_down_button.dart';
import 'package:fitable/common_widgets/custom_text_field.dart';
import 'package:fitable/utilities/languages.dart';
import 'package:fitable/utilities/enums.dart';
import 'package:fitable/utilities/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

class ProductDetailsScreenArguments {
  final Ingredient element;
  final bool edit;
  final bool isMeal;

  ProductDetailsScreenArguments({@required this.element, this.edit = true, this.isMeal = false});
}

_buildFloatingActionButton(BuildContext context) {
  final ProductDetailsScreenArguments args = ModalRoute.of(context).settings.arguments;

  if (!args.edit) return null;

  if (args.isMeal) {
    return FloatingActionButton(
      onPressed: () => context.read(providerProductDetailsViewModel).submit(context: context),
      child: Icon(Icons.edit, color: Colors.white),
    );
  } else {
    return FloatingActionButton(
      onPressed: () => context.read(providerProductDetailsViewModel).submit(context: context),
      child: Icon(Icons.add, color: Colors.white),
    );
  }
}

_submitFavorite(BuildContext context) {
  final ProductDetailsScreenArguments args = ModalRoute.of(context).settings.arguments;

  Favorite _favorite = Favorite(type: EnumFavorite.products, id: args.element.getId());
  context.read(providerDatabase).updateFavorite(context, _favorite);
}

class ProductDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final ProductDetailsScreenArguments args = ModalRoute.of(context).settings.arguments;

      final model = watch(providerProductDetailsViewModel);
      watch(providerFavorite).whenData((favorites) => model.init(args.element, favorites));

      if (model.createScreen)
        return Scaffold(
          body: Center(
            child: Container(height: 100, width: 100, child: CircularProgressIndicator()),
          ),
        );

      return Scaffold(
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
                    args.element.getName(),
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
                ingredients: model.isIngredient(),
              )),
              Row(
                children: [
                  Container(
                    width: 150,
                    child: CustomTextField(
                      enabled: args.edit,
                      keyboardType: TextInputType.number,
                      hintText: args.element.size.toString(),
                      onChanged: (v) => model.sizeListener = double.tryParse(v),
                    ),
                  ),
                  Expanded(
                      child: CustomDropDownButton(
                          name: '',
                          enabled: args.edit,
                          value: model.selectedPortion.name,
                          list: args.element.getPortionsStrings(),
                          onChanged: (v) => model.selectedPortion = args.element.getPortions().firstWhere((element) => element.name == v)))
                ],
              ),
              Card(
                child: Container(
                  padding: EdgeInsets.all(4),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(Languages.key_words() + ":", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(
                        args.element.getKeyWords().toString().substring(1, args.element.getKeyWords().toString().length - 1),
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),
              ),
              if (!args.isMeal)
                TextButton(
                    onPressed: () => issueReport(context, args.element, ElementType.product),
                    child: Text(
                      Languages.bug_report(),
                      style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
                    )),
              // nutritional(element: Macro.getProduct(args.element))
            ],
          ),
        ),
        floatingActionButton: _buildFloatingActionButton(context),
      );
    });
  }
}
