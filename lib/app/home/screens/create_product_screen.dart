import 'package:drop_down_list/drop_down_list.dart';
import 'package:fitable/app/auth/bloc/auth_bloc.dart';
import 'package:fitable/app/home/cubit/create_product/create_product_cubit.dart';
import 'package:fitable/app/home/repositories/product_repository.dart';
import 'package:fitable/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/injectable/injection.dart';
import '../../../widgets/widgets.dart';
import '../models/product/product_model.dart';
import '../widgets/key_words.dart';
import '../widgets/portions.dart';
import '../widgets/text_field_with_title.dart';

class ProductCreateScreen extends StatefulWidget {
  final Product? product;
  final String? barcode;

  const ProductCreateScreen({Key? key, this.product, this.barcode}) : super(key: key);

  @override
  State<ProductCreateScreen> createState() => _ProductCreateScreenState();
}

class _ProductCreateScreenState extends State<ProductCreateScreen> {
  final GlobalKey<FormState> _formKeyName = GlobalKey();
  final GlobalKey<FormState> _formKeyCalories = GlobalKey();
  final GlobalKey<FormState> _formKeyProteins = GlobalKey();
  final GlobalKey<FormState> _formKeyCarbs = GlobalKey();
  final GlobalKey<FormState> _formKeyFats = GlobalKey();

  final GlobalKey<FormState> _formKeySugar = GlobalKey();
  final GlobalKey<FormState> _formKeyAnimalProteins = GlobalKey();
  final GlobalKey<FormState> _formKeyPlantProteins = GlobalKey();
  final GlobalKey<FormState> _formKeySaturated = GlobalKey();
  final GlobalKey<FormState> _formKeyUnsaturated = GlobalKey();
  final GlobalKey<FormState> _formKeyOmega3 = GlobalKey();
  final GlobalKey<FormState> _formKeyOmega6 = GlobalKey();
  final GlobalKey<FormState> _formKeyFiber = GlobalKey();
  final GlobalKey<FormState> _formKeyCaffeine = GlobalKey();
  final GlobalKey<FormState> _formKeyCholesterol = GlobalKey();
  final GlobalKey<FormState> _formKeySalt = GlobalKey();
  final GlobalKey<FormState> _formKeyVitaminA = GlobalKey();
  final GlobalKey<FormState> _formKeyVitaminC = GlobalKey();
  final GlobalKey<FormState> _formKeyVitaminD = GlobalKey();
  final GlobalKey<FormState> _formKeyVitaminE = GlobalKey();
  final GlobalKey<FormState> _formKeyVitaminK = GlobalKey();
  final GlobalKey<FormState> _formKeyVitaminB1 = GlobalKey();
  final GlobalKey<FormState> _formKeyVitaminB2 = GlobalKey();
  final GlobalKey<FormState> _formKeyVitaminB3 = GlobalKey();
  final GlobalKey<FormState> _formKeyVitaminB5 = GlobalKey();
  final GlobalKey<FormState> _formKeyVitaminB6 = GlobalKey();
  final GlobalKey<FormState> _formKeyVitaminB7 = GlobalKey();
  final GlobalKey<FormState> _formKeyVitaminB9 = GlobalKey();
  final GlobalKey<FormState> _formKeyVitaminB12 = GlobalKey();
  final GlobalKey<FormState> _formKeyPotassium = GlobalKey();
  final GlobalKey<FormState> _formKeySodium = GlobalKey();
  final GlobalKey<FormState> _formKeyCalcium = GlobalKey();
  final GlobalKey<FormState> _formKeyMagnesium = GlobalKey();
  final GlobalKey<FormState> _formKeyPhosphorus = GlobalKey();
  final GlobalKey<FormState> _formKeyIron = GlobalKey();
  final GlobalKey<FormState> _formKeyCopper = GlobalKey();
  final GlobalKey<FormState> _formKeyZinc = GlobalKey();
  final GlobalKey<FormState> _formKeySelenium = GlobalKey();
  final GlobalKey<FormState> _formKeyManganese = GlobalKey();
  final GlobalKey<FormState> _formKeyIodine = GlobalKey();
  final GlobalKey<FormState> _formKeyChromium = GlobalKey();

  final TextEditingController _categoryPrimaryController = TextEditingController();
  final TextEditingController _categorySecondaryController = TextEditingController();
  final TextEditingController _categoryLocalBase = TextEditingController();

  final List<String> _listOfCities = [
    'test 1',
    'test 2',
    'test 3',
    'test 4',
    'test 5',
    'test 6',
    'test 7',
    'test 8',
    'test 9',
  ];

  @override
  void initState() {
    _categoryPrimaryController.text = '';
    _categorySecondaryController.text = '';
    _categoryLocalBase.text = '';
    super.initState();
  }

  @override
  void dispose() {
    _categoryPrimaryController.dispose();
    _categorySecondaryController.dispose();
    _categoryLocalBase.dispose();

    super.dispose();
  }

  List<SelectedListItem> _buildListSelectedItem(List<String> list) {
    List<SelectedListItem> _listSelectedItem = [];

    list.forEach((element) {
      _listSelectedItem.add(
        SelectedListItem(false, element),
      );
    });

    return _listSelectedItem;
  }

  Builder _buildMainPage(Product product) {
    return Builder(builder: (context) {
      return GestureDetector(
        onTapDown: (_) => FocusScope.of(context).unfocus(),
        onHorizontalDragDown: (_) => FocusScope.of(context).unfocus(),
        child: ListView(
          children: [
            SizedBox(height: 8),
            TextFieldWithTitle(
                formKey: _formKeyName,
                validator: (v) => v!.length < 3 ? 'wrong' : null,
                title: AppLocalizations.of(context)!.name,
                onChange: (String s) {
                  if (_formKeyName.currentState!.validate())
                    context.read<CreateProductCubit>().builder(product.copyWith(name: s));
                },
                initialValue: product.name),
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 4),
              child: Text('${AppLocalizations.of(context)!.categoryPrimary}:',
                  style: Theme.of(context).textTheme.bodyText2),
            ),
            CustomButtonTextField(
              onPressed: () {
                TextEditingController _searchController = TextEditingController();
                DropDownState(
                  DropDown(
                    searchHintText: AppLocalizations.of(context)!.search,
                    searchBackgroundColor: Colors.black12,
                    dataList: _buildListSelectedItem(_listOfCities),
                    selectedItem: (String s) {
                      setState(() => _categoryPrimaryController.text = s);
                      context
                          .read<CreateProductCubit>()
                          .builder(product.copyWith(categoryPrimary: s));
                    },
                    enableMultipleSelection: false,
                    searchController: _searchController,
                  ),
                ).showModal(context);
              },
              child: Text(_categoryPrimaryController.text,
                  style: Theme.of(context).textTheme.bodyText2),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 4),
              child: Text('${AppLocalizations.of(context)!.categorySecondary}:',
                  style: Theme.of(context).textTheme.bodyText2),
            ),
            CustomButtonTextField(
              onPressed: () {
                TextEditingController _searchController = TextEditingController();
                DropDownState(
                  DropDown(
                    searchHintText: AppLocalizations.of(context)!.search,
                    searchBackgroundColor: Colors.black12,
                    dataList: _buildListSelectedItem(_listOfCities),
                    selectedItem: (String s) {
                      setState(() => _categorySecondaryController.text = s);
                      context
                          .read<CreateProductCubit>()
                          .builder(product.copyWith(categorySecondary: s));
                    },
                    enableMultipleSelection: false,
                    searchController: _searchController,
                  ),
                ).showModal(context);
              },
              child: Text(_categorySecondaryController.text,
                  style: Theme.of(context).textTheme.bodyText2),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 4),
              child: Text('${AppLocalizations.of(context)!.company}:',
                  style: Theme.of(context).textTheme.bodyText2),
            ),
            CustomButtonTextField(
              onPressed: () {
                TextEditingController _searchController = TextEditingController();
                DropDownState(
                  DropDown(
                    searchHintText: AppLocalizations.of(context)!.search,
                    searchBackgroundColor: Colors.black12,
                    dataList: _buildListSelectedItem(_listOfCities),
                    selectedItem: (String s) {
                      setState(() => _categorySecondaryController.text = s);
                      context.read<CreateProductCubit>().builder(product.copyWith(company: s));
                    },
                    enableMultipleSelection: false,
                    searchController: _searchController,
                  ),
                ).showModal(context);
              },
              child: Text(_categorySecondaryController.text,
                  style: Theme.of(context).textTheme.bodyText2),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 4),
              child: Text('${AppLocalizations.of(context)!.localeBase}:',
                  style: Theme.of(context).textTheme.bodyText2),
            ),
            CustomButtonTextField(
              onPressed: () {
                TextEditingController _searchController = TextEditingController();
                DropDownState(
                  DropDown(
                    searchHintText: AppLocalizations.of(context)!.search,
                    searchBackgroundColor: Colors.black12,
                    dataList: _buildListSelectedItem(Enums.toList(ETypeLocaleBase.values)),
                    selectedItem: (String s) {
                      setState(() => _categoryLocalBase.text = s);
                      context.read<CreateProductCubit>().builder(
                          product.copyWith(localeBase: Enums.toEnum(s, ETypeLocaleBase.values)));
                    },
                    enableMultipleSelection: false,
                    searchController: _searchController,
                  ),
                ).showModal(context);
              },
              child: Text(_categoryLocalBase.text, style: Theme.of(context).textTheme.bodyText2),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8.0),
              child: Text(
                '${AppLocalizations.of(context)!.key_words}:',
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
            KeyWords(),
            SizedBox(height: 8.0),
            TextFieldWithTitle(
              title: AppLocalizations.of(context)!.calories,
              formKey: _formKeyCalories,
              onChange: (String s) {
                if (_formKeyCalories.currentState!.validate())
                  context
                      .read<CreateProductCubit>()
                      .builder(product.copyWith(calories: int.parse(s)));
              },
              validator: (v) {
                if (v == null || v == '') return 'wrong';
                if (!isInt(v)) return 'wrong';
              },
              initialValue: '0.0',
            ),
            Row(
              children: [
                Expanded(
                  child: TextFieldWithTitle(
                    title: AppLocalizations.of(context)!.proteins,
                    formKey: _formKeyProteins,
                    onChange: (String s) {
                      if (_formKeyProteins.currentState!.validate())
                        context
                            .read<CreateProductCubit>()
                            .builder(product.copyWith(proteins: double.parse(s)));
                    },
                    validator: (v) {
                      if (v == null || v == '') return 'wrong';
                      if (!isFloat(v)) return 'wrong';
                    },
                    initialValue: '0.0',
                  ),
                ),
                Expanded(
                  child: TextFieldWithTitle(
                    title: AppLocalizations.of(context)!.carbs,
                    formKey: _formKeyCarbs,
                    onChange: (String s) {
                      if (_formKeyCarbs.currentState!.validate())
                        context
                            .read<CreateProductCubit>()
                            .builder(product.copyWith(carbs: double.parse(s)));
                    },
                    validator: (v) {
                      if (v == null || v == '') return 'wrong';
                      if (!isFloat(v)) return 'wrong';
                    },
                    initialValue: '0.0',
                  ),
                ),
                SizedBox(height: 8),
                Expanded(
                  child: TextFieldWithTitle(
                    title: AppLocalizations.of(context)!.fats,
                    formKey: _formKeyFats,
                    onChange: (String s) {
                      if (_formKeyFats.currentState!.validate())
                        context
                            .read<CreateProductCubit>()
                            .builder(product.copyWith(fats: double.parse(s)));
                    },
                    validator: (v) {
                      if (v == null || v == '') return 'wrong';
                      if (!isFloat(v)) return 'wrong';
                    },
                    initialValue: '0.0',
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8.0),
              child: Text(
                '${AppLocalizations.of(context)!.portions}:',
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
            Portions(),
            SizedBox(height: 8.0),
            ExpansionTile(
              collapsedIconColor: Colors.white,
              iconColor: Colors.white,
              tilePadding: EdgeInsets.only(left: 4, right: 8),
              childrenPadding: EdgeInsets.all(0),
              title: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('${AppLocalizations.of(context)!.nutritionalValues}:',
                      style: Theme.of(context).textTheme.bodyText1),
                ),
              ),
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFieldWithTitle(
                  title: AppLocalizations.of(context)!.sugar,
                  formKey: _formKeySugar,
                  onChange: (String s) {
                    if (_formKeySugar.currentState!.validate())
                      context
                          .read<CreateProductCubit>()
                          .builder(product.copyWith(sugar: double.parse(s)));
                  },
                  validator: (v) {
                    if (v == null || v == '') return 'wrong';
                    if (!isFloat(v)) return 'wrong';
                  },
                  initialValue: '0.0',
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 24, bottom: 8),
                  child: Text(
                    '${AppLocalizations.of(context)!.proteins}:',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFieldWithTitle(
                        title: AppLocalizations.of(context)!.animalProteins,
                        formKey: _formKeyAnimalProteins,
                        onChange: (String s) {
                          if (_formKeyAnimalProteins.currentState!.validate())
                            context
                                .read<CreateProductCubit>()
                                .builder(product.copyWith(animalProteins: double.parse(s)));
                        },
                        validator: (v) {
                          if (v == null || v == '') return 'wrong';
                          if (!isFloat(v)) return 'wrong';
                        },
                        initialValue: '0.0',
                      ),
                    ),
                    Expanded(
                      child: TextFieldWithTitle(
                        title: AppLocalizations.of(context)!.plantProteins,
                        formKey: _formKeyPlantProteins,
                        onChange: (String s) {
                          if (_formKeyPlantProteins.currentState!.validate())
                            context
                                .read<CreateProductCubit>()
                                .builder(product.copyWith(plantProteins: double.parse(s)));
                        },
                        validator: (v) {
                          if (v == null || v == '') return 'wrong';
                          if (!isFloat(v)) return 'wrong';
                        },
                        initialValue: '0.0',
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 24, bottom: 8),
                  child: Text(
                    '${AppLocalizations.of(context)!.fats}:',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFieldWithTitle(
                        title: AppLocalizations.of(context)!.saturated,
                        formKey: _formKeySaturated,
                        onChange: (String s) {
                          if (_formKeySaturated.currentState!.validate())
                            context
                                .read<CreateProductCubit>()
                                .builder(product.copyWith(saturated: double.parse(s)));
                        },
                        validator: (v) {
                          if (v == null || v == '') return 'wrong';
                          if (!isFloat(v)) return 'wrong';
                        },
                        initialValue: '0.0',
                      ),
                    ),
                    Expanded(
                      child: TextFieldWithTitle(
                        title: AppLocalizations.of(context)!.unsaturated,
                        formKey: _formKeyUnsaturated,
                        onChange: (String s) {
                          if (_formKeyUnsaturated.currentState!.validate())
                            context
                                .read<CreateProductCubit>()
                                .builder(product.copyWith(unsaturated: double.parse(s)));
                        },
                        validator: (v) {
                          if (v == null || v == '') return 'wrong';
                          if (!isFloat(v)) return 'wrong';
                        },
                        initialValue: '0.0',
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFieldWithTitle(
                        title: AppLocalizations.of(context)!.omega3,
                        formKey: _formKeyOmega3,
                        onChange: (String s) {
                          if (_formKeyOmega3.currentState!.validate())
                            context
                                .read<CreateProductCubit>()
                                .builder(product.copyWith(omega3: double.parse(s)));
                        },
                        validator: (v) {
                          if (v == null || v == '') return 'wrong';
                          if (!isFloat(v)) return 'wrong';
                        },
                        initialValue: '0.0',
                      ),
                    ),
                    Expanded(
                      child: TextFieldWithTitle(
                        title: AppLocalizations.of(context)!.omega6,
                        formKey: _formKeyOmega6,
                        onChange: (String s) {
                          if (_formKeyOmega6.currentState!.validate())
                            context
                                .read<CreateProductCubit>()
                                .builder(product.copyWith(omega6: double.parse(s)));
                        },
                        validator: (v) {
                          if (v == null || v == '') return 'wrong';
                          if (!isFloat(v)) return 'wrong';
                        },
                        initialValue: '0.0',
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 24, bottom: 8),
                  child: Text(
                    '${AppLocalizations.of(context)!.other}:',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFieldWithTitle(
                        title: AppLocalizations.of(context)!.fiber,
                        formKey: _formKeyFiber,
                        onChange: (String s) {
                          if (_formKeyFiber.currentState!.validate())
                            context
                                .read<CreateProductCubit>()
                                .builder(product.copyWith(fiber: double.parse(s)));
                        },
                        validator: (v) {
                          if (v == null || v == '') return 'wrong';
                          if (!isFloat(v)) return 'wrong';
                        },
                        initialValue: '0.0',
                      ),
                    ),
                    Expanded(
                      child: TextFieldWithTitle(
                        title: AppLocalizations.of(context)!.caffeine,
                        formKey: _formKeyCaffeine,
                        onChange: (String s) {
                          if (_formKeyCaffeine.currentState!.validate())
                            context
                                .read<CreateProductCubit>()
                                .builder(product.copyWith(caffeine: double.parse(s)));
                        },
                        validator: (v) {
                          if (v == null || v == '') return 'wrong';
                          if (!isFloat(v)) return 'wrong';
                        },
                        initialValue: '0.0',
                      ),
                    ),
                    Expanded(
                      child: TextFieldWithTitle(
                        title: AppLocalizations.of(context)!.cholesterol,
                        formKey: _formKeyCholesterol,
                        onChange: (String s) {
                          if (_formKeyCholesterol.currentState!.validate())
                            context
                                .read<CreateProductCubit>()
                                .builder(product.copyWith(cholesterol: double.parse(s)));
                        },
                        validator: (v) {
                          if (v == null || v == '') return 'wrong';
                          if (!isFloat(v)) return 'wrong';
                        },
                        initialValue: '0.0',
                      ),
                    ),
                    Expanded(
                      child: TextFieldWithTitle(
                        title: AppLocalizations.of(context)!.salt,
                        formKey: _formKeySalt,
                        onChange: (String s) {
                          if (_formKeySalt.currentState!.validate())
                            context
                                .read<CreateProductCubit>()
                                .builder(product.copyWith(salt: double.parse(s)));
                        },
                        validator: (v) {
                          if (v == null || v == '') return 'wrong';
                          if (!isFloat(v)) return 'wrong';
                        },
                        initialValue: '0.0',
                      ),
                    ),
                  ],
                ),
              ],
            ),
            ExpansionTile(
              collapsedIconColor: Colors.white,
              iconColor: Colors.white,
              tilePadding: EdgeInsets.only(left: 4, right: 8),
              childrenPadding: EdgeInsets.all(0),
              title: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('${AppLocalizations.of(context)!.vitamins}:',
                      style: Theme.of(context).textTheme.bodyText1),
                ),
              ),
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFieldWithTitle(
                  title: AppLocalizations.of(context)!.vitaminA,
                  formKey: _formKeyVitaminA,
                  onChange: (String s) {
                    if (_formKeyVitaminA.currentState!.validate())
                      context
                          .read<CreateProductCubit>()
                          .builder(product.copyWith(vitaminA: double.parse(s)));
                  },
                  validator: (v) {
                    if (v == null || v == '') return 'wrong';
                    if (!isFloat(v)) return 'wrong';
                  },
                  initialValue: '0.0',
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFieldWithTitle(
                        title: AppLocalizations.of(context)!.vitaminC,
                        formKey: _formKeyVitaminC,
                        onChange: (String s) {
                          if (_formKeyVitaminC.currentState!.validate())
                            context
                                .read<CreateProductCubit>()
                                .builder(product.copyWith(vitaminC: double.parse(s)));
                        },
                        validator: (v) {
                          if (v == null || v == '') return 'wrong';
                          if (!isFloat(v)) return 'wrong';
                        },
                        initialValue: '0.0',
                      ),
                    ),
                    Expanded(
                      child: TextFieldWithTitle(
                        title: AppLocalizations.of(context)!.vitaminD,
                        formKey: _formKeyVitaminD,
                        onChange: (String s) {
                          if (_formKeyVitaminD.currentState!.validate())
                            context
                                .read<CreateProductCubit>()
                                .builder(product.copyWith(vitaminD: double.parse(s)));
                        },
                        validator: (v) {
                          if (v == null || v == '') return 'wrong';
                          if (!isFloat(v)) return 'wrong';
                        },
                        initialValue: '0.0',
                      ),
                    ),
                    Expanded(
                      child: TextFieldWithTitle(
                        title: AppLocalizations.of(context)!.vitaminE,
                        formKey: _formKeyVitaminE,
                        onChange: (String s) {
                          if (_formKeyVitaminE.currentState!.validate())
                            context
                                .read<CreateProductCubit>()
                                .builder(product.copyWith(vitaminE: double.parse(s)));
                        },
                        validator: (v) {
                          if (v == null || v == '') return 'wrong';
                          if (!isFloat(v)) return 'wrong';
                        },
                        initialValue: '0.0',
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFieldWithTitle(
                        title: AppLocalizations.of(context)!.vitaminK,
                        formKey: _formKeyVitaminK,
                        onChange: (String s) {
                          if (_formKeyVitaminK.currentState!.validate())
                            context
                                .read<CreateProductCubit>()
                                .builder(product.copyWith(vitaminK: double.parse(s)));
                        },
                        validator: (v) {
                          if (v == null || v == '') return 'wrong';
                          if (!isFloat(v)) return 'wrong';
                        },
                        initialValue: '0.0',
                      ),
                    ),
                    Expanded(
                      child: TextFieldWithTitle(
                        title: AppLocalizations.of(context)!.vitaminB1,
                        formKey: _formKeyVitaminB1,
                        onChange: (String s) {
                          if (_formKeyVitaminB1.currentState!.validate())
                            context
                                .read<CreateProductCubit>()
                                .builder(product.copyWith(vitaminB1: double.parse(s)));
                        },
                        validator: (v) {
                          if (v == null || v == '') return 'wrong';
                          if (!isFloat(v)) return 'wrong';
                        },
                        initialValue: '0.0',
                      ),
                    ),
                    Expanded(
                      child: TextFieldWithTitle(
                        title: AppLocalizations.of(context)!.vitaminB2,
                        formKey: _formKeyVitaminB2,
                        onChange: (String s) {
                          if (_formKeyVitaminB2.currentState!.validate())
                            context
                                .read<CreateProductCubit>()
                                .builder(product.copyWith(vitaminB2: double.parse(s)));
                        },
                        validator: (v) {
                          if (v == null || v == '') return 'wrong';
                          if (!isFloat(v)) return 'wrong';
                        },
                        initialValue: '0.0',
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFieldWithTitle(
                        title: AppLocalizations.of(context)!.vitaminB3,
                        formKey: _formKeyVitaminB3,
                        onChange: (String s) {
                          if (_formKeyVitaminB3.currentState!.validate())
                            context
                                .read<CreateProductCubit>()
                                .builder(product.copyWith(vitaminB3: double.parse(s)));
                        },
                        validator: (v) {
                          if (v == null || v == '') return 'wrong';
                          if (!isFloat(v)) return 'wrong';
                        },
                        initialValue: '0.0',
                      ),
                    ),
                    Expanded(
                      child: TextFieldWithTitle(
                        title: AppLocalizations.of(context)!.vitaminB5,
                        formKey: _formKeyVitaminB5,
                        onChange: (String s) {
                          if (_formKeyVitaminB5.currentState!.validate())
                            context
                                .read<CreateProductCubit>()
                                .builder(product.copyWith(vitaminB5: double.parse(s)));
                        },
                        validator: (v) {
                          if (v == null || v == '') return 'wrong';
                          if (!isFloat(v)) return 'wrong';
                        },
                        initialValue: '0.0',
                      ),
                    ),
                    Expanded(
                      child: TextFieldWithTitle(
                        title: AppLocalizations.of(context)!.vitaminB6,
                        formKey: _formKeyVitaminB6,
                        onChange: (String s) {
                          if (_formKeyVitaminB6.currentState!.validate())
                            context
                                .read<CreateProductCubit>()
                                .builder(product.copyWith(vitaminB6: double.parse(s)));
                        },
                        validator: (v) {
                          if (v == null || v == '') return 'wrong';
                          if (!isFloat(v)) return 'wrong';
                        },
                        initialValue: '0.0',
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFieldWithTitle(
                        title: AppLocalizations.of(context)!.vitaminB7,
                        formKey: _formKeyVitaminB7,
                        onChange: (String s) {
                          if (_formKeyVitaminB7.currentState!.validate())
                            context
                                .read<CreateProductCubit>()
                                .builder(product.copyWith(vitaminB7: double.parse(s)));
                        },
                        validator: (v) {
                          if (v == null || v == '') return 'wrong';
                          if (!isFloat(v)) return 'wrong';
                        },
                        initialValue: '0.0',
                      ),
                    ),
                    Expanded(
                      child: TextFieldWithTitle(
                        title: AppLocalizations.of(context)!.vitaminB9,
                        formKey: _formKeyVitaminB9,
                        onChange: (String s) {
                          if (_formKeyVitaminB9.currentState!.validate())
                            context
                                .read<CreateProductCubit>()
                                .builder(product.copyWith(vitaminB9: double.parse(s)));
                        },
                        validator: (v) {
                          if (v == null || v == '') return 'wrong';
                          if (!isFloat(v)) return 'wrong';
                        },
                        initialValue: '0.0',
                      ),
                    ),
                    Expanded(
                      child: TextFieldWithTitle(
                        title: AppLocalizations.of(context)!.vitaminB12,
                        formKey: _formKeyVitaminB12,
                        onChange: (String s) {
                          if (_formKeyVitaminB12.currentState!.validate())
                            context
                                .read<CreateProductCubit>()
                                .builder(product.copyWith(vitaminB12: double.parse(s)));
                        },
                        validator: (v) {
                          if (v == null || v == '') return 'wrong';
                          if (!isFloat(v)) return 'wrong';
                        },
                        initialValue: '0.0',
                      ),
                    ),
                  ],
                ),
              ],
            ),
            ExpansionTile(
              collapsedIconColor: Colors.white,
              iconColor: Colors.white,
              tilePadding: EdgeInsets.only(left: 4, right: 8),
              childrenPadding: EdgeInsets.all(0),
              title: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('${AppLocalizations.of(context)!.macro}:',
                      style: Theme.of(context).textTheme.bodyText1),
                ),
              ),
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFieldWithTitle(
                        title: AppLocalizations.of(context)!.potassium,
                        formKey: _formKeyPotassium,
                        onChange: (String s) {
                          if (_formKeyPotassium.currentState!.validate())
                            context
                                .read<CreateProductCubit>()
                                .builder(product.copyWith(potassium: double.parse(s)));
                        },
                        validator: (v) {
                          if (v == null || v == '') return 'wrong';
                          if (!isFloat(v)) return 'wrong';
                        },
                        initialValue: '0.0',
                      ),
                    ),
                    Expanded(
                      child: TextFieldWithTitle(
                        title: AppLocalizations.of(context)!.sodium,
                        formKey: _formKeySodium,
                        onChange: (String s) {
                          if (_formKeySodium.currentState!.validate())
                            context
                                .read<CreateProductCubit>()
                                .builder(product.copyWith(sodium: double.parse(s)));
                        },
                        validator: (v) {
                          if (v == null || v == '') return 'wrong';
                          if (!isFloat(v)) return 'wrong';
                        },
                        initialValue: '0.0',
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFieldWithTitle(
                        title: AppLocalizations.of(context)!.calcium,
                        formKey: _formKeyCalcium,
                        onChange: (String s) {
                          if (_formKeyCalcium.currentState!.validate())
                            context
                                .read<CreateProductCubit>()
                                .builder(product.copyWith(calcium: double.parse(s)));
                        },
                        validator: (v) {
                          if (v == null || v == '') return 'wrong';
                          if (!isFloat(v)) return 'wrong';
                        },
                        initialValue: '0.0',
                      ),
                    ),
                    Expanded(
                      child: TextFieldWithTitle(
                        title: AppLocalizations.of(context)!.magnesium,
                        formKey: _formKeyMagnesium,
                        onChange: (String s) {
                          if (_formKeyMagnesium.currentState!.validate())
                            context
                                .read<CreateProductCubit>()
                                .builder(product.copyWith(magnesium: double.parse(s)));
                        },
                        validator: (v) {
                          if (v == null || v == '') return 'wrong';
                          if (!isFloat(v)) return 'wrong';
                        },
                        initialValue: '0.0',
                      ),
                    ),
                    Expanded(
                      child: TextFieldWithTitle(
                        title: AppLocalizations.of(context)!.phosphorus,
                        formKey: _formKeyPhosphorus,
                        onChange: (String s) {
                          if (_formKeyPhosphorus.currentState!.validate())
                            context
                                .read<CreateProductCubit>()
                                .builder(product.copyWith(phosphorus: double.parse(s)));
                        },
                        validator: (v) {
                          if (v == null || v == '') return 'wrong';
                          if (!isFloat(v)) return 'wrong';
                        },
                        initialValue: '0.0',
                      ),
                    ),
                  ],
                ),
              ],
            ),
            ExpansionTile(
              collapsedIconColor: Colors.white,
              iconColor: Colors.white,
              tilePadding: EdgeInsets.only(left: 4, right: 8),
              childrenPadding: EdgeInsets.all(0),
              title: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('${AppLocalizations.of(context)!.micro}:',
                      style: Theme.of(context).textTheme.bodyText1),
                ),
              ),
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFieldWithTitle(
                  title: AppLocalizations.of(context)!.iron,
                  formKey: _formKeyIron,
                  onChange: (String s) {
                    if (_formKeyIron.currentState!.validate())
                      context
                          .read<CreateProductCubit>()
                          .builder(product.copyWith(iron: double.parse(s)));
                  },
                  validator: (v) {
                    if (v == null || v == '') return 'wrong';
                    if (!isFloat(v)) return 'wrong';
                  },
                  initialValue: '0.0',
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFieldWithTitle(
                        title: AppLocalizations.of(context)!.copper,
                        formKey: _formKeyCopper,
                        onChange: (String s) {
                          if (_formKeyCopper.currentState!.validate())
                            context
                                .read<CreateProductCubit>()
                                .builder(product.copyWith(copper: double.parse(s)));
                        },
                        validator: (v) {
                          if (v == null || v == '') return 'wrong';
                          if (!isFloat(v)) return 'wrong';
                        },
                        initialValue: '0.0',
                      ),
                    ),
                    Expanded(
                      child: TextFieldWithTitle(
                        title: AppLocalizations.of(context)!.zinc,
                        formKey: _formKeyZinc,
                        onChange: (String s) {
                          if (_formKeyZinc.currentState!.validate())
                            context
                                .read<CreateProductCubit>()
                                .builder(product.copyWith(zinc: double.parse(s)));
                        },
                        validator: (v) {
                          if (v == null || v == '') return 'wrong';
                          if (!isFloat(v)) return 'wrong';
                        },
                        initialValue: '0.0',
                      ),
                    ),
                    Expanded(
                      child: TextFieldWithTitle(
                        title: AppLocalizations.of(context)!.selenium,
                        formKey: _formKeySelenium,
                        onChange: (String s) {
                          if (_formKeySelenium.currentState!.validate())
                            context
                                .read<CreateProductCubit>()
                                .builder(product.copyWith(selenium: double.parse(s)));
                        },
                        validator: (v) {
                          if (v == null || v == '') return 'wrong';
                          if (!isFloat(v)) return 'wrong';
                        },
                        initialValue: '0.0',
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFieldWithTitle(
                        title: AppLocalizations.of(context)!.manganese,
                        formKey: _formKeyManganese,
                        onChange: (String s) {
                          if (_formKeyManganese.currentState!.validate())
                            context
                                .read<CreateProductCubit>()
                                .builder(product.copyWith(manganese: double.parse(s)));
                        },
                        validator: (v) {
                          if (v == null || v == '') return 'wrong';
                          if (!isFloat(v)) return 'wrong';
                        },
                        initialValue: '0.0',
                      ),
                    ),
                    Expanded(
                      child: TextFieldWithTitle(
                        title: AppLocalizations.of(context)!.iodine,
                        formKey: _formKeyIodine,
                        onChange: (String s) {
                          if (_formKeyIodine.currentState!.validate())
                            context
                                .read<CreateProductCubit>()
                                .builder(product.copyWith(iodine: double.parse(s)));
                        },
                        validator: (v) {
                          if (v == null || v == '') return 'wrong';
                          if (!isFloat(v)) return 'wrong';
                        },
                        initialValue: '0.0',
                      ),
                    ),
                    Expanded(
                      child: TextFieldWithTitle(
                        title: AppLocalizations.of(context)!.chromium,
                        formKey: _formKeyChromium,
                        onChange: (String s) {
                          if (_formKeyChromium.currentState!.validate())
                            context
                                .read<CreateProductCubit>()
                                .builder(product.copyWith(chromium: double.parse(s)));
                        },
                        validator: (v) {
                          if (v == null || v == '') return 'wrong';
                          if (!isFloat(v)) return 'wrong';
                        },
                        initialValue: '0.0',
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 264,
            )
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateProductCubit(
        authBloc: context.read<AuthBloc>(),
        productRepository: getIt<ProductRepository>(),
      )..init(product: widget.product, barcode: widget.barcode),
      child: BlocBuilder<CreateProductCubit, CreateProductState>(
        builder: (context, state) {
          return state.maybeWhen(
              orElse: () => Center(child: CustomLoadingWidget()),
              loaded: (product) => Scaffold(
                    appBar: AppBar(
                      title: Text('Create Product'),
                      actions: [
                        IconButton(
                          onPressed: () {
                            if (_formKeyName.currentState!.validate()) {
                              context.read<CreateProductCubit>().create();
                            }
                          },
                          icon: Icon(Icons.save),
                        ),
                      ],
                    ),
                    body: _buildMainPage(product),
                  ));
        },
      ),
    );
  }
}
