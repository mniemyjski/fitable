import 'package:fitable/app/product/product_create_screen.dart';
import 'package:fitable/app/product/models/product_model.dart';
import 'package:fitable/app/product/product_details_screen.dart';
import 'package:fitable/app/search/search_screen.dart';
import 'package:fitable/app/search/widgets/data_search.dart';
import 'package:fitable/routers/route_generator.dart';
import 'package:fitable/services/providers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final providerSearchViewModel = ChangeNotifierProvider.autoDispose<SearchViewModel>((ref) {
  return SearchViewModel();
});

class SearchViewModel extends ChangeNotifier {
  TabController controller;
  int selectedIndex;
  List<Widget> list = [];

  onPressed(BuildContext context, dynamic element) {
    final SearchScreenArguments args = ModalRoute.of(context).settings.arguments;
    selectedIndex = controller.index = 0;
    Navigator.of(context).pushNamed(AppRoute.productDetailsScreen,
        arguments: ProductDetailsScreenArguments(
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

  barcodeOnPress(BuildContext context) async {
    String result = await FlutterBarcodeScanner.scanBarcode("#ff6666", "CANCEL", true, ScanMode.BARCODE);
    final SearchScreenArguments args = ModalRoute.of(context).settings.arguments;
    selectedIndex = controller.index = 0;
    if (result != '-1') {
      final db = context.read(providerDatabase);
      Product product = await db.getProduct(result);

      if (product != null) {
        Navigator.of(context).pushNamed(AppRoute.productDetailsScreen,
            arguments: ProductDetailsScreenArguments(
              product: product,
              mealType: args.mealType,
            ));
      } else {
        Navigator.of(context).pushNamed(AppRoute.createProductScreen,
            arguments: ProductCreateScreenArguments(
              barcode: result,
              mealType: args.mealType,
            ));
      }
    }
  }

  searchOnPress(BuildContext context) async {
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
    selectedIndex = controller.index = 0;
    dynamic value = await showSearch(context: context, delegate: DataSearch());

    if (value != null) {
      Navigator.of(context).pushNamed(AppRoute.productDetailsScreen,
          arguments: ProductDetailsScreenArguments(
            product: value,
            mealType: args.mealType,
          ));
    }
  }
}
