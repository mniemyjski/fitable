// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;

import '../../app/account/screens/account_create_screen.dart' as _i5;
import '../../app/account/screens/my_account_screen.dart' as _i6;
import '../../app/home/screens/home_screen.dart' as _i3;
import '../../app/settings/screens/settings_screen.dart' as _i4;
import '../../app/sign_in/screens/sign_in_screen.dart' as _i2;
import '../../app/splash/screens/splash_screen.dart' as _i1;

class AppRouter extends _i7.RootStackRouter {
  AppRouter([_i8.GlobalKey<_i8.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.SplashScreen());
    },
    SignInRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.SignInScreen());
    },
    HomeRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.HomeScreen());
    },
    SettingsRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: _i4.SettingsScreen());
    },
    AccountCreateRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.AccountCreateScreen());
    },
    MyAccountRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.MyAccountScreen());
    }
  };

  @override
  List<_i7.RouteConfig> get routes => [
        _i7.RouteConfig(SplashRoute.name, path: '/'),
        _i7.RouteConfig(SignInRoute.name, path: '/sign-in-screen'),
        _i7.RouteConfig(HomeRoute.name, path: '/home-screen'),
        _i7.RouteConfig(SettingsRoute.name, path: '/settings-screen'),
        _i7.RouteConfig(AccountCreateRoute.name,
            path: '/account-create-screen'),
        _i7.RouteConfig(MyAccountRoute.name, path: '/my-account-screen')
      ];
}

/// generated route for
/// [_i1.SplashScreen]
class SplashRoute extends _i7.PageRouteInfo<void> {
  const SplashRoute() : super(SplashRoute.name, path: '/');

  static const String name = 'SplashRoute';
}

/// generated route for
/// [_i2.SignInScreen]
class SignInRoute extends _i7.PageRouteInfo<void> {
  const SignInRoute() : super(SignInRoute.name, path: '/sign-in-screen');

  static const String name = 'SignInRoute';
}

/// generated route for
/// [_i3.HomeScreen]
class HomeRoute extends _i7.PageRouteInfo<void> {
  const HomeRoute() : super(HomeRoute.name, path: '/home-screen');

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i4.SettingsScreen]
class SettingsRoute extends _i7.PageRouteInfo<void> {
  const SettingsRoute() : super(SettingsRoute.name, path: '/settings-screen');

  static const String name = 'SettingsRoute';
}

/// generated route for
/// [_i5.AccountCreateScreen]
class AccountCreateRoute extends _i7.PageRouteInfo<void> {
  const AccountCreateRoute()
      : super(AccountCreateRoute.name, path: '/account-create-screen');

  static const String name = 'AccountCreateRoute';
}

/// generated route for
/// [_i6.MyAccountScreen]
class MyAccountRoute extends _i7.PageRouteInfo<void> {
  const MyAccountRoute()
      : super(MyAccountRoute.name, path: '/my-account-screen');

  static const String name = 'MyAccountRoute';
}
