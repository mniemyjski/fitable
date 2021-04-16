import 'package:fitable/app/account/account_details_screen.dart';
import 'package:fitable/app/account/goals_macro_screen.dart';
import 'package:fitable/app/account/goals_screen.dart';
import 'package:fitable/app/account/my_account_screen.dart';
import 'package:fitable/app/account/settings_screen.dart';
import 'package:fitable/app/board/board_screen.dart';
import 'package:fitable/app/community/community_screen.dart';
import 'package:fitable/app/crop_image/crop_image_screen.dart';
import 'package:fitable/app/diets/diets_screen.dart';
import 'package:fitable/app/home/home_screen.dart';
import 'package:fitable/app/massage/massages_screen.dart';
import 'package:fitable/app/measurement/add_body_circumferences_screen.dart';
import 'package:fitable/app/notification/notifications_screen.dart';
import 'package:fitable/app/product/product_create_screen.dart';
import 'package:fitable/app/product/product_details_screen.dart';
import 'package:fitable/app/recipe/recipe_create_screen.dart';
import 'package:fitable/app/recipe/recipe_details_screen.dart';
import 'package:fitable/app/recipe/recipes_screen.dart';
import 'package:fitable/app/search/search_screen.dart';
import 'package:fitable/app/sign_in/landing_screen.dart';
import 'package:fitable/app/statistics/statistics_screen.dart';
import 'package:fitable/app/workout/workouts_screen.dart';
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
  static const cropImageScreen = '/cropImageScreen';
  static const massages = '/massages';
  static const notifications = '/notifications';
  static const board = '/board';
  static const statistics = '/statistics';
  static const accountDetails = '/accountDetails';
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
  AppRoute.cropImageScreen: (context) => LandingScreen(body: CropImageScreen()),
  AppRoute.notifications: (context) => LandingScreen(body: NotificationScreen()),
  AppRoute.massages: (context) => LandingScreen(body: MassagesScreen()),
  AppRoute.board: (context) => LandingScreen(body: BoardScreen()),
  AppRoute.statistics: (context) => LandingScreen(body: StatisticsScreen()),
  AppRoute.accountDetails: (context) => LandingScreen(body: AccountDetailsScreen()),
};
