import 'package:easy_localization/easy_localization.dart';
import 'package:fitable/app/home/view_models/home_view_model.dart';
import 'package:fitable/app/home/widgets/tile_expansion.dart';
import 'package:fitable/app/product/models/meal_model.dart';
import 'package:fitable/services/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TileHeadMeasurement extends StatelessWidget {
  _buildListView({@required BuildContext context, @required List list}) {
    return Container(
      child: ListView.separated(
        separatorBuilder: (context, index) => Container(
            margin: EdgeInsets.only(right: 75),
            child: Divider(
              height: 5,
              color: Colors.grey,
            )),
        itemCount: list.length,
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (_, int index) {
          final key = list.elementAt(index);
          final element = list.elementAt(index);

          return GestureDetector(
            onTap: () {},
            child: Dismissible(
                key: Key(key),
                onDismissed: (direction) {
                  final db = context.read(providerDatabase);
                },
                direction: DismissDirection.startToEnd,
                background: Container(
                  height: double.infinity,
                  child: Container(
                      height: double.infinity,
                      alignment: Alignment.centerLeft,
                      color: Colors.red[600],
                      child: Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Icon(Icons.delete, color: Colors.white),
                      )),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 90),
                  child: Text(element),
                )),
          );
        },
      ),
    );
  }

  _buildHead(List list) {
    return Consumer(builder: (context, watch, child) {
      final model = watch(providerHomeViewModel);
      double size = 35;

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 5),
            child: FaIcon(FontAwesomeIcons.rulerHorizontal, color: Colors.grey[700]),
          ),
          Container(
            height: double.infinity,
            child: Row(
              children: <Widget>[
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    FaIcon(FontAwesomeIcons.weight, color: Colors.grey.withOpacity(0.5), size: 20),
                    SizedBox(
                      width: size,
                      height: size,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: size,
                      height: size,
                      child: CircularProgressIndicator(
                        value: 0.5,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo),
                        backgroundColor: Colors.grey[400],
                        strokeWidth: 5,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 20),
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    FaIcon(FontAwesomeIcons.bacon, color: Colors.grey.withOpacity(0.5), size: 20),
                    SizedBox(
                      width: size,
                      height: size,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: size,
                      height: size,
                      child: CircularProgressIndicator(
                        value: 0.5,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo),
                        backgroundColor: Colors.grey[400],
                        strokeWidth: 5,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 10),
              ],
            ),
          ),
        ],
      );
    });
  }

  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final meals = watch(providerMeals);
      final model = watch(providerHomeViewModel);

      return meals.when(
        data: (data) => TileExpansion(
          onPressed: () {},
          head: _buildHead([]),
          listView: _buildListView(context: context, list: []),
        ),
        loading: () => Center(
          child: Container(height: 100, width: 100, child: CircularProgressIndicator()),
        ),
        error: (err, stack) => Center(child: Text('Error: $err')),
      );
    });
  }
}
