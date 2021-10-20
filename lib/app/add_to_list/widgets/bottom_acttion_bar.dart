import 'package:fitable/app/add_to_list/view_models/add_to_list_view_model.dart';
import 'package:fitable/common_widgets/custom_drop_down_button.dart';
import 'package:fitable/common_widgets/custom_icon_button.dart';
import 'package:fitable/common_widgets/custom_list_view.dart';
import 'package:fitable/common_widgets/custom_text_field.dart';
import 'package:fitable/utilities/languages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomActionBar extends StatelessWidget {
  final EnumTileType detailsType;

  const BottomActionBar(this.detailsType, {Key key}) : super(key: key);

  _tileKeyWord(BuildContext context, String name) {
    return GestureDetector(
      onTap: () => context.read(providerAddToListViewModel).addSuggested(name),
      child: Card(
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(name),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (detailsType == EnumTileType.keyWord)
      return Container(
        height: 170,
        color: Theme.of(context).primaryColorDark.withOpacity(0.6),
        width: MediaQuery.of(context).size.width - 30,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 6, bottom: 8),
              child: Text(Languages.suggested() + ':', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
            ),
            Wrap(
              children: [
                _tileKeyWord(context, Languages.ketogenic().toLowerCase()),
                _tileKeyWord(context, Languages.low_fats().toLowerCase()),
                _tileKeyWord(context, Languages.high_protein().toLowerCase()),
                _tileKeyWord(context, Languages.gluten_free().toLowerCase()),
              ],
            ),
            Row(
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
          ],
        ),
      );

    return Container(
      height: 70,
      color: Theme.of(context).primaryColorDark.withOpacity(0.6),
      width: MediaQuery.of(context).size.width - 30,
      child: Row(
        children: <Widget>[
          Container(
            height: 65,
            width: 125,
            child: Consumer(builder: (context, watch, child) {
              return CustomDropDownButton(
                name: Languages.portion(),
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
}
