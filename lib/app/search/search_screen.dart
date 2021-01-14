import 'package:fitable/app/product/create_product_screen.dart';
import 'package:fitable/app/product/food_screen.dart';
import 'package:fitable/app/product/models/meal_model.dart';
import 'package:fitable/app/product/models/product_model.dart';
import 'package:fitable/app/search/widgets/data_search.dart';
import 'package:fitable/common_widgets/custom_scaffold.dart';
import 'package:fitable/constants/constants.dart';
import 'package:fitable/routers/route_generator.dart';
import 'package:fitable/services/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum SearchType { onlyProducts, allFoods, trainings, users }

class SearchScreenArguments {
  final SearchType typeSearch;
  final MealType mealType;

  SearchScreenArguments({@required this.typeSearch, @required this.mealType});
}

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SearchScreenArguments args = ModalRoute.of(context).settings.arguments;
    return DefaultTabController(
      length: 3,
      child: CustomScaffold(
        appBar: AppBar(
          title: Text(Constants.favorites.tr()),
          actions: [
            IconButton(
                icon: Icon(Icons.search, color: Colors.white),
                onPressed: () async {
                  // FacebookAudienceNetwork.init(
                  //   testingId: "1fc63a78-68f9-4ac1-8faa-6d3688d610aa", //optional
                  // );
                  //
                  // FacebookInterstitialAd.loadInterstitialAd(
                  //   placementId: "1366934306833619_1366944173499299",
                  //   listener: (effect, value) {
                  //     if (effect == InterstitialAdResult.LOADED) FacebookInterstitialAd.showInterstitialAd(delay: 5000);
                  //   },
                  // );

                  dynamic value = await showSearch(context: context, delegate: DataSearch());

                  if (value != null) {
                    Navigator.of(context).pushNamed(AppRoute.foodScreen,
                        arguments: FoodScreenArguments(
                          product: value,
                          mealType: args.mealType,
                        ));
                  }
                }),
            IconButton(
                icon: FaIcon(FontAwesomeIcons.barcode),
                onPressed: () async {
                  String result = await FlutterBarcodeScanner.scanBarcode("#ff6666", "CANCEL", true, ScanMode.BARCODE);

                  if (result != '-1') {
                    final db = context.read(providerDatabase);
                    Product product = await db.getProduct(result);

                    if (product != null) {
                      Navigator.of(context).pushNamed(AppRoute.foodScreen,
                          arguments: FoodScreenArguments(
                            product: product,
                            mealType: args.mealType,
                          ));
                    } else {
                      Navigator.of(context).pushNamed(AppRoute.createProductScreen,
                          arguments: CreateProductScreenArguments(
                            barcode: result,
                            mealType: args.mealType,
                          ));
                    }
                  }
                }),
          ],
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [Tab(text: 'products'.tr()), Tab(text: 'recipes'.tr()), Tab(text: 'your_recipes'.tr())],
          ),
        ),
        body: TabBarView(children: [
          Container(),
          Container(),
          Container(),
        ]),
      ),
    );
  }
}
