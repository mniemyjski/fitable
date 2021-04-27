import 'package:fitable/app/add_to_list/add_to_list_view_model.dart';
import 'package:fitable/common_widgets/custom_drop_down_button.dart';
import 'package:fitable/common_widgets/custom_icon_button.dart';
import 'package:fitable/common_widgets/custom_list_view.dart';
import 'package:fitable/common_widgets/custom_scaffold.dart';
import 'package:fitable/common_widgets/custom_text_field.dart';
import 'package:fitable/constants/constants.dart';
import 'package:fitable/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

_floatAction(BuildContext context, EnumTileType detailsType) {
  if (detailsType == EnumTileType.keyWord)
    return Container(
      height: 65,
      width: MediaQuery.of(context).size.width - 30,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Consumer(builder: (context, watch, child) {
              return CustomTextField(
                  onChanged: (v) => context.read(providerAddToListViewModel).sizeListener = v,
                  controller: watch(providerAddToListViewModel).controller);
            }),
          ),
          CustomIconButton(onPressed: () => context.read(providerAddToListViewModel).addToList(context)),
        ],
      ),
    );

  return Container(
    height: 65,
    width: MediaQuery.of(context).size.width - 30,
    child: Row(
      children: <Widget>[
        Container(
          width: 125,
          child: Consumer(builder: (context, watch, child) {
            return CustomDropDownButton(
              name: Constants.portion(),
              value: watch(providerAddToListViewModel).portionListener,
              list: <String>['package', 'portion', 'glass', 'teaspoon', 'spoon'],
              onChanged: (v) => context.read(providerAddToListViewModel).portionListener = v,
            );
          }),
        ),
        Expanded(
          child: Consumer(builder: (context, watch, child) {
            return CustomTextField(
              onChanged: (v) => context.read(providerAddToListViewModel).sizeListener = v,
              keyboardType: TextInputType.number,
              controller: watch(providerAddToListViewModel).controller,
            );
          }),
        ),
        CustomIconButton(onPressed: () => context.read(providerAddToListViewModel).addToList(context)),
      ],
    ),
  );
}

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

      return CustomScaffold(
        appBar: AppBar(title: Text(title), actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () => context.read(providerAddToListViewModel).save(context),
          )
        ]),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 80),
          child: SingleChildScrollView(
            child: CustomListView(
              type: model.tileType,
              list: model.list,
              onDismissed: (element) => context.read(providerAddToListViewModel).onDismissed(element),
            ),
          ),
        ),
        floatingActionButton: _floatAction(context, model.tileType),
      );
    });
  }
}
