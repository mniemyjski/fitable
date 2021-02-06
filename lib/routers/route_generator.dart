import 'package:fitable/app/account/goals_macro_screen.dart';
import 'package:fitable/app/account/goals_screen.dart';
import 'package:fitable/app/account/my_account_screen.dart';
import 'package:fitable/app/account/settings_screen.dart';
import 'package:fitable/app/community/community_screen.dart';
import 'package:fitable/app/diets/diets_screen.dart';
import 'package:fitable/app/home/home_screen.dart';
import 'package:fitable/app/measurement/add_body_circumferences_screen.dart';
import 'package:fitable/app/product/product_create_screen.dart';
import 'package:fitable/app/product/product_details_screen.dart';
import 'package:fitable/app/recipe/recipe_create_screen.dart';
import 'package:fitable/app/recipe/recipe_details_screen.dart';
import 'package:fitable/app/recipe/recipes_screen.dart';
import 'package:fitable/app/search/search_screen.dart';
import 'package:fitable/app/sign_in/landing_screen.dart';
import 'package:fitable/app/workouts/workouts_screen.dart';
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
  static const productDetailsScreen = '/productDetailsScreen';
  static const addBodyCircumferencesScreen = '/AddBodyCircumferencesScreen';
  static const communityScreen = '/communityScreen';
  static const recipeScreen = '/recipeScreen';
  static const recipeDetailsScreen = '/recipeDetailsScreen';
  static const recipeCreateScreen = '/recipeCreateScreen';
  static const workoutsScreen = '/workoutsScreen';
  static const dietsScreen = '/dietsScreen';
}

var routes = <String, WidgetBuilder>{
  '/': (context) => LandingScreen(body: HomeScreen()),
  AppRoute.homeScreen: (context) => LandingScreen(body: HomeScreen()),
  AppRoute.myAccountScreen: (context) => LandingScreen(body: MyAccountScreen()),
  AppRoute.settingsScreen: (context) => LandingScreen(body: SettingsScreen()),
  AppRoute.goalsScreen: (context) => LandingScreen(body: GoalsScreen()),
  AppRoute.searchScreen: (context) => LandingScreen(body: SearchScreen()),
  AppRoute.createProductScreen: (context) => LandingScreen(body: ProductCreateScreen()),
  AppRoute.productDetailsScreen: (context) => LandingScreen(body: ProductDetailsScreen()),
  AppRoute.goalsMacroScreen: (context) => LandingScreen(body: GoalsMacroScreen()),
  AppRoute.addBodyCircumferencesScreen: (context) => LandingScreen(body: AddBodyCircumferencesScreen()),
  AppRoute.communityScreen: (context) => LandingScreen(body: CommunityScreen()),
  AppRoute.recipeScreen: (context) => LandingScreen(body: RecipesScreen()),
  AppRoute.recipeDetailsScreen: (context) => LandingScreen(body: RecipeDetailsScreen()),
  AppRoute.recipeCreateScreen: (context) => LandingScreen(body: RecipeCreateScreen()),
  AppRoute.workoutsScreen: (context) => LandingScreen(body: WorkoutsScreen()),
  AppRoute.dietsScreen: (context) => LandingScreen(body: DietsScreen()),
};

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
        return MaterialPageRoute(builder: (_) => LandingScreen(body: ProductCreateScreen()), settings: settings);
      case AppRoute.productDetailsScreen:
        return MaterialPageRoute(builder: (_) => LandingScreen(body: ProductDetailsScreen()), settings: settings);
      case AppRoute.goalsMacroScreen:
        return MaterialPageRoute(builder: (_) => LandingScreen(body: GoalsMacroScreen()), settings: settings);
      case AppRoute.addBodyCircumferencesScreen:
        return MaterialPageRoute(builder: (_) => LandingScreen(body: AddBodyCircumferencesScreen()), settings: settings);
      case AppRoute.communityScreen:
        return MaterialPageRoute(builder: (_) => LandingScreen(body: CommunityScreen()));
      case AppRoute.recipeScreen:
        return MaterialPageRoute(builder: (_) => LandingScreen(body: RecipesScreen()));
      case AppRoute.recipeDetailsScreen:
        return MaterialPageRoute(builder: (_) => LandingScreen(body: RecipeDetailsScreen()));
      case AppRoute.recipeCreateScreen:
        return MaterialPageRoute(builder: (_) => LandingScreen(body: RecipeCreateScreen()));
      case AppRoute.workoutsScreen:
        return MaterialPageRoute(builder: (_) => LandingScreen(body: WorkoutsScreen()));
      case AppRoute.dietsScreen:
        return MaterialPageRoute(builder: (_) => LandingScreen(body: DietsScreen()));
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
