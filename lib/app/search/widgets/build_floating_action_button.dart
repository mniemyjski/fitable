import 'package:fitable/app/search/view_models/search_view_model.dart';
import 'package:fitable/routers/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

buildFloatingActionButton(BuildContext context) {
  final model = context.read(providerSearchViewModel);

  if (model.selectedIndex == 2) {
    return FloatingActionButton(
      onPressed: () {
        model.selectedIndex = model.controller.index = 0;
        return Navigator.pushNamed(context, AppRoute.recipeCreateScreen);
      },
      child: Icon(Icons.add, color: Colors.white),
    );
  } else {
    return null;
  }
}
