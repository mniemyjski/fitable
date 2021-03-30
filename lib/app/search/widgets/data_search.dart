import 'package:algolia/algolia.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:fitable/app/account/models/preference_model.dart';
import 'package:fitable/app/product/widget/tile_product.dart';
import 'package:fitable/app/search/view_models/search_view_model.dart';
import 'package:fitable/constants/constants.dart';
import 'package:fitable/services/application.dart';
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
  }

  _sliderMenu(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final model = watch(providerSearchViewModel);

      return Container(
        margin: EdgeInsets.only(right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(Icons.fastfood, color: Colors.lightBlue[800]),
            Switch(
                value: model.recipes,
                onChanged: (state) {
                  context.read(providerSearchViewModel).recipes = state;

                  if (model.recipes) {
                    _massage(context, Constants.search_recipes());
                  } else {
                    _massage(context, Constants.search_products());
                  }
                  query = "";
                }),
            FaIcon(FontAwesomeIcons.barcode, color: Colors.lightBlue[800]),
            Switch(
                value: model.withBarcode,
                onChanged: (state) {
                  context.read(providerSearchViewModel).withBarcode = state;

                  if (model.withBarcode) {
                    _massage(context, Constants.search_product_only_with_barcode());
                  }
                  query = "";
                }),
            Icon(Icons.verified_user, color: Colors.lightBlue[800]),
            Switch(
                value: model.verification,
                onChanged: (state) {
                  context.read(providerSearchViewModel).verification = state;

                  if (model.verification) {
                    _massage(context, Constants.search_verification_product_only());
                  }
                  query = "";
                }),
          ],
        ),
      );
    });
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    Algolia algolia = Application.algolia;
    AlgoliaQuery searchQuery;

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
      final preference = watch(providerPreference).data.value;

      if (model.recipes) {
        searchQuery = algolia.instance.index('recipes').search(query);
        searchQuery = searchQuery.setFilters('localeBase:${preference.localeBase} AND verification:true');
      } else {
        searchQuery = algolia.instance.index('products').search(query);
        if (model.verification && !model.withBarcode) {
          searchQuery = searchQuery.setFilters('localeBase:${preference.localeBase} AND verification:${model.verification.toString()}');
        } else if (model.withBarcode && !model.verification) {
          searchQuery = searchQuery.setFilters('localeBase:${preference.localeBase} AND withBarcode:${model.withBarcode.toString()}');
        } else if (model.withBarcode && model.verification) {
          searchQuery = searchQuery.setFilters(
              'localeBase:${preference.localeBase} AND withBarcode:${model.withBarcode.toString()} AND verification:${model.verification.toString()}');
        } else {
          searchQuery = searchQuery.setFilters('localeBase:${preference.localeBase}');
        }
      }

      return FutureBuilder(
        future: searchQuery.getObjects(),
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
                            future = db.getProduct(result.data['barcode']);
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
  Widget buildSuggestions(BuildContext context) {
    return Column(
      children: <Widget>[
        _sliderMenu(context),
      ],
    );
  }
}
