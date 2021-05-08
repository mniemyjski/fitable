import 'package:fitable/app/search/view_models/search_view_model.dart';
import 'package:fitable/utilities/enums.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List<Widget> buildActionButtons(BuildContext context, bool mobilePlatform, FavoriteScreen searchType) {
  return [
    IconButton(
        icon: Icon(FontAwesomeIcons.search, color: Colors.white), onPressed: () => context.read(providerSearchViewModel).searchOnPress(context)),
    if (mobilePlatform && (searchType == FavoriteScreen.onlyProducts || searchType == FavoriteScreen.allFoods))
      IconButton(icon: FaIcon(FontAwesomeIcons.barcode), onPressed: () => context.read(providerSearchViewModel).barcodeOnPress(context))
  ];
}
