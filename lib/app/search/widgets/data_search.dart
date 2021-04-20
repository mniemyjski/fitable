import 'package:algolia/algolia.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:fitable/app/account/widgets/buildSliderMenu.dart';
import 'package:fitable/app/account/widgets/build_title.dart';
import 'package:fitable/app/search/view_models/search_view_model.dart';
import 'package:fitable/constants/constants.dart';
import 'package:fitable/constants/enums.dart';
import 'package:fitable/services/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DataSearch extends SearchDelegate {
  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 4) {
      return Column(
        children: [
          sliderMenu(context),
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
                    sliderMenu(context),
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

                          return FutureBuilder(
                              future: model.getStream(context, result.objectID),
                              builder: (BuildContext context, AsyncSnapshot snap) {
                                if (snap.hasData) {
                                  return GestureDetector(
                                    onTap: () => close(context, snap.data),
                                    child: getTitleType(model.searchType, snap.data),
                                  );
                                } else if (snap.hasError) {
                                  return Text('error'.tr() + ': ${snap.error}');
                                } else {
                                  return Text('error'.tr());
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
        sliderMenu(context),
      ],
    );
  }
}
