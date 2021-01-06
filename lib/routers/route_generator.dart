import 'package:fitable/app/home/home_screen.dart';
import 'package:fitable/app/settings/settings_screen.dart';
import 'package:fitable/app/sign_in/landing_screen.dart';
import 'package:flutter/material.dart';

class AppRoute {
  static const landing = '/';
  static const home = '/HomeScreen';
  static const settings = '/SettingsScreen';
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case AppRoute.landing:
        return MaterialPageRoute(builder: (_) => LandingScreen(body: HomeScreen()));
      case AppRoute.home:
        return MaterialPageRoute(builder: (_) => LandingScreen(body: HomeScreen()));
      case AppRoute.settings:
        return MaterialPageRoute(builder: (_) => LandingScreen(body: SettingsScreen()));

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
