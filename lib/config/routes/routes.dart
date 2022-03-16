import 'package:auto_route/auto_route.dart';
import 'package:fitable/app/account/screens/my_account_screen.dart';
import 'package:fitable/app/home/screens/home_screen.dart';
import 'package:fitable/app/settings/screens/settings_screen.dart';
import 'package:fitable/app/sign_in/screens/sign_in_screen.dart';
import 'package:fitable/app/splash/screens/splash_screen.dart';
import 'package:fitable/app/account/screens/account_create_screen.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: <AutoRoute>[
    AutoRoute(page: SplashScreen, initial: true),
    AutoRoute(page: SignInScreen),
    AutoRoute(page: HomeScreen),
    AutoRoute(page: SettingsScreen),
    AutoRoute(page: AccountCreateScreen),
    AutoRoute(page: MyAccountScreen),
  ],
)
class $AppRouter {}
