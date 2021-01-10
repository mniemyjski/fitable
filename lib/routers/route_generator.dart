import 'package:fitable/app/account/goals_screen.dart';
import 'package:fitable/app/account/my_account_screen.dart';
import 'package:fitable/app/account/settings_screen.dart';
import 'package:fitable/app/home/home_screen.dart';
import 'package:fitable/app/product/create_product_screen.dart';
import 'package:fitable/app/product/food_screen.dart';
import 'package:fitable/app/search/search_screen.dart';
import 'package:fitable/app/sign_in/landing_screen.dart';
import 'package:flutter/material.dart';

class AppRoute {
  static const landing = '/';
  static const home = '/HomeScreen';
  static const settings = '/SettingsScreen';
  static const myAccount = '/MyAccountScreen';
  static const goals = '/GoalsScreen';
  static const search = '/SearchScreen';
  static const createProduct = '/CreateProductScreen';
  static const product = '/ProductScreen';
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case AppRoute.landing:
        return MaterialPageRoute(builder: (_) => LandingScreen(body: HomeScreen()));
      case AppRoute.home:
        return MaterialPageRoute(builder: (_) => LandingScreen(body: HomeScreen()));
      case AppRoute.myAccount:
        return MaterialPageRoute(builder: (_) => LandingScreen(body: MyAccountScreen()));
      case AppRoute.settings:
        return MaterialPageRoute(builder: (_) => LandingScreen(body: SettingsScreen()));
      case AppRoute.goals:
        return MaterialPageRoute(builder: (_) => LandingScreen(body: GoalsScreen()));
      case AppRoute.search:
        return MaterialPageRoute(builder: (_) => LandingScreen(body: SearchScreen()));
      case AppRoute.createProduct:
        return MaterialPageRoute<dynamic>(
          builder: (_) => LandingScreen(body: CreateProductScreen(barcode: args)),
          settings: settings,
          // fullscreenDialog: true,
        );
      case AppRoute.product:
        return MaterialPageRoute<dynamic>(
          builder: (_) => LandingScreen(body: FoodScreen(product: args)),
          settings: settings,
        );

        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
