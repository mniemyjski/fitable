// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'dart:typed_data' as _i24;

import 'package:auto_route/auto_route.dart' as _i22;
import 'package:flutter/material.dart' as _i23;

import '../../app/account/screens/account_create_screen.dart' as _i5;
import '../../app/account/screens/my_account_screen.dart' as _i6;
import '../../app/community/screen/community_screen.dart' as _i13;
import '../../app/favorites/screens/favorites_screen.dart' as _i14;
import '../../app/favorites/widgets/favorite_tab_bar.dart' as _i26;
import '../../app/home/models/portions/portion_model.dart' as _i27;
import '../../app/home/models/product/product_model.dart' as _i25;
import '../../app/home/screens/create_product_screen.dart' as _i9;
import '../../app/home/screens/diets_screen.dart' as _i16;
import '../../app/home/screens/food_screen.dart' as _i8;
import '../../app/home/screens/home_screen.dart' as _i3;
import '../../app/home/screens/key_words_screen.dart' as _i21;
import '../../app/home/screens/portions_screen.dart' as _i20;
import '../../app/home/screens/recipe_create_screen.dart' as _i10;
import '../../app/home/screens/recipes_screen.dart' as _i17;
import '../../app/image_crop/image_crop_screen.dart' as _i7;
import '../../app/intro/intro_screen.dart' as _i15;
import '../../app/massages/screens/massages_screen.dart' as _i11;
import '../../app/notifications/screens/notifications_screen.dart' as _i12;
import '../../app/settings/screens/settings_screen.dart' as _i4;
import '../../app/sign_in/screens/sign_in_screen.dart' as _i2;
import '../../app/splash/screens/splash_screen.dart' as _i1;
import '../../app/workout/screens/exercise_screen.dart' as _i19;
import '../../app/workout/screens/workouts_screen.dart' as _i18;

class AppRouter extends _i22.RootStackRouter {
  AppRouter([_i23.GlobalKey<_i23.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i22.PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return _i22.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.SplashScreen());
    },
    SignInRoute.name: (routeData) {
      return _i22.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.SignInScreen());
    },
    HomeRoute.name: (routeData) {
      return _i22.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.HomeScreen());
    },
    SettingsRoute.name: (routeData) {
      return _i22.MaterialPageX<dynamic>(
          routeData: routeData, child: _i4.SettingsScreen());
    },
    AccountCreateRoute.name: (routeData) {
      return _i22.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.AccountCreateScreen());
    },
    MyAccountRoute.name: (routeData) {
      return _i22.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.MyAccountScreen());
    },
    ImageCropRoute.name: (routeData) {
      final args = routeData.argsAs<ImageCropRouteArgs>();
      return _i22.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i7.ImageCropScreen(key: args.key, image: args.image));
    },
    FoodRoute.name: (routeData) {
      final args = routeData.argsAs<FoodRouteArgs>();
      return _i22.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i8.FoodScreen(key: args.key, title: args.title));
    },
    ProductCreateRoute.name: (routeData) {
      final args = routeData.argsAs<ProductCreateRouteArgs>(
          orElse: () => const ProductCreateRouteArgs());
      return _i22.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i9.ProductCreateScreen(key: args.key, product: args.product));
    },
    RecipeCreateRoute.name: (routeData) {
      return _i22.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i10.RecipeCreateScreen());
    },
    MassagesRoute.name: (routeData) {
      return _i22.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i11.MassagesScreen());
    },
    NotificationRoute.name: (routeData) {
      return _i22.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i12.NotificationScreen());
    },
    CommunityRoute.name: (routeData) {
      return _i22.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i13.CommunityScreen());
    },
    FavoritesRoute.name: (routeData) {
      final args = routeData.argsAs<FavoritesRouteArgs>();
      return _i22.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i14.FavoritesScreen(
              key: args.key, eTypeTabBar: args.eTypeTabBar));
    },
    IntroRoute.name: (routeData) {
      return _i22.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i15.IntroScreen());
    },
    DietsRoute.name: (routeData) {
      return _i22.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i16.DietsScreen());
    },
    RecipesRoute.name: (routeData) {
      return _i22.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i17.RecipesScreen());
    },
    WorkoutsRoute.name: (routeData) {
      return _i22.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i18.WorkoutsScreen());
    },
    ExerciseRoute.name: (routeData) {
      return _i22.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i19.ExerciseScreen());
    },
    PortionsRoute.name: (routeData) {
      final args = routeData.argsAs<PortionsRouteArgs>();
      return _i22.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i20.PortionsScreen(key: args.key, list: args.list));
    },
    KeyWordsRoute.name: (routeData) {
      final args = routeData.argsAs<KeyWordsRouteArgs>();
      return _i22.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i21.KeyWordsScreen(key: args.key, list: args.list));
    }
  };

  @override
  List<_i22.RouteConfig> get routes => [
        _i22.RouteConfig(SplashRoute.name, path: '/'),
        _i22.RouteConfig(SignInRoute.name, path: '/sign-in-screen'),
        _i22.RouteConfig(HomeRoute.name, path: '/home-screen'),
        _i22.RouteConfig(SettingsRoute.name, path: '/settings-screen'),
        _i22.RouteConfig(AccountCreateRoute.name,
            path: '/account-create-screen'),
        _i22.RouteConfig(MyAccountRoute.name, path: '/my-account-screen'),
        _i22.RouteConfig(ImageCropRoute.name, path: '/image-crop-screen'),
        _i22.RouteConfig(FoodRoute.name, path: '/food-screen'),
        _i22.RouteConfig(ProductCreateRoute.name,
            path: '/product-create-screen'),
        _i22.RouteConfig(RecipeCreateRoute.name, path: '/recipe-create-screen'),
        _i22.RouteConfig(MassagesRoute.name, path: '/massages-screen'),
        _i22.RouteConfig(NotificationRoute.name, path: '/notification-screen'),
        _i22.RouteConfig(CommunityRoute.name, path: '/community-screen'),
        _i22.RouteConfig(FavoritesRoute.name, path: '/favorites-screen'),
        _i22.RouteConfig(IntroRoute.name, path: '/intro-screen'),
        _i22.RouteConfig(DietsRoute.name, path: '/diets-screen'),
        _i22.RouteConfig(RecipesRoute.name, path: '/recipes-screen'),
        _i22.RouteConfig(WorkoutsRoute.name, path: '/workouts-screen'),
        _i22.RouteConfig(ExerciseRoute.name, path: '/exercise-screen'),
        _i22.RouteConfig(PortionsRoute.name, path: '/portions-screen'),
        _i22.RouteConfig(KeyWordsRoute.name, path: '/key-words-screen')
      ];
}

/// generated route for
/// [_i1.SplashScreen]
class SplashRoute extends _i22.PageRouteInfo<void> {
  const SplashRoute() : super(SplashRoute.name, path: '/');

  static const String name = 'SplashRoute';
}

/// generated route for
/// [_i2.SignInScreen]
class SignInRoute extends _i22.PageRouteInfo<void> {
  const SignInRoute() : super(SignInRoute.name, path: '/sign-in-screen');

  static const String name = 'SignInRoute';
}

/// generated route for
/// [_i3.HomeScreen]
class HomeRoute extends _i22.PageRouteInfo<void> {
  const HomeRoute() : super(HomeRoute.name, path: '/home-screen');

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i4.SettingsScreen]
class SettingsRoute extends _i22.PageRouteInfo<void> {
  const SettingsRoute() : super(SettingsRoute.name, path: '/settings-screen');

  static const String name = 'SettingsRoute';
}

/// generated route for
/// [_i5.AccountCreateScreen]
class AccountCreateRoute extends _i22.PageRouteInfo<void> {
  const AccountCreateRoute()
      : super(AccountCreateRoute.name, path: '/account-create-screen');

  static const String name = 'AccountCreateRoute';
}

/// generated route for
/// [_i6.MyAccountScreen]
class MyAccountRoute extends _i22.PageRouteInfo<void> {
  const MyAccountRoute()
      : super(MyAccountRoute.name, path: '/my-account-screen');

  static const String name = 'MyAccountRoute';
}

/// generated route for
/// [_i7.ImageCropScreen]
class ImageCropRoute extends _i22.PageRouteInfo<ImageCropRouteArgs> {
  ImageCropRoute({_i23.Key? key, required _i24.Uint8List image})
      : super(ImageCropRoute.name,
            path: '/image-crop-screen',
            args: ImageCropRouteArgs(key: key, image: image));

  static const String name = 'ImageCropRoute';
}

class ImageCropRouteArgs {
  const ImageCropRouteArgs({this.key, required this.image});

  final _i23.Key? key;

  final _i24.Uint8List image;

  @override
  String toString() {
    return 'ImageCropRouteArgs{key: $key, image: $image}';
  }
}

/// generated route for
/// [_i8.FoodScreen]
class FoodRoute extends _i22.PageRouteInfo<FoodRouteArgs> {
  FoodRoute({_i23.Key? key, required String title})
      : super(FoodRoute.name,
            path: '/food-screen', args: FoodRouteArgs(key: key, title: title));

  static const String name = 'FoodRoute';
}

class FoodRouteArgs {
  const FoodRouteArgs({this.key, required this.title});

  final _i23.Key? key;

  final String title;

  @override
  String toString() {
    return 'FoodRouteArgs{key: $key, title: $title}';
  }
}

/// generated route for
/// [_i9.ProductCreateScreen]
class ProductCreateRoute extends _i22.PageRouteInfo<ProductCreateRouteArgs> {
  ProductCreateRoute({_i23.Key? key, _i25.Product? product})
      : super(ProductCreateRoute.name,
            path: '/product-create-screen',
            args: ProductCreateRouteArgs(key: key, product: product));

  static const String name = 'ProductCreateRoute';
}

class ProductCreateRouteArgs {
  const ProductCreateRouteArgs({this.key, this.product});

  final _i23.Key? key;

  final _i25.Product? product;

  @override
  String toString() {
    return 'ProductCreateRouteArgs{key: $key, product: $product}';
  }
}

/// generated route for
/// [_i10.RecipeCreateScreen]
class RecipeCreateRoute extends _i22.PageRouteInfo<void> {
  const RecipeCreateRoute()
      : super(RecipeCreateRoute.name, path: '/recipe-create-screen');

  static const String name = 'RecipeCreateRoute';
}

/// generated route for
/// [_i11.MassagesScreen]
class MassagesRoute extends _i22.PageRouteInfo<void> {
  const MassagesRoute() : super(MassagesRoute.name, path: '/massages-screen');

  static const String name = 'MassagesRoute';
}

/// generated route for
/// [_i12.NotificationScreen]
class NotificationRoute extends _i22.PageRouteInfo<void> {
  const NotificationRoute()
      : super(NotificationRoute.name, path: '/notification-screen');

  static const String name = 'NotificationRoute';
}

/// generated route for
/// [_i13.CommunityScreen]
class CommunityRoute extends _i22.PageRouteInfo<void> {
  const CommunityRoute()
      : super(CommunityRoute.name, path: '/community-screen');

  static const String name = 'CommunityRoute';
}

/// generated route for
/// [_i14.FavoritesScreen]
class FavoritesRoute extends _i22.PageRouteInfo<FavoritesRouteArgs> {
  FavoritesRoute({_i23.Key? key, required _i26.ETypeTabBar eTypeTabBar})
      : super(FavoritesRoute.name,
            path: '/favorites-screen',
            args: FavoritesRouteArgs(key: key, eTypeTabBar: eTypeTabBar));

  static const String name = 'FavoritesRoute';
}

class FavoritesRouteArgs {
  const FavoritesRouteArgs({this.key, required this.eTypeTabBar});

  final _i23.Key? key;

  final _i26.ETypeTabBar eTypeTabBar;

  @override
  String toString() {
    return 'FavoritesRouteArgs{key: $key, eTypeTabBar: $eTypeTabBar}';
  }
}

/// generated route for
/// [_i15.IntroScreen]
class IntroRoute extends _i22.PageRouteInfo<void> {
  const IntroRoute() : super(IntroRoute.name, path: '/intro-screen');

  static const String name = 'IntroRoute';
}

/// generated route for
/// [_i16.DietsScreen]
class DietsRoute extends _i22.PageRouteInfo<void> {
  const DietsRoute() : super(DietsRoute.name, path: '/diets-screen');

  static const String name = 'DietsRoute';
}

/// generated route for
/// [_i17.RecipesScreen]
class RecipesRoute extends _i22.PageRouteInfo<void> {
  const RecipesRoute() : super(RecipesRoute.name, path: '/recipes-screen');

  static const String name = 'RecipesRoute';
}

/// generated route for
/// [_i18.WorkoutsScreen]
class WorkoutsRoute extends _i22.PageRouteInfo<void> {
  const WorkoutsRoute() : super(WorkoutsRoute.name, path: '/workouts-screen');

  static const String name = 'WorkoutsRoute';
}

/// generated route for
/// [_i19.ExerciseScreen]
class ExerciseRoute extends _i22.PageRouteInfo<void> {
  const ExerciseRoute() : super(ExerciseRoute.name, path: '/exercise-screen');

  static const String name = 'ExerciseRoute';
}

/// generated route for
/// [_i20.PortionsScreen]
class PortionsRoute extends _i22.PageRouteInfo<PortionsRouteArgs> {
  PortionsRoute({_i23.Key? key, required List<_i27.Portion> list})
      : super(PortionsRoute.name,
            path: '/portions-screen',
            args: PortionsRouteArgs(key: key, list: list));

  static const String name = 'PortionsRoute';
}

class PortionsRouteArgs {
  const PortionsRouteArgs({this.key, required this.list});

  final _i23.Key? key;

  final List<_i27.Portion> list;

  @override
  String toString() {
    return 'PortionsRouteArgs{key: $key, list: $list}';
  }
}

/// generated route for
/// [_i21.KeyWordsScreen]
class KeyWordsRoute extends _i22.PageRouteInfo<KeyWordsRouteArgs> {
  KeyWordsRoute({_i23.Key? key, required List<String> list})
      : super(KeyWordsRoute.name,
            path: '/key-words-screen',
            args: KeyWordsRouteArgs(key: key, list: list));

  static const String name = 'KeyWordsRoute';
}

class KeyWordsRouteArgs {
  const KeyWordsRouteArgs({this.key, required this.list});

  final _i23.Key? key;

  final List<String> list;

  @override
  String toString() {
    return 'KeyWordsRouteArgs{key: $key, list: $list}';
  }
}
