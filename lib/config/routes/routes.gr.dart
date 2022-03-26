// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'dart:typed_data' as _i10;

import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/material.dart' as _i9;

import '../../app/account/screens/account_create_screen.dart' as _i5;
import '../../app/account/screens/my_account_screen.dart' as _i6;
import '../../app/home/screens/home_screen.dart' as _i3;
import '../../app/image_crop/image_crop_screen.dart' as _i7;
import '../../app/settings/screens/settings_screen.dart' as _i4;
import '../../app/sign_in/screens/sign_in_screen.dart' as _i2;
import '../../app/splash/screens/splash_screen.dart' as _i1;

class AppRouter extends _i8.RootStackRouter {
  AppRouter([_i9.GlobalKey<_i9.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i8.PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.SplashScreen());
    },
    SignInRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.SignInScreen());
    },
    HomeRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.HomeScreen());
    },
    SettingsRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: _i4.SettingsScreen());
    },
    AccountCreateRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.AccountCreateScreen());
    },
    MyAccountRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.MyAccountScreen());
    },
    ImageCropRoute.name: (routeData) {
      final args = routeData.argsAs<ImageCropRouteArgs>();
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i7.ImageCropScreen(key: args.key, image: args.image));
    }
  };

  @override
  List<_i8.RouteConfig> get routes => [
        _i8.RouteConfig(SplashRoute.name, path: '/'),
        _i8.RouteConfig(SignInRoute.name, path: '/sign-in-screen'),
        _i8.RouteConfig(HomeRoute.name, path: '/home-screen'),
        _i8.RouteConfig(SettingsRoute.name, path: '/settings-screen'),
        _i8.RouteConfig(AccountCreateRoute.name,
            path: '/account-create-screen'),
        _i8.RouteConfig(MyAccountRoute.name, path: '/my-account-screen'),
        _i8.RouteConfig(ImageCropRoute.name, path: '/image-crop-screen')
      ];
}

/// generated route for
/// [_i1.SplashScreen]
class SplashRoute extends _i8.PageRouteInfo<void> {
  const SplashRoute() : super(SplashRoute.name, path: '/');

  static const String name = 'SplashRoute';
}

/// generated route for
/// [_i2.SignInScreen]
class SignInRoute extends _i8.PageRouteInfo<void> {
  const SignInRoute() : super(SignInRoute.name, path: '/sign-in-screen');

  static const String name = 'SignInRoute';
}

/// generated route for
/// [_i3.HomeScreen]
class HomeRoute extends _i8.PageRouteInfo<void> {
  const HomeRoute() : super(HomeRoute.name, path: '/home-screen');

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i4.SettingsScreen]
class SettingsRoute extends _i8.PageRouteInfo<void> {
  const SettingsRoute() : super(SettingsRoute.name, path: '/settings-screen');

  static const String name = 'SettingsRoute';
}

/// generated route for
/// [_i5.AccountCreateScreen]
class AccountCreateRoute extends _i8.PageRouteInfo<void> {
  const AccountCreateRoute()
      : super(AccountCreateRoute.name, path: '/account-create-screen');

  static const String name = 'AccountCreateRoute';
}

/// generated route for
/// [_i6.MyAccountScreen]
class MyAccountRoute extends _i8.PageRouteInfo<void> {
  const MyAccountRoute()
      : super(MyAccountRoute.name, path: '/my-account-screen');

  static const String name = 'MyAccountRoute';
}

/// generated route for
/// [_i7.ImageCropScreen]
class ImageCropRoute extends _i8.PageRouteInfo<ImageCropRouteArgs> {
  ImageCropRoute({_i9.Key? key, required _i10.Uint8List image})
      : super(ImageCropRoute.name,
            path: '/image-crop-screen',
            args: ImageCropRouteArgs(key: key, image: image));

  static const String name = 'ImageCropRoute';
}

class ImageCropRouteArgs {
  const ImageCropRouteArgs({this.key, required this.image});

  final _i9.Key? key;

  final _i10.Uint8List image;

  @override
  String toString() {
    return 'ImageCropRouteArgs{key: $key, image: $image}';
  }
}
