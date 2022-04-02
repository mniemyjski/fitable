// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'dart:typed_data' as _i16;

import 'package:auto_route/auto_route.dart' as _i14;
import 'package:flutter/material.dart' as _i15;

import '../../app/account/screens/account_create_screen.dart' as _i5;
import '../../app/account/screens/my_account_screen.dart' as _i6;
import '../../app/community/screen/community_screen.dart' as _i12;
import '../../app/favorites/screens/favorites_screen.dart' as _i13;
import '../../app/home/screens/create_product_screen.dart' as _i9;
import '../../app/home/screens/food_screen.dart' as _i8;
import '../../app/home/screens/home_screen.dart' as _i3;
import '../../app/image_crop/image_crop_screen.dart' as _i7;
import '../../app/massages/screens/massages_screen.dart' as _i10;
import '../../app/notifications/screens/notifications_screen.dart' as _i11;
import '../../app/settings/screens/settings_screen.dart' as _i4;
import '../../app/sign_in/screens/sign_in_screen.dart' as _i2;
import '../../app/splash/screens/splash_screen.dart' as _i1;

class AppRouter extends _i14.RootStackRouter {
  AppRouter([_i15.GlobalKey<_i15.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i14.PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.SplashScreen());
    },
    SignInRoute.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.SignInScreen());
    },
    HomeRoute.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.HomeScreen());
    },
    SettingsRoute.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData, child: _i4.SettingsScreen());
    },
    AccountCreateRoute.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.AccountCreateScreen());
    },
    MyAccountRoute.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.MyAccountScreen());
    },
    ImageCropRoute.name: (routeData) {
      final args = routeData.argsAs<ImageCropRouteArgs>();
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i7.ImageCropScreen(key: args.key, image: args.image));
    },
    FoodRoute.name: (routeData) {
      final args = routeData.argsAs<FoodRouteArgs>();
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i8.FoodScreen(key: args.key, title: args.title));
    },
    ProductCreateRoute.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i9.ProductCreateScreen());
    },
    MassagesRoute.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i10.MassagesScreen());
    },
    NotificationRoute.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i11.NotificationScreen());
    },
    CommunityRoute.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i12.CommunityScreen());
    },
    FavoritesRoute.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i13.FavoritesScreen());
    }
  };

  @override
  List<_i14.RouteConfig> get routes => [
        _i14.RouteConfig(SplashRoute.name, path: '/'),
        _i14.RouteConfig(SignInRoute.name, path: '/sign-in-screen'),
        _i14.RouteConfig(HomeRoute.name, path: '/home-screen'),
        _i14.RouteConfig(SettingsRoute.name, path: '/settings-screen'),
        _i14.RouteConfig(AccountCreateRoute.name,
            path: '/account-create-screen'),
        _i14.RouteConfig(MyAccountRoute.name, path: '/my-account-screen'),
        _i14.RouteConfig(ImageCropRoute.name, path: '/image-crop-screen'),
        _i14.RouteConfig(FoodRoute.name, path: '/food-screen'),
        _i14.RouteConfig(ProductCreateRoute.name,
            path: '/product-create-screen'),
        _i14.RouteConfig(MassagesRoute.name, path: '/massages-screen'),
        _i14.RouteConfig(NotificationRoute.name, path: '/notification-screen'),
        _i14.RouteConfig(CommunityRoute.name, path: '/community-screen'),
        _i14.RouteConfig(FavoritesRoute.name, path: '/favorites-screen')
      ];
}

/// generated route for
/// [_i1.SplashScreen]
class SplashRoute extends _i14.PageRouteInfo<void> {
  const SplashRoute() : super(SplashRoute.name, path: '/');

  static const String name = 'SplashRoute';
}

/// generated route for
/// [_i2.SignInScreen]
class SignInRoute extends _i14.PageRouteInfo<void> {
  const SignInRoute() : super(SignInRoute.name, path: '/sign-in-screen');

  static const String name = 'SignInRoute';
}

/// generated route for
/// [_i3.HomeScreen]
class HomeRoute extends _i14.PageRouteInfo<void> {
  const HomeRoute() : super(HomeRoute.name, path: '/home-screen');

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i4.SettingsScreen]
class SettingsRoute extends _i14.PageRouteInfo<void> {
  const SettingsRoute() : super(SettingsRoute.name, path: '/settings-screen');

  static const String name = 'SettingsRoute';
}

/// generated route for
/// [_i5.AccountCreateScreen]
class AccountCreateRoute extends _i14.PageRouteInfo<void> {
  const AccountCreateRoute()
      : super(AccountCreateRoute.name, path: '/account-create-screen');

  static const String name = 'AccountCreateRoute';
}

/// generated route for
/// [_i6.MyAccountScreen]
class MyAccountRoute extends _i14.PageRouteInfo<void> {
  const MyAccountRoute()
      : super(MyAccountRoute.name, path: '/my-account-screen');

  static const String name = 'MyAccountRoute';
}

/// generated route for
/// [_i7.ImageCropScreen]
class ImageCropRoute extends _i14.PageRouteInfo<ImageCropRouteArgs> {
  ImageCropRoute({_i15.Key? key, required _i16.Uint8List image})
      : super(ImageCropRoute.name,
            path: '/image-crop-screen',
            args: ImageCropRouteArgs(key: key, image: image));

  static const String name = 'ImageCropRoute';
}

class ImageCropRouteArgs {
  const ImageCropRouteArgs({this.key, required this.image});

  final _i15.Key? key;

  final _i16.Uint8List image;

  @override
  String toString() {
    return 'ImageCropRouteArgs{key: $key, image: $image}';
  }
}

/// generated route for
/// [_i8.FoodScreen]
class FoodRoute extends _i14.PageRouteInfo<FoodRouteArgs> {
  FoodRoute({_i15.Key? key, required String title})
      : super(FoodRoute.name,
            path: '/food-screen', args: FoodRouteArgs(key: key, title: title));

  static const String name = 'FoodRoute';
}

class FoodRouteArgs {
  const FoodRouteArgs({this.key, required this.title});

  final _i15.Key? key;

  final String title;

  @override
  String toString() {
    return 'FoodRouteArgs{key: $key, title: $title}';
  }
}

/// generated route for
/// [_i9.ProductCreateScreen]
class ProductCreateRoute extends _i14.PageRouteInfo<void> {
  const ProductCreateRoute()
      : super(ProductCreateRoute.name, path: '/product-create-screen');

  static const String name = 'ProductCreateRoute';
}

/// generated route for
/// [_i10.MassagesScreen]
class MassagesRoute extends _i14.PageRouteInfo<void> {
  const MassagesRoute() : super(MassagesRoute.name, path: '/massages-screen');

  static const String name = 'MassagesRoute';
}

/// generated route for
/// [_i11.NotificationScreen]
class NotificationRoute extends _i14.PageRouteInfo<void> {
  const NotificationRoute()
      : super(NotificationRoute.name, path: '/notification-screen');

  static const String name = 'NotificationRoute';
}

/// generated route for
/// [_i12.CommunityScreen]
class CommunityRoute extends _i14.PageRouteInfo<void> {
  const CommunityRoute()
      : super(CommunityRoute.name, path: '/community-screen');

  static const String name = 'CommunityRoute';
}

/// generated route for
/// [_i13.FavoritesScreen]
class FavoritesRoute extends _i14.PageRouteInfo<void> {
  const FavoritesRoute()
      : super(FavoritesRoute.name, path: '/favorites-screen');

  static const String name = 'FavoritesRoute';
}
