import 'package:fitable/app/meal/models/product_model.dart';
import 'package:fitable/app/meal/view_models/product_create_view_model.dart';
import 'package:fitable/app/meal/widgets/barcode_text.dart';
import 'package:fitable/common_widgets/custom_bar_list.dart';
import 'package:fitable/common_widgets/custom_drop_down_button.dart';
import 'package:fitable/common_widgets/custom_scaffold.dart';
import 'package:fitable/common_widgets/custom_text_field.dart';
import 'package:fitable/utilities/languages.dart';
import 'package:fitable/utilities/enums.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductCreateScreenArguments {
  final String barcode;
  final Product product;

  ProductCreateScreenArguments({
    this.barcode,
    this.product,
  });
}

class ProductCreateScreen extends StatefulWidget {
  @override
  _ProductCreateScreenState createState() => _ProductCreateScreenState();
}

class _ProductCreateScreenState extends State<ProductCreateScreen> {
  @override
  void didChangeDependencies() {
    final ProductCreateScreenArguments args = ModalRoute.of(context).settings.arguments;
    final model = context.read(providerProductCreateViewModel);
    model.initState(args.product, args.barcode);
    super.didChangeDependencies();
  }

  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final model = watch(providerProductCreateViewModel);
      return CustomScaffold(
        appBar: AppBar(actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () => context.read(providerProductCreateViewModel).save(context),
          ),
        ]),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (model.barcode != null) BarcodeText(model.barcode),
                CustomTextField(
                    name: Languages.product_name(),
                    initialValue: model.productName,
                    suffix: "",
                    textColor: model.productNameColor,
                    onChanged: (v) => model.productName = v),
                CustomDropDownButton(
                    name: Languages.category_primary(),
                    value: model.categoryPrimary,
                    list: model.listPrimary,
                    onChanged: (v) => model.categoryPrimary = v),
                if (model.listSecondary.isNotEmpty)
                  CustomDropDownButton(
                      name: Languages.category_secondary(),
                      value: model.categorySecondary,
                      list: model.listSecondary,
                      onChanged: (v) => model.categorySecondary = v),
                CustomBarList(
                    name: Languages.key_words(),
                    value: model.keyWords.toString().substring(1, model.keyWords.toString().length - 1),
                    onPressed: () => context.read(providerProductCreateViewModel).submitKeyWords(context)),
                Container(
                    margin: EdgeInsets.only(left: 5, top: 15),
                    width: double.infinity,
                    child: Text(
                      Languages.nutritional_values_out_of_100() + ':',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                          name: Languages.calories(),
                          suffix: "kcal",
                          initialValue: model.calories.toString(),
                          textColor: model.caloriesColor,
                          keyboardType: TextInputType.number,
                          onChanged: (v) => model.calories = int.tryParse(v)),
                    ),
                    Expanded(
                      child: CustomDropDownButton(
                        name: Languages.unit(),
                        value: Enums.toText(model.unit),
                        list: <String>['g', 'ml'],
                        onChanged: (v) => model.unit = Enums.unitTypeToEnum(v),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: CustomTextField(
                            name: Languages.proteins(),
                            suffix: "g",
                            initialValue: model.proteins.toString(),
                            textColor: model.proteinsColor,
                            keyboardType: TextInputType.number,
                            onChanged: (v) {
                              model.proteins = double.tryParse(v);
                            })),
                    Expanded(
                        child: CustomTextField(
                            name: Languages.carbs(),
                            suffix: "g",
                            initialValue: model.carbs.toString(),
                            textColor: model.carbsColor,
                            keyboardType: TextInputType.number,
                            onChanged: (v) {
                              model.carbs = double.tryParse(v);
                            })),
                    Expanded(
                        child: CustomTextField(
                            name: Languages.fats(),
                            suffix: "g",
                            initialValue: model.fats.toString(),
                            textColor: model.fatsColor,
                            keyboardType: TextInputType.number,
                            onChanged: (v) => model.fats = double.tryParse(v))),
                  ],
                ),
                CustomBarList(
                    name: Languages.portions(),
                    value: model.portionsTXT(),
                    onPressed: () => context.read(providerProductCreateViewModel).submitPortions(context)),
                ExpansionTile(
                  title: Center(
                    child: Text(
                      Languages.more_about_the_product(),
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: 5),
                        width: double.infinity,
                        child: Text(
                          Languages.fats() + ':',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                    Row(
                      children: [
                        Expanded(
                            child: CustomTextField(
                                name: Languages.saturated(),
                                suffix: "g",
                                initialValue: model.saturated.toString(),
                                textColor: model.saturatedColor,
                                keyboardType: TextInputType.number,
                                onChanged: (v) {
                                  model.saturated = double.tryParse(v);
                                })),
                        Expanded(
                            child: CustomTextField(
                                name: Languages.unsaturated(),
                                suffix: "g",
                                initialValue: model.unsaturated.toString(),
                                textColor: model.unsaturatedColor,
                                keyboardType: TextInputType.number,
                                onChanged: (v) {
                                  model.unsaturated = double.tryParse(v);
                                })),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: CustomTextField(
                                name: Languages.omega3(),
                                suffix: "g",
                                initialValue: model.omega3.toString(),
                                textColor: model.omega3Color,
                                keyboardType: TextInputType.number,
                                onChanged: (v) {
                                  model.omega3 = double.tryParse(v);
                                })),
                        Expanded(
                            child: CustomTextField(
                                name: Languages.omega6(),
                                suffix: "g",
                                initialValue: model.omega6.toString(),
                                textColor: model.omega6Color,
                                keyboardType: TextInputType.number,
                                onChanged: (v) {
                                  model.omega6 = double.tryParse(v);
                                })),
                      ],
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 5, top: 15),
                        width: double.infinity,
                        child: Text(
                          Languages.proteins() + ':',
                          style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.bold),
                        )),
                    Row(
                      children: [
                        Expanded(
                            child: CustomTextField(
                                name: Languages.animal_proteins(),
                                keyboardType: TextInputType.number,
                                suffix: "g",
                                initialValue: model.animalProteins.toString(),
                                textColor: model.animalProteinsColor,
                                onChanged: (v) {
                                  model.animalProteins = double.tryParse(v);
                                })),
                        Expanded(
                            child: CustomTextField(
                                name: Languages.plant_proteins(),
                                initialValue: model.plantProteins.toString(),
                                textColor: model.plantProteinsColor,
                                keyboardType: TextInputType.number,
                                suffix: "g",
                                onChanged: (v) {
                                  model.plantProteins = double.tryParse(v);
                                })),
                      ],
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 5, top: 15),
                        width: double.infinity,
                        child: Text(
                          Languages.others() + ':',
                          style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.bold),
                        )),
                    Row(
                      children: [
                        Expanded(
                            child: CustomTextField(
                                name: Languages.fiber(),
                                suffix: "g",
                                initialValue: model.fiber.toString(),
                                textColor: model.fiberColor,
                                keyboardType: TextInputType.number,
                                onChanged: (v) {
                                  model.fiber = double.tryParse(v);
                                })),
                        Expanded(
                            child: CustomTextField(
                                name: Languages.caffeine(),
                                suffix: "g",
                                initialValue: model.caffeine.toString(),
                                textColor: model.caffeineColor,
                                keyboardType: TextInputType.number,
                                onChanged: (v) {
                                  model.caffeine = double.tryParse(v);
                                })),
                        Expanded(
                            child: CustomTextField(
                                name: Languages.sugar(),
                                suffix: "g",
                                initialValue: model.sugar.toString(),
                                textColor: model.sugarColor,
                                keyboardType: TextInputType.number,
                                onChanged: (v) {
                                  model.sugar = double.tryParse(v);
                                })),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: CustomTextField(
                                name: Languages.salt(),
                                suffix: "g",
                                initialValue: model.salt.toString(),
                                textColor: model.saltColor,
                                keyboardType: TextInputType.number,
                                onChanged: (v) {
                                  model.salt = double.tryParse(v);
                                })),
                        Expanded(
                            child: CustomTextField(
                                name: Languages.cholesterol(),
                                suffix: "g",
                                initialValue: model.cholesterol.toString(),
                                textColor: model.cholesterolColor,
                                keyboardType: TextInputType.number,
                                onChanged: (v) {
                                  model.cholesterol = double.tryParse(v);
                                })),
                      ],
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 5, top: 15),
                        width: double.infinity,
                        child: Text(
                          Languages.vitamins() + ':',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                    Row(
                      children: [
                        Expanded(
                            child: CustomTextField(
                                name: Languages.A(),
                                suffix: "mg",
                                initialValue: model.vitaminA.toString(),
                                textColor: model.vitaminAColor,
                                keyboardType: TextInputType.number,
                                onChanged: (v) {
                                  model.vitaminA = double.tryParse(v);
                                })),
                        Expanded(
                            child: CustomTextField(
                                name: Languages.C(),
                                suffix: "mg",
                                initialValue: model.vitaminC.toString(),
                                textColor: model.vitaminCColor,
                                keyboardType: TextInputType.number,
                                onChanged: (v) {
                                  model.vitaminC = double.tryParse(v);
                                })),
                        Expanded(
                            child: CustomTextField(
                                name: Languages.D(),
                                suffix: "mg",
                                initialValue: model.vitaminD.toString(),
                                textColor: model.vitaminDColor,
                                keyboardType: TextInputType.number,
                                onChanged: (v) {
                                  model.vitaminD = double.tryParse(v);
                                })),
                        Expanded(
                            child: CustomTextField(
                                name: Languages.E(),
                                suffix: "mg",
                                initialValue: model.vitaminE.toString(),
                                textColor: model.vitaminEColor,
                                keyboardType: TextInputType.number,
                                onChanged: (v) {
                                  model.vitaminE = double.tryParse(v);
                                })),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: CustomTextField(
                                name: Languages.B1(),
                                suffix: "mg",
                                initialValue: model.vitaminB1.toString(),
                                textColor: model.vitaminB1Color,
                                keyboardType: TextInputType.number,
                                onChanged: (v) {
                                  model.vitaminB1 = double.tryParse(v);
                                })),
                        Expanded(
                            child: CustomTextField(
                                name: Languages.B2(),
                                suffix: "mg",
                                initialValue: model.vitaminB2.toString(),
                                textColor: model.vitaminB2Color,
                                keyboardType: TextInputType.number,
                                onChanged: (v) {
                                  model.vitaminB2 = double.tryParse(v);
                                })),
                        Expanded(
                            child: CustomTextField(
                                name: Languages.B3(),
                                suffix: "mg",
                                initialValue: model.vitaminB3.toString(),
                                textColor: model.vitaminB3Color,
                                keyboardType: TextInputType.number,
                                onChanged: (v) {
                                  model.vitaminB3 = double.tryParse(v);
                                })),
                        Expanded(
                            child: CustomTextField(
                                name: Languages.B5(),
                                suffix: "mg",
                                initialValue: model.vitaminB5.toString(),
                                textColor: model.vitaminB5Color,
                                keyboardType: TextInputType.number,
                                onChanged: (v) {
                                  model.vitaminB5 = double.tryParse(v);
                                })),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: CustomTextField(
                                name: Languages.B6(),
                                suffix: "mg",
                                initialValue: model.vitaminB6.toString(),
                                textColor: model.vitaminB6Color,
                                keyboardType: TextInputType.number,
                                onChanged: (v) {
                                  model.vitaminB6 = double.tryParse(v);
                                })),
                        Expanded(
                            child: CustomTextField(
                                name: Languages.B7(),
                                suffix: "mg",
                                initialValue: model.vitaminB7.toString(),
                                textColor: model.vitaminB7Color,
                                keyboardType: TextInputType.number,
                                onChanged: (v) {
                                  model.vitaminB7 = double.tryParse(v);
                                })),
                        Expanded(
                            child: CustomTextField(
                                name: Languages.B9(),
                                suffix: "mg",
                                initialValue: model.vitaminB9.toString(),
                                textColor: model.vitaminB9Color,
                                keyboardType: TextInputType.number,
                                onChanged: (v) {
                                  model.vitaminB9 = double.tryParse(v);
                                })),
                        Expanded(
                            child: CustomTextField(
                                name: Languages.B12(),
                                suffix: "mg",
                                initialValue: model.vitaminB12.toString(),
                                textColor: model.vitaminB12eColor,
                                keyboardType: TextInputType.number,
                                onChanged: (v) {
                                  model.vitaminB12 = double.tryParse(v);
                                })),
                      ],
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 5, top: 15),
                        width: double.infinity,
                        child: Text(
                          Languages.macro() + ':',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                    Row(
                      children: [
                        Expanded(
                            child: CustomTextField(
                                name: Languages.potassium(),
                                suffix: "mg",
                                initialValue: model.potassium.toString(),
                                textColor: model.potassiumColor,
                                keyboardType: TextInputType.number,
                                onChanged: (v) {
                                  model.potassium = double.tryParse(v);
                                })),
                        Expanded(
                            child: CustomTextField(
                                name: Languages.sodium(),
                                suffix: "mg",
                                initialValue: model.sodium.toString(),
                                textColor: model.sodiumColor,
                                keyboardType: TextInputType.number,
                                onChanged: (v) {
                                  model.sodium = double.tryParse(v);
                                })),
                        Expanded(
                            child: CustomTextField(
                                name: Languages.calcium(),
                                suffix: "mg",
                                initialValue: model.calcium.toString(),
                                textColor: model.calciumColor,
                                keyboardType: TextInputType.number,
                                onChanged: (v) {
                                  model.calcium = double.tryParse(v);
                                })),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: CustomTextField(
                                name: Languages.magnesium(),
                                suffix: "mg",
                                initialValue: model.magnesium.toString(),
                                textColor: model.magnesiumColor,
                                keyboardType: TextInputType.number,
                                onChanged: (v) {
                                  model.magnesium = double.tryParse(v);
                                })),
                        Expanded(
                            child: CustomTextField(
                                name: Languages.phosphorus(),
                                suffix: "mg",
                                initialValue: model.phosphorus.toString(),
                                textColor: model.phosphorusColor,
                                keyboardType: TextInputType.number,
                                onChanged: (v) {
                                  model.phosphorus = double.tryParse(v);
                                })),
                      ],
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 5, top: 15),
                        width: double.infinity,
                        child: Text(
                          Languages.micro() + ':',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                    Row(
                      children: [
                        Expanded(
                            child: CustomTextField(
                                name: Languages.iron(),
                                suffix: "mg",
                                initialValue: model.iron.toString(),
                                textColor: model.ironColor,
                                keyboardType: TextInputType.number,
                                onChanged: (v) {
                                  model.iron = double.tryParse(v);
                                })),
                        Expanded(
                            child: CustomTextField(
                                name: Languages.copper(),
                                suffix: "mg",
                                initialValue: model.copper.toString(),
                                textColor: model.copperColor,
                                keyboardType: TextInputType.number,
                                onChanged: (v) {
                                  model.copper = double.tryParse(v);
                                })),
                        Expanded(
                            child: CustomTextField(
                                name: Languages.zinc(),
                                suffix: "mg",
                                initialValue: model.zinc.toString(),
                                textColor: model.zincColor,
                                keyboardType: TextInputType.number,
                                onChanged: (v) {
                                  model.zinc = double.tryParse(v);
                                })),
                        Expanded(
                            child: CustomTextField(
                                name: Languages.selenium(),
                                suffix: "mg",
                                initialValue: model.selenium.toString(),
                                textColor: model.seleniumColor,
                                keyboardType: TextInputType.number,
                                onChanged: (v) {
                                  model.selenium = double.tryParse(v);
                                })),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: CustomTextField(
                                name: Languages.manganese(),
                                suffix: "mg",
                                initialValue: model.manganese.toString(),
                                textColor: model.manganeseColor,
                                keyboardType: TextInputType.number,
                                onChanged: (v) {
                                  model.manganese = double.tryParse(v);
                                })),
                        Expanded(
                            child: CustomTextField(
                                name: Languages.iodine(),
                                suffix: "mg",
                                initialValue: model.iodine.toString(),
                                textColor: model.iodineColor,
                                keyboardType: TextInputType.number,
                                onChanged: (v) {
                                  model.iodine = double.tryParse(v);
                                })),
                        Expanded(
                            child: CustomTextField(
                                name: Languages.chromium(),
                                suffix: "mg",
                                initialValue: model.chromium.toString(),
                                textColor: model.chromiumColor,
                                keyboardType: TextInputType.number,
                                onChanged: (v) {
                                  model.chromium = double.tryParse(v);
                                })),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
