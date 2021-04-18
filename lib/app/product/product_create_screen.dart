import 'package:fitable/app/add_details/add_details_screen.dart';
import 'package:fitable/app/meal/models/meal_model.dart';
import 'package:fitable/app/product/add_key_words_screen.dart';
import 'package:fitable/app/product/add_portions_screen.dart';
import 'package:fitable/app/product/models/product_model.dart';
import 'package:fitable/app/product/view_models/create_product_view_model.dart';
import 'package:fitable/common_widgets/custom_bar_list.dart';
import 'package:fitable/common_widgets/custom_drop_down_button.dart';
import 'package:fitable/common_widgets/custom_list_view.dart';
import 'package:fitable/common_widgets/custom_scaffold.dart';
import 'package:fitable/common_widgets/custom_text_field.dart';
import 'package:fitable/common_widgets/show_input_picker.dart';
import 'package:fitable/constants/constants.dart';
import 'package:fitable/constants/enums.dart';
import 'package:fitable/routers/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';

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

_submit(BuildContext context) async {
  final ProductCreateScreenArguments args = ModalRoute.of(context).settings.arguments;
  final model = context.read(providerCreateProductViewModel);

  if (args?.product != null) {
    String _value;
    await showInputPicker(
      context: context,
      labelText: 'description'.tr(),
      multiLine: true,
      buttonTextYes: 'send'.tr(),
      onPressed: () {
        model.submit(context: context, barcode: args.barcode, id: args.product.id, description: _value);
        Navigator.pop(context);
      },
      onChanged: (String v) {
        _value = v;
      },
    );
  } else {
    model.submit(context: context, barcode: args.barcode);
  }

  Navigator.pop(context);
}

_submitKeyWords(BuildContext context) async {
  final model = context.read(providerCreateProductViewModel);

  List result = await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) {
      return AddDetailsScreen(tileType: EnumTileType.keyWord, list: model.keyWords, title: Constants.key_words(), unit: model.unit);
    }),
  );

  if (result != null) model.keyWords = result;
}

_submitPortions(BuildContext context) async {
  final model = context.read(providerCreateProductViewModel);

  Map result = await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) {
      return AddPortionsScreen(unit: model.unit, map: model.portions);
    }),
  );

  if (result != null) {
    model.portions = result;
  }
}

class _ProductCreateScreenState extends State<ProductCreateScreen> {
  @override
  void didChangeDependencies() {
    final ProductCreateScreenArguments args = ModalRoute.of(context).settings.arguments;
    if (args?.product != null) {
      final model = context.read(providerCreateProductViewModel);
      model.initProduct(args.product);
    }
    super.didChangeDependencies();
  }

  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final ProductCreateScreenArguments args = ModalRoute.of(context).settings.arguments;
      final model = watch(providerCreateProductViewModel);
      return CustomScaffold(
        appBar: AppBar(actions: [
          IconButton(icon: Icon(Icons.save), onPressed: () => _submit(context)),
        ]),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (args.barcode != null)
                  Container(
                      padding: EdgeInsets.only(top: 5, left: 5, right: 2),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Stack(
                        children: <Widget>[
                          Text(args.barcode, style: GoogleFonts.libreBarcode39(textStyle: TextStyle(fontSize: 47))),
                          Container(
                            margin: EdgeInsets.only(top: 25),
                            child: Text(args.barcode,
                                style: TextStyle(
                                  fontSize: 36,
                                  letterSpacing: 4.0,
                                )),
                          ),
                        ],
                      )),
                CustomTextField(
                    name: Constants.product_name(),
                    initialValue: model.productName,
                    suffix: "",
                    textColor: model.productNameColor,
                    onChanged: (v) {
                      model.productName = v;
                    }),
                CustomDropDownButton(
                    name: Constants.category_primary(),
                    value: model.categoryPrimary,
                    list: <String>[
                      'fruits_vegetables_mushrooms',
                      'dairy_eggs',
                      'meat',
                      'groceries',
                      'frozen_foods',
                      'supplements',
                      'drinks',
                      'other'
                    ],
                    onChanged: (v) {
                      model.categoryPrimary = v;
                    }),
                if (model.listSecondary.isNotEmpty)
                  CustomDropDownButton(
                      name: Constants.category_secondary(),
                      value: model.categorySecondary,
                      list: model.listSecondary,
                      onChanged: (v) {
                        model.categorySecondary = v;
                      }),
                CustomBarList(name: "key_words".tr(), value: model.keyWords, onPressed: () => _submitKeyWords(context)),
                Container(
                    margin: EdgeInsets.only(left: 5, top: 15),
                    width: double.infinity,
                    child: Text(
                      Constants.nutritional_values_out_of_100() + ':',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                Row(
                  children: [
                    Expanded(
                        child: CustomTextField(
                            name: "calories".tr(),
                            suffix: "kcal",
                            initialValue: model.calories.toString(),
                            textColor: model.caloriesColor,
                            keyboardType: TextInputType.number,
                            onChanged: (v) {
                              model.calories = int.tryParse(v);
                            })),
                    Expanded(
                      child: CustomDropDownButton(
                          name: 'unit'.tr(),
                          value: model.unit,
                          list: <String>['g', 'ml'],
                          onChanged: (v) {
                            model.unit = v;
                          }),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: CustomTextField(
                            name: "proteins".tr(),
                            suffix: "g",
                            initialValue: model.proteins.toString(),
                            textColor: model.proteinsColor,
                            keyboardType: TextInputType.number,
                            onChanged: (v) {
                              model.proteins = double.tryParse(v);
                            })),
                    Expanded(
                        child: CustomTextField(
                            name: "carbs".tr(),
                            suffix: "g",
                            initialValue: model.carbs.toString(),
                            textColor: model.carbsColor,
                            keyboardType: TextInputType.number,
                            onChanged: (v) {
                              model.carbs = double.tryParse(v);
                            })),
                    Expanded(
                        child: CustomTextField(
                            name: "fats".tr(),
                            suffix: "g",
                            initialValue: model.fats.toString(),
                            textColor: model.fatsColor,
                            keyboardType: TextInputType.number,
                            onChanged: (v) {
                              model.fats = double.tryParse(v);
                            })),
                  ],
                ),
                CustomBarList(name: "portions".tr(), value: model.portions, onPressed: () => _submitPortions(context)),
                ExpansionTile(
                  title: Center(
                    child: Text(
                      "more_about_the_product".tr(),
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: 5),
                        width: double.infinity,
                        child: Text(
                          'fats'.tr() + ':',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                    Row(
                      children: [
                        Expanded(
                            child: CustomTextField(
                                name: "saturated".tr(),
                                suffix: "g",
                                initialValue: model.saturated.toString(),
                                textColor: model.saturatedColor,
                                keyboardType: TextInputType.number,
                                onChanged: (v) {
                                  model.saturated = double.tryParse(v);
                                })),
                        Expanded(
                            child: CustomTextField(
                                name: "unsaturated".tr(),
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
                                name: "omega3".tr(),
                                suffix: "g",
                                initialValue: model.omega3.toString(),
                                textColor: model.omega3Color,
                                keyboardType: TextInputType.number,
                                onChanged: (v) {
                                  model.omega3 = double.tryParse(v);
                                })),
                        Expanded(
                            child: CustomTextField(
                                name: "omega6".tr(),
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
                          'proteins'.tr() + ':',
                          style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.bold),
                        )),
                    Row(
                      children: [
                        Expanded(
                            child: CustomTextField(
                                name: "animal_proteins".tr(),
                                keyboardType: TextInputType.number,
                                suffix: "g",
                                initialValue: model.animalProteins.toString(),
                                textColor: model.animalProteinsColor,
                                onChanged: (v) {
                                  model.animalProteins = double.tryParse(v);
                                })),
                        Expanded(
                            child: CustomTextField(
                                name: "plant_proteins".tr(),
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
                          'others'.tr() + ':',
                          style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.bold),
                        )),
                    Row(
                      children: [
                        Expanded(
                            child: CustomTextField(
                                name: "fiber".tr(),
                                suffix: "g",
                                initialValue: model.fiber.toString(),
                                textColor: model.fiberColor,
                                keyboardType: TextInputType.number,
                                onChanged: (v) {
                                  model.fiber = double.tryParse(v);
                                })),
                        Expanded(
                            child: CustomTextField(
                                name: "caffeine".tr(),
                                suffix: "g",
                                initialValue: model.caffeine.toString(),
                                textColor: model.caffeineColor,
                                keyboardType: TextInputType.number,
                                onChanged: (v) {
                                  model.caffeine = double.tryParse(v);
                                })),
                        Expanded(
                            child: CustomTextField(
                                name: "sugar".tr(),
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
                                name: "salt".tr(),
                                suffix: "g",
                                initialValue: model.salt.toString(),
                                textColor: model.saltColor,
                                keyboardType: TextInputType.number,
                                onChanged: (v) {
                                  model.salt = double.tryParse(v);
                                })),
                        Expanded(
                            child: CustomTextField(
                                name: "cholesterol".tr(),
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
                          'vitamins'.tr() + ':',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                    Row(
                      children: [
                        Expanded(
                            child: CustomTextField(
                                name: "A".tr(),
                                suffix: "mg",
                                initialValue: model.vitaminA.toString(),
                                textColor: model.vitaminAColor,
                                keyboardType: TextInputType.number,
                                onChanged: (v) {
                                  model.vitaminA = double.tryParse(v);
                                })),
                        Expanded(
                            child: CustomTextField(
                                name: "C".tr(),
                                suffix: "mg",
                                initialValue: model.vitaminC.toString(),
                                textColor: model.vitaminCColor,
                                keyboardType: TextInputType.number,
                                onChanged: (v) {
                                  model.vitaminC = double.tryParse(v);
                                })),
                        Expanded(
                            child: CustomTextField(
                                name: "D".tr(),
                                suffix: "mg",
                                initialValue: model.vitaminD.toString(),
                                textColor: model.vitaminDColor,
                                keyboardType: TextInputType.number,
                                onChanged: (v) {
                                  model.vitaminD = double.tryParse(v);
                                })),
                        Expanded(
                            child: CustomTextField(
                                name: "E".tr(),
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
                                name: "B1".tr(),
                                suffix: "mg",
                                initialValue: model.vitaminB1.toString(),
                                textColor: model.vitaminB1Color,
                                keyboardType: TextInputType.number,
                                onChanged: (v) {
                                  model.vitaminB1 = double.tryParse(v);
                                })),
                        Expanded(
                            child: CustomTextField(
                                name: "B2".tr(),
                                suffix: "mg",
                                initialValue: model.vitaminB2.toString(),
                                textColor: model.vitaminB2Color,
                                keyboardType: TextInputType.number,
                                onChanged: (v) {
                                  model.vitaminB2 = double.tryParse(v);
                                })),
                        Expanded(
                            child: CustomTextField(
                                name: "B3".tr(),
                                suffix: "mg",
                                initialValue: model.vitaminB3.toString(),
                                textColor: model.vitaminB3Color,
                                keyboardType: TextInputType.number,
                                onChanged: (v) {
                                  model.vitaminB3 = double.tryParse(v);
                                })),
                        Expanded(
                            child: CustomTextField(
                                name: "B5".tr(),
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
                                name: "B6".tr(),
                                suffix: "mg",
                                initialValue: model.vitaminB6.toString(),
                                textColor: model.vitaminB6Color,
                                keyboardType: TextInputType.number,
                                onChanged: (v) {
                                  model.vitaminB6 = double.tryParse(v);
                                })),
                        Expanded(
                            child: CustomTextField(
                                name: "B7".tr(),
                                suffix: "mg",
                                initialValue: model.vitaminB7.toString(),
                                textColor: model.vitaminB7Color,
                                keyboardType: TextInputType.number,
                                onChanged: (v) {
                                  model.vitaminB7 = double.tryParse(v);
                                })),
                        Expanded(
                            child: CustomTextField(
                                name: "B9".tr(),
                                suffix: "mg",
                                initialValue: model.vitaminB9.toString(),
                                textColor: model.vitaminB9Color,
                                keyboardType: TextInputType.number,
                                onChanged: (v) {
                                  model.vitaminB9 = double.tryParse(v);
                                })),
                        Expanded(
                            child: CustomTextField(
                                name: "B12".tr(),
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
                          'macro'.tr() + ':',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                    Row(
                      children: [
                        Expanded(
                            child: CustomTextField(
                                name: "potassium".tr(),
                                suffix: "mg",
                                initialValue: model.potassium.toString(),
                                textColor: model.potassiumColor,
                                keyboardType: TextInputType.number,
                                onChanged: (v) {
                                  model.potassium = double.tryParse(v);
                                })),
                        Expanded(
                            child: CustomTextField(
                                name: "sodium".tr(),
                                suffix: "mg",
                                initialValue: model.sodium.toString(),
                                textColor: model.sodiumColor,
                                keyboardType: TextInputType.number,
                                onChanged: (v) {
                                  model.sodium = double.tryParse(v);
                                })),
                        Expanded(
                            child: CustomTextField(
                                name: "calcium".tr(),
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
                                name: "magnesium".tr(),
                                suffix: "mg",
                                initialValue: model.magnesium.toString(),
                                textColor: model.magnesiumColor,
                                keyboardType: TextInputType.number,
                                onChanged: (v) {
                                  model.magnesium = double.tryParse(v);
                                })),
                        Expanded(
                            child: CustomTextField(
                                name: "phosphorus".tr(),
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
                          'micro'.tr() + ':',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                    Row(
                      children: [
                        Expanded(
                            child: CustomTextField(
                                name: "iron".tr(),
                                suffix: "mg",
                                initialValue: model.iron.toString(),
                                textColor: model.ironColor,
                                keyboardType: TextInputType.number,
                                onChanged: (v) {
                                  model.iron = double.tryParse(v);
                                })),
                        Expanded(
                            child: CustomTextField(
                                name: "copper".tr(),
                                suffix: "mg",
                                initialValue: model.copper.toString(),
                                textColor: model.copperColor,
                                keyboardType: TextInputType.number,
                                onChanged: (v) {
                                  model.copper = double.tryParse(v);
                                })),
                        Expanded(
                            child: CustomTextField(
                                name: "zinc".tr(),
                                suffix: "mg",
                                initialValue: model.zinc.toString(),
                                textColor: model.zincColor,
                                keyboardType: TextInputType.number,
                                onChanged: (v) {
                                  model.zinc = double.tryParse(v);
                                })),
                        Expanded(
                            child: CustomTextField(
                                name: "selenium".tr(),
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
                                name: "manganese".tr(),
                                suffix: "mg",
                                initialValue: model.manganese.toString(),
                                textColor: model.manganeseColor,
                                keyboardType: TextInputType.number,
                                onChanged: (v) {
                                  model.manganese = double.tryParse(v);
                                })),
                        Expanded(
                            child: CustomTextField(
                                name: "iodine".tr(),
                                suffix: "mg",
                                initialValue: model.iodine.toString(),
                                textColor: model.iodineColor,
                                keyboardType: TextInputType.number,
                                onChanged: (v) {
                                  model.iodine = double.tryParse(v);
                                })),
                        Expanded(
                            child: CustomTextField(
                                name: "chromium".tr(),
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
