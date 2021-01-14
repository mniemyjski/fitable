import 'package:algolia/algolia.dart';
import 'package:fitable/app/product/widget/tile_product.dart';
import 'package:fitable/services/application.dart';
import 'package:fitable/services/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fitable/app/product/models/product_model.dart';

class DataSearch extends SearchDelegate {
  bool verification = false;
  bool withBarcode = true;
  bool recipes = false;
  bool trainings = false;
  bool coach = false;

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

    searchQuery = algolia.instance.index('products').search(query);
    searchQuery = searchQuery.setFilters('localeBase:pl_PL');

    if (query.length < 4) {
      return Center(
        child: Container(
          margin: EdgeInsets.all(30),
          child: Text(
            'search_term_must_be_longer'.tr(),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
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
                        final Future<Product> product = db.getProduct(result.data['barcode']);

                        return FutureBuilder(
                            future: product,
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
                                          child: TileProduct(product: snap.data),
                                        ));
                                  } else if (snap.hasError) {
                                    print(snap);
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
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Column(
      children: <Widget>[],
    );
  }
}
