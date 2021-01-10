import 'package:algolia/algolia.dart';
import 'package:fitable/services/application.dart';

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

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
      return Column(
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.all(30),
              child: Text(
                'search_term_must_be_longer'.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            ),
          )
        ],
      );
    }

    return Container(
      margin: EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: <Widget>[
          FutureBuilder(
            future: searchQuery.getObjects(),
            builder: (BuildContext context, AsyncSnapshot<AlgoliaQuerySnapshot> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(
                    child: Container(height: 100, width: 100, child: CircularProgressIndicator()),
                  );
                  break;
                default:
                  if (snapshot.hasError) {
                    return Text('error'.tr() + ': ${snapshot.error}');
                  } else {
                    return Expanded(
                      child: Column(
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
                                // final Future future = DatabaseService().getProduct(id: result.objectID, locale: preference.localeBase);
                                return Text(result.objectID);
                                // return FutureBuilder(
                                //     future: future,
                                //     builder: (BuildContext context, AsyncSnapshot resultValue) {
                                //       switch (resultValue.connectionState) {
                                //         case ConnectionState.waiting:
                                //           return Container();
                                //           break;
                                //         default:
                                //           if (resultValue.hasError) {
                                //             return Text('error'.tr() + ': ${resultValue.error}');
                                //           } else {
                                //             return GestureDetector(
                                //                 onTap: () {
                                //                   close(context, resultValue.requireData);
                                //                 },
                                //                 child: typeSearch != TypeSearch.users
                                //                     ? TileProduct(value: resultValue.requireData)
                                //                     : tileUser(resultValue.requireData));
                                //           }
                                //       }
                                //     });
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }
              }
            },
          )
        ],
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Column(
      children: <Widget>[],
    );
  }
}
