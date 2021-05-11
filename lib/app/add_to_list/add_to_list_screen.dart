import 'package:fitable/app/add_to_list/add_to_list_view_model.dart';
import 'package:fitable/app/add_to_list/widgets/bottom_acttion_bar.dart';
import 'package:fitable/common_widgets/custom_list_view.dart';
import 'package:fitable/utilities/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddToListScreen extends StatelessWidget {
  final EnumTileType tileType;
  final String title;
  final List list;
  final UnitType unit;

  AddToListScreen({@required this.tileType, @required this.list, @required this.title, this.unit});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final model = watch(providerAddToListViewModel);
      model.initState(list, tileType, unit);

      return Scaffold(
        appBar: AppBar(title: Text(title), actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () => context.read(providerAddToListViewModel).save(context),
          )
        ]),
        body: SingleChildScrollView(
          child: CustomListView(
            type: model.tileType,
            list: model.list,
            onDismissed: (element) => context.read(providerAddToListViewModel).onDismissed(element),
          ),
        ),
        floatingActionButton: BottomActionBar(model.tileType),
      );
    });
  }
}
