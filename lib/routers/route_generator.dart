import 'package:fitable/app/account/goals_macro_screen.dart';
import 'package:fitable/app/account/goals_screen.dart';
import 'package:fitable/app/account/my_account_screen.dart';
import 'package:fitable/app/account/settings_screen.dart';
import 'package:fitable/app/home/add_body_circumferences_screen.dart';
import 'package:fitable/app/home/home_screen.dart';
import 'package:fitable/app/product/create_product_screen.dart';
import 'package:fitable/app/product/food_screen.dart';
import 'package:fitable/app/search/search_screen.dart';
import 'package:fitable/app/sign_in/landing_screen.dart';
import 'package:flutter/material.dart';

class AppRoute {
  static const landing = '/';
  static const homeScreen = '/HomeScreen';
  static const settingsScreen = '/SettingsScreen';
  static const myAccountScreen = '/MyAccountScreen';
  static const goalsScreen = '/GoalsScreen';
  static const goalsMacroScreen = '/GoalsMacroScreen';
  static const searchScreen = '/SearchScreen';
  static const createProductScreen = '/CreateProductScreen';
  static const foodScreen = '/FoodScreen';
  static const addBodyCircumferencesScreen = '/AddBodyCircumferencesScreen';
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoute.landing:
        return MaterialPageRoute(builder: (_) => LandingScreen(body: HomeScreen()));
      case AppRoute.homeScreen:
        return MaterialPageRoute(builder: (_) => LandingScreen(body: HomeScreen()));
      case AppRoute.myAccountScreen:
        return MaterialPageRoute(builder: (_) => LandingScreen(body: MyAccountScreen()));
      case AppRoute.settingsScreen:
        return MaterialPageRoute(builder: (_) => LandingScreen(body: SettingsScreen()));
      case AppRoute.goalsScreen:
        return MaterialPageRoute(builder: (_) => LandingScreen(body: GoalsScreen()));
      case AppRoute.searchScreen:
        return MaterialPageRoute(builder: (_) => LandingScreen(body: SearchScreen()), settings: settings);
      case AppRoute.createProductScreen:
        return MaterialPageRoute(builder: (_) => LandingScreen(body: CreateProductScreen()), settings: settings);
      case AppRoute.foodScreen:
        return MaterialPageRoute(builder: (_) => LandingScreen(body: FoodScreen()), settings: settings);
      case AppRoute.goalsMacroScreen:
        return MaterialPageRoute(builder: (_) => LandingScreen(body: GoalsMacroScreen()), settings: settings);
      case AppRoute.addBodyCircumferencesScreen:
        return MaterialPageRoute(builder: (_) => LandingScreen(body: AddBodyCircumferencesScreen()), settings: settings);
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
