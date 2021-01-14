import 'package:fitable/app/product/add_key_words_screen.dart';
import 'package:fitable/app/product/add_portions_screen.dart';
import 'package:fitable/app/product/models/meal_model.dart';
import 'package:fitable/app/product/view_model/create_product_view_model.dart';
import 'package:fitable/common_widgets/add_button.dart';
import 'package:fitable/common_widgets/custom_drop_down_button.dart';
import 'package:fitable/common_widgets/custom_scaffold.dart';
import 'package:fitable/common_widgets/custom_text_field.dart';
import 'package:fitable/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';

class CreateProductScreenArguments {
  final String barcode;
  final MealType mealType;

  CreateProductScreenArguments({@required this.barcode, @required this.mealType});
}

class CreateProductScreen extends ConsumerWidget {
  Widget build(BuildContext context, ScopedReader watch) {
    final CreateProductScreenArguments args = ModalRoute.of(context).settings.arguments;
    final model = watch(providerCreateProductViewModel);

    return CustomScaffold(
      appBar: AppBar(actions: [
        IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              model.submit(context: context, barcode: args.barcode);
              Navigator.pop(context);
            })
      ]),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
                  name: Constants.product_name.tr(),
                  suffix: "",
                  onChanged: (v) {
                    model.productName = v;
                  }),
              CustomDropDownButton(
                  name: Constants.category_primary.tr(),
                  value: model.categoryPrimary,
                  list: <String>['fruits_vegetables_mushrooms', 'dairy_eggs', 'meat', 'groceries', 'frozen_foods', 'supplements', 'drinks', 'other'],
                  onChanged: (v) {
                    model.categoryPrimary = v;
                  }),
              if (model.listSecondary.isNotEmpty)
                CustomDropDownButton(
                    name: Constants.category_secondary.tr(),
                    value: model.categorySecondary,
                    list: model.listSecondary,
                    onChanged: (v) {
                      model.categorySecondary = v;
                    }),
              Container(
                height: 55,
                child: Row(
                  children: [
                    Expanded(
                      child: Card(
                        child: Container(
                          padding: EdgeInsets.only(left: 6, top: 6),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("key_words".tr() + ":", style: TextStyle(fontWeight: FontWeight.bold)),
                              Text(model.keyWords.toString().substring(1, model.keyWords.toString().length - 1)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    AddButton(
                      onPressed: () async {
                        List<String> result = await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return AddKeyWordsScreen(model.keyWords);
                          }),
                        );

                        if (result != null) {
                          model.keyWords = result;
                        }
                      },
                    ),
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.only(left: 5, top: 15),
                  width: double.infinity,
                  child: Text(
                    Constants.nutritional_values_out_of_100.tr() + ':',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
              Row(
                children: [
                  Expanded(
                      child: CustomTextField(
                          name: "calories".tr(),
                          suffix: "kcal",
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
                          keyboardType: TextInputType.number,
                          onChanged: (v) {
                            model.proteins = double.tryParse(v);
                          })),
                  Expanded(
                      child: CustomTextField(
                          name: "carbs".tr(),
                          suffix: "g",
                          keyboardType: TextInputType.number,
                          onChanged: (v) {
                            model.carbs = double.tryParse(v);
                          })),
                  Expanded(
                      child: CustomTextField(
                          name: "fats".tr(),
                          suffix: "g",
                          keyboardType: TextInputType.number,
                          onChanged: (v) {
                            model.fats = double.tryParse(v);
                          })),
                ],
              ),
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Card(
                        child: Container(
                          padding: EdgeInsets.only(left: 6, top: 6, bottom: 6, right: 6),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("portions".tr() + ":", style: TextStyle(fontWeight: FontWeight.bold)),
                              Text(model.portions.toString().substring(1, model.portions.toString().length - 1)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 55,
                      child: AddButton(
                        onPressed: () async {
                          Map<String, double> result = await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return AddPortionsScreen(unit: model.unit, map: model.portions);
                            }),
                          );

                          if (result != null) {
                            model.portions = result;
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
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
                              keyboardType: TextInputType.number,
                              onChanged: (v) {
                                model.saturated = double.tryParse(v);
                              })),
                      Expanded(
                          child: CustomTextField(
                              name: "unsaturated".tr(),
                              suffix: "g",
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
                              keyboardType: TextInputType.number,
                              onChanged: (v) {
                                model.omega3 = double.tryParse(v);
                              })),
                      Expanded(
                          child: CustomTextField(
                              name: "omega6".tr(),
                              suffix: "g",
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
                              onChanged: (v) {
                                model.animalProteins = double.tryParse(v);
                              })),
                      Expanded(
                          child: CustomTextField(
                              name: "plant_proteins".tr(),
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
                              keyboardType: TextInputType.number,
                              onChanged: (v) {
                                model.fiber = double.tryParse(v);
                              })),
                      Expanded(
                          child: CustomTextField(
                              name: "caffeine".tr(),
                              suffix: "g",
                              keyboardType: TextInputType.number,
                              onChanged: (v) {
                                model.caffeine = double.tryParse(v);
                              })),
                      Expanded(
                          child: CustomTextField(
                              name: "sugar".tr(),
                              suffix: "g",
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
                              keyboardType: TextInputType.number,
                              onChanged: (v) {
                                model.salt = double.tryParse(v);
                              })),
                      Expanded(
                          child: CustomTextField(
                              name: "cholesterol".tr(),
                              suffix: "g",
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
                              keyboardType: TextInputType.number,
                              onChanged: (v) {
                                model.vitaminA = double.tryParse(v);
                              })),
                      Expanded(
                          child: CustomTextField(
                              name: "C".tr(),
                              suffix: "mg",
                              keyboardType: TextInputType.number,
                              onChanged: (v) {
                                model.vitaminC = double.tryParse(v);
                              })),
                      Expanded(
                          child: CustomTextField(
                              name: "D".tr(),
                              suffix: "mg",
                              keyboardType: TextInputType.number,
                              onChanged: (v) {
                                model.vitaminD = double.tryParse(v);
                              })),
                      Expanded(
                          child: CustomTextField(
                              name: "E".tr(),
                              suffix: "mg",
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
                              keyboardType: TextInputType.number,
                              onChanged: (v) {
                                model.vitaminB1 = double.tryParse(v);
                              })),
                      Expanded(
                          child: CustomTextField(
                              name: "B2".tr(),
                              suffix: "mg",
                              keyboardType: TextInputType.number,
                              onChanged: (v) {
                                model.vitaminB2 = double.tryParse(v);
                              })),
                      Expanded(
                          child: CustomTextField(
                              name: "B3".tr(),
                              suffix: "mg",
                              keyboardType: TextInputType.number,
                              onChanged: (v) {
                                model.vitaminB3 = double.tryParse(v);
                              })),
                      Expanded(
                          child: CustomTextField(
                              name: "B5".tr(),
                              suffix: "mg",
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
                              keyboardType: TextInputType.number,
                              onChanged: (v) {
                                model.vitaminB6 = double.tryParse(v);
                              })),
                      Expanded(
                          child: CustomTextField(
                              name: "B7".tr(),
                              suffix: "mg",
                              keyboardType: TextInputType.number,
                              onChanged: (v) {
                                model.vitaminB7 = double.tryParse(v);
                              })),
                      Expanded(
                          child: CustomTextField(
                              name: "B9".tr(),
                              suffix: "mg",
                              keyboardType: TextInputType.number,
                              onChanged: (v) {
                                model.vitaminB9 = double.tryParse(v);
                              })),
                      Expanded(
                          child: CustomTextField(
                              name: "B12".tr(),
                              suffix: "mg",
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
                              keyboardType: TextInputType.number,
                              onChanged: (v) {
                                model.potassium = double.tryParse(v);
                              })),
                      Expanded(
                          child: CustomTextField(
                              name: "sodium".tr(),
                              suffix: "mg",
                              keyboardType: TextInputType.number,
                              onChanged: (v) {
                                model.sodium = double.tryParse(v);
                              })),
                      Expanded(
                          child: CustomTextField(
                              name: "calcium".tr(),
                              suffix: "mg",
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
                              keyboardType: TextInputType.number,
                              onChanged: (v) {
                                model.magnesium = double.tryParse(v);
                              })),
                      Expanded(
                          child: CustomTextField(
                              name: "phosphorus".tr(),
                              suffix: "mg",
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
                              keyboardType: TextInputType.number,
                              onChanged: (v) {
                                model.iron = double.tryParse(v);
                              })),
                      Expanded(
                          child: CustomTextField(
                              name: "copper".tr(),
                              suffix: "mg",
                              keyboardType: TextInputType.number,
                              onChanged: (v) {
                                model.copper = double.tryParse(v);
                              })),
                      Expanded(
                          child: CustomTextField(
                              name: "zinc".tr(),
                              suffix: "mg",
                              keyboardType: TextInputType.number,
                              onChanged: (v) {
                                model.zinc = double.tryParse(v);
                              })),
                      Expanded(
                          child: CustomTextField(
                              name: "selenium".tr(),
                              suffix: "mg",
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
                              keyboardType: TextInputType.number,
                              onChanged: (v) {
                                model.manganese = double.tryParse(v);
                              })),
                      Expanded(
                          child: CustomTextField(
                              name: "iodine".tr(),
                              suffix: "mg",
                              keyboardType: TextInputType.number,
                              onChanged: (v) {
                                model.iodine = double.tryParse(v);
                              })),
                      Expanded(
                          child: CustomTextField(
                              name: "chromium".tr(),
                              suffix: "mg",
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
  }
}