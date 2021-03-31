import 'package:algolia/algolia.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:fitable/app/product/widget/tile_product.dart';
import 'package:fitable/app/search/view_models/search_view_model.dart';
import 'package:fitable/constants/constants.dart';
import 'package:fitable/constants/enum.dart';
import 'package:fitable/services/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DataSearch extends SearchDelegate {
  _massage(BuildContext context, String txt) {
    FocusScope.of(context).requestFocus(FocusNode());
    Flushbar(
      margin: EdgeInsets.only(bottom: 8, left: 8, right: 8),
      animationDuration: Duration(milliseconds: 700),
      message: txt,
      duration: Duration(seconds: 2),
    )..show(context);
    query = "";
  }

  _searchProductOrRecipe(BuildContext context, bool state, SearchViewModel model) {
    context.read(providerSearchViewModel).recipes = state;

    if (model.recipes) {
      _massage(context, Constants.search_recipes());
    } else {
      _massage(context, Constants.search_products());
    }
    query = "";
  }

  void _verification(BuildContext context, bool state, SearchViewModel model) {
    context.read(providerSearchViewModel).verification = state;
    if (model.verification) _massage(context, Constants.search_verification_product_only());
  }

  void _withBarcode(BuildContext context, bool state, SearchViewModel model) {
    context.read(providerSearchViewModel).withBarcode = state;
    if (model.withBarcode) _massage(context, Constants.search_product_only_with_barcode());
  }

  _sliderMenu(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final model = watch(providerSearchViewModel);

      return Container(
        margin: EdgeInsets.only(right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            if (model.searchType == SearchType.allFoods) ...[
              Icon(Icons.fastfood, color: Colors.lightBlue[800]),
              Switch(value: model.recipes, onChanged: (state) => _searchProductOrRecipe(context, state, model)),
            ],
            FaIcon(FontAwesomeIcons.barcode, color: Colors.lightBlue[800]),
            Switch(value: model.withBarcode, onChanged: (state) => _withBarcode(context, state, model)),
            Icon(Icons.verified_user, color: Colors.lightBlue[800]),
            Switch(value: model.verification, onChanged: (state) => _verification(context, state, model)),
          ],
        ),
      );
    });
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 4) {
      return Column(
        children: [
          _sliderMenu(context),
          Center(
            child: Container(
              margin: EdgeInsets.all(30),
              child: Text(
                Constants.search_term_must_be_longer(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      );
    }

    return Consumer(builder: (context, watch, child) {
      final model = watch(providerSearchViewModel);

      return FutureBuilder(
        future: model.searchQuery(context, query),
        builder: (BuildContext context, AsyncSnapshot<AlgoliaQuerySnapshot> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: Container(height: 100, width: 100, child: CircularProgressIndicator()));
              break;
            default:
              if (snapshot.hasError) {
                return Text('error'.tr() + ': ${snapshot.error}');
              } else {
                return Column(
                  children: <Widget>[
                    _sliderMenu(context),
                    Divider(color: Colors.grey),
                    Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) => Divider(
                          height: 10,
                          color: Colors.grey,
                        ),
                        itemCount: snapshot.data.hits.length,
                        itemBuilder: (context, index) {
                          final AlgoliaObjectSnapshot result = snapshot.data.hits[index];
                          final db = context.read(providerDatabase);

                          Future future;
                          if (model.recipes) {
                            future = db.getRecipe(result.objectID);
                          } else {
                            future = db.getProduct(id: result.objectID);
                          }

                          return FutureBuilder(
                              future: future,
                              builder: (BuildContext context, AsyncSnapshot snap) {
                                switch (snap.connectionState) {
                                  case ConnectionState.waiting:
                                    return Container();
                                  default:
                                    if (snap.hasData) {
                                      return GestureDetector(
                                          onTap: () {
                                            close(context, snap.data);
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(left: 5, right: 5),
                                            child: TileProduct(snap.data),
                                          ));
                                    } else if (snap.hasError) {
                                      return Text('error'.tr() + ': ${snap.error}');
                                    } else {
                                      return Text('error'.tr());
                                    }
                                }
                              });
                        },
                      ),
                    ),
                  ],
                );
              }
          }
        },
      );
    });
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear), onPressed: () => query = "")];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(icon: AnimatedIcon(icon: AnimatedIcons.menu_arrow, progress: transitionAnimation), onPressed: () => close(context, null));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Column(
      children: <Widget>[
        _sliderMenu(context),
      ],
    );
  }
}
