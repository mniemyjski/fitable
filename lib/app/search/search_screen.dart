import 'package:fitable/app/home/models/favorite_model.dart';
import 'package:fitable/app/product/create_product_screen.dart';
import 'package:fitable/app/product/food_screen.dart';
import 'package:fitable/app/product/models/meal_model.dart';
import 'package:fitable/app/product/models/product_model.dart';
import 'package:fitable/app/product/widget/tile_product.dart';
import 'package:fitable/app/search/widgets/data_search.dart';
import 'package:fitable/common_widgets/custom_list_view.dart';
import 'package:fitable/common_widgets/custom_scaffold.dart';
import 'package:fitable/constants/constants.dart';
import 'package:fitable/routers/route_generator.dart';
import 'package:fitable/services/providers.dart';
import 'package:flutter/foundation.dart';
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

_onPressed(BuildContext context, dynamic element) {
  final SearchScreenArguments args = ModalRoute.of(context).settings.arguments;

  Navigator.of(context).pushNamed(AppRoute.foodScreen,
      arguments: FoodScreenArguments(
        product: element,
        mealType: args.mealType,
      ));
}

bool mobilePlatform() {
  if (defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS) {
    return true;
  } else {
    return false;
  }
}

_barcodeOnPress(BuildContext context) async {
  String result = await FlutterBarcodeScanner.scanBarcode("#ff6666", "CANCEL", true, ScanMode.BARCODE);
  final SearchScreenArguments args = ModalRoute.of(context).settings.arguments;

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
}

_searchOnPress(BuildContext context) async {
  final SearchScreenArguments args = ModalRoute.of(context).settings.arguments;
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
}

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: CustomScaffold(
        appBar: AppBar(
          title: Text(Constants.favorites.tr()),
          actions: [
            IconButton(icon: Icon(Icons.search, color: Colors.white), onPressed: () => _searchOnPress(context)),
            if (mobilePlatform()) IconButton(icon: FaIcon(FontAwesomeIcons.barcode), onPressed: () => _barcodeOnPress(context)),
          ],
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [Tab(text: 'products'.tr()), Tab(text: 'recipes'.tr()), Tab(text: 'your_recipes'.tr())],
          ),
        ),
        body: Consumer(builder: (context, watch, child) {
          final favorites = watch(providerFavorite);
          final db = watch(providerDatabase);

          return favorites.when(
            data: (data) => TabBarView(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: StreamBuilder<List<Product>>(
                    stream: db.streamProducts(data),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting)
                        return Center(child: Container(height: 100, width: 100, child: CircularProgressIndicator()));
                      if (snapshot.hasData) {
                        return CustomListView(
                          list: snapshot.data,
                          type: EnumTileType.product,
                          direction: DismissDirection.none,
                          onPressed: (element) => _onPressed(context, element),
                        );
                      }
                      return Container();
                    }),
              ),
              Container(),
              Container(),
            ]),
            loading: () => Center(child: Container(height: 100, width: 100, child: CircularProgressIndicator())),
            error: (err, stack) => Center(child: Text('Error: $err')),
          );
        }),
      ),
    );
  }
}
