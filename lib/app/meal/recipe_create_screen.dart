import 'package:fitable/app/meal/models/recipe_model.dart';
import 'package:fitable/app/meal/view_models/recipe_create_view_model.dart';
import 'package:fitable/common_widgets/carousel/carousel.dart';
import 'package:fitable/app/meal/widgets/tile_head_ingredients.dart';
import 'package:fitable/common_widgets/custom_bar_list.dart';
import 'package:fitable/common_widgets/custom_button.dart';
import 'package:fitable/common_widgets/custom_drop_down_button.dart';
import 'package:fitable/common_widgets/custom_input_bar.dart';
import 'package:fitable/common_widgets/custom_scaffold.dart';
import 'package:fitable/common_widgets/custom_text_field.dart';
import 'package:fitable/constants/constants.dart';
import 'package:fitable/constants/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecipeCreateScreenArguments {
  final Recipe recipe;

  RecipeCreateScreenArguments({this.recipe});
}

_buildTimer(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Consumer(builder: (context, watch, child) {
          final model = watch(providerRecipeCreateViewModel);
          Duration timer = model.timePreparation;
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 300,
              child: Column(
                children: <Widget>[
                  CupertinoTimerPicker(
                    mode: CupertinoTimerPickerMode.hm,
                    minuteInterval: 1,
                    initialTimerDuration: model.timePreparation,
                    onTimerDurationChanged: (Duration changedTimer) {
                      timer = changedTimer;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomButton(
                        color: Colors.indigo,
                        child: Text(
                          Constants.save(),
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          context.read(providerRecipeCreateViewModel).timePreparation = timer;
                          Navigator.pop(context);
                        }),
                  )
                ],
              ),
            ),
          );
        });
      });
}

class RecipeCreateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        title: Text(Constants.create_new_recipe()),
        actions: [
          IconButton(icon: Icon(Icons.check), onPressed: () => context.read(providerRecipeCreateViewModel).createRecipe(context)),
        ],
      ),
      body: SingleChildScrollView(
        child: Consumer(builder: (context, watch, child) {
          final RecipeCreateScreenArguments args = ModalRoute.of(context).settings.arguments;
          final model = watch(providerRecipeCreateViewModel);

          model.initState(args?.recipe);

          return Column(
            children: [
              Carousel(
                edit: true,
                videoUrl: model.videoId,
                photosUrl: model.photosUrl,
                onChanged: (v) => context.read(providerRecipeCreateViewModel).photosUrl = v,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 6, top: 0),
                child: CustomTextField(
                  name: Constants.youtube(),
                  initialValue: model.videoId,
                  hintText: Constants.enter_youtube_id(),
                  onChanged: (v) {
                    context.read(providerRecipeCreateViewModel).videoId = v;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 6),
                child: CustomTextField(
                  name: Constants.recipe_name(),
                  initialValue: model.name,
                  onChanged: (v) {
                    context.read(providerRecipeCreateViewModel).name = v;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 6),
                child: CustomTextField(
                  name: Constants.description(),
                  maxLines: 20,
                  minLines: 10,
                  initialValue: model.description,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  onChanged: (v) {
                    context.read(providerRecipeCreateViewModel).description = v;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 6),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomInputBar(
                        name: Constants.time(),
                        value: '${model.timePreparation.inHours}h ${(model.timePreparation.inMinutes % 60).toString().padLeft(2, '0')} min',
                        onPressed: () => _buildTimer(context),
                      ),
                    ),
                    Expanded(
                        child: CustomDropDownButton(
                            name: Constants.visible() + ':',
                            value: model.access,
                            list: ['private', 'public'],
                            onChanged: (v) => context.read(providerRecipeCreateViewModel).access = v)),
                    Expanded(
                        child: CustomDropDownButton(
                            name: Constants.unit() + ':',
                            value: Enums.toText(model.unit),
                            list: <String>['g', 'ml'],
                            onChanged: (v) => context.read(providerRecipeCreateViewModel).unit = Enums.unitTypeToEnum(v))),
                  ],
                ),
              ),
              CustomBarList(
                  name: Constants.key_words(),
                  value: model.keyWords.toString().substring(1, model.keyWords.toString().length - 1),
                  onPressed: () => context.read(providerRecipeCreateViewModel).submitKeyWords(context)),
              CustomBarList(
                  name: Constants.portions(),
                  value: model.portionsTXT(),
                  onPressed: () => context.read(providerRecipeCreateViewModel).submitPortions(context)),
              TileHeadIngredients(),
              SizedBox(height: 60)
            ],
          );
        }),
      ),
    );
  }
}