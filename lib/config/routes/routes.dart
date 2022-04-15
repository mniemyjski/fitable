import 'package:auto_route/auto_route.dart';
import 'package:fitable/app/favorites/screens/favorites_screen.dart';
import 'package:fitable/app/home/screens/diets_screen.dart';
import 'package:fitable/app/home/screens/recipe_create_screen.dart';
import 'package:fitable/app/home/screens/recipes_screen.dart';
import 'package:fitable/app/intro/intro_screen.dart';
import 'package:fitable/app/workout/screens/exercise_screen.dart';
import 'package:fitable/app/workout/screens/workouts_screen.dart';

import '../../app/account/screens/account_create_screen.dart';
import '../../app/account/screens/my_account_screen.dart';
import '../../app/community/screen/community_screen.dart';
import '../../app/home/screens/create_product_screen.dart';
import '../../app/home/screens/food_screen.dart';
import '../../app/home/screens/home_screen.dart';
import '../../app/image_crop/image_crop_screen.dart';
import '../../app/massages/screens/massages_screen.dart';
import '../../app/notifications/screens/notifications_screen.dart';
import '../../app/settings/screens/settings_screen.dart';
import '../../app/sign_in/screens/sign_in_screen.dart';
import '../../app/splash/screens/splash_screen.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: <AutoRoute>[
    AutoRoute(page: SplashScreen, initial: true),
    AutoRoute(page: SignInScreen),
    AutoRoute(page: HomeScreen),
    AutoRoute(page: SettingsScreen),
    AutoRoute(page: AccountCreateScreen),
    AutoRoute(page: MyAccountScreen),
    AutoRoute(page: ImageCropScreen),
    AutoRoute(page: FoodScreen),
    AutoRoute(page: ProductCreateScreen),
    AutoRoute(page: RecipeCreateScreen),
    AutoRoute(page: MassagesScreen),
    AutoRoute(page: NotificationScreen),
    AutoRoute(page: CommunityScreen),
    AutoRoute(page: FavoritesScreen),
    AutoRoute(page: IntroScreen),
    AutoRoute(page: DietsScreen),
    AutoRoute(page: RecipesScreen),
    AutoRoute(page: WorkoutsScreen),
    AutoRoute(page: ExerciseScreen),
  ],
)
class $AppRouter {}
