import 'package:fitable/app/product/add_key_words_screen.dart';
import 'package:fitable/app/recipe/widgets/tile_head_ingredients.dart';
import 'package:fitable/common_widgets/custom_bar_list.dart';
import 'package:fitable/common_widgets/custom_drop_down_button.dart';
import 'package:fitable/common_widgets/custom_input_bar.dart';
import 'package:fitable/common_widgets/custom_scaffold.dart';
import 'package:fitable/common_widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class RecipeCreateScreen extends StatelessWidget {
  _submitKeyWords(BuildContext context) async {
    // final model = context.read(providerCreateProductViewModel);
    //
    // List result = await Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) {
    //     return AddKeyWordsScreen(model.keyWords);
    //   }),
    // );
    //
    // if (result != null) {
    //   model.keyWords = result;
    // }
  }

  _submitPortions(BuildContext context) async {
    // final model = context.read(providerCreateProductViewModel);
    //
    // Map result = await Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) {
    //     return AddPortionsScreen(unit: model.unit, map: model.portions);
    //   }),
    // );
    //
    // if (result != null) {
    //   model.portions = result;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        title: Text('create_new_recipe'.tr()),
        actions: [
          IconButton(icon: Icon(Icons.check), onPressed: () => null),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomTextField(
              name: 'youtube'.tr(),
              hintText: 'enter_youtube_id'.tr(),
            ),
            CustomTextField(
              name: 'recipe_name'.tr(),
            ),
            CustomTextField(
              name: 'description'.tr(),
              maxLines: 20,
              minLines: 10,
            ),
            Row(
              children: [
                Expanded(child: CustomInputBar(name: 'time'.tr(), value: '', onPressed: null)),
                Expanded(child: CustomDropDownButton(name: 'visible'.tr(), value: 'private', list: ['private', 'public'], onChanged: (v) {})),
                Expanded(child: CustomDropDownButton(name: 'unit'.tr(), value: 'g', list: <String>['g', 'ml'], onChanged: (v) {})),
              ],
            ),
            CustomBarList(name: "key_words".tr(), value: [], onPressed: () => _submitKeyWords(context)),
            CustomBarList(name: "portions".tr(), value: [], onPressed: () => _submitPortions(context)),
            TileHeadIngredients()
          ],
        ),
      ),
    );
  }
}
