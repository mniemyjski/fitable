import 'package:carousel_slider/carousel_slider.dart';
import 'package:fitable/app/account/models/preference_model.dart';
import 'package:fitable/app/recipe/view_models/recipe_create_view_model.dart';
import 'package:fitable/app/recipe/widgets/recipe_carousel_slider.dart';
import 'package:fitable/app/recipe/widgets/box_video.dart';
import 'package:fitable/app/recipe/widgets/tile_head_ingredients.dart';
import 'package:fitable/common_widgets/custom_bar_list.dart';
import 'package:fitable/common_widgets/custom_button.dart';
import 'package:fitable/common_widgets/custom_drop_down_button.dart';
import 'package:fitable/common_widgets/custom_input_bar.dart';
import 'package:fitable/common_widgets/custom_scaffold.dart';
import 'package:fitable/common_widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class RecipeCreateScreen extends StatefulWidget {
  @override
  _RecipeCreateScreenState createState() => _RecipeCreateScreenState();
}

class _RecipeCreateScreenState extends State<RecipeCreateScreen> {
  @override
  void initState() {
    final model = context.read(providerRecipeCreateViewModel);
    final pref = context.read(providerPreference).data.value;
    // model.mute = pref.mute;

    model.controller = YoutubePlayerController(
      initialVideoId: '',
      params: YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
        mute: model.mute,
      ),
    );
    super.initState();
  }

  _buildTimer() {
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
                            'save'.tr(),
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

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        title: Text('create_new_recipe'.tr()),
        actions: [
          IconButton(icon: Icon(Icons.check), onPressed: () => context.read(providerRecipeCreateViewModel).createRecipe(context)),
        ],
      ),
      body: SingleChildScrollView(
        child: Consumer(builder: (context, watch, child) {
          final model = watch(providerRecipeCreateViewModel);

          return Column(
            children: [
              RecipeCarouselSlider(),
              Padding(
                padding: const EdgeInsets.only(left: 6, top: 0),
                child: CustomTextField(
                  name: 'youtube'.tr(),
                  hintText: 'enter_youtube_id'.tr(),
                  onChanged: (v) {
                    context.read(providerRecipeCreateViewModel).videoId = v;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 6),
                child: CustomTextField(
                  name: 'recipe_name'.tr(),
                  onChanged: (v) {
                    context.read(providerRecipeCreateViewModel).name = v;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 6),
                child: CustomTextField(
                  name: 'description'.tr(),
                  maxLines: 20,
                  minLines: 10,
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
                        name: 'time'.tr(),
                        value: '${model.timePreparation.inHours}h ${(model.timePreparation.inMinutes % 60).toString().padLeft(2, '0')} min',
                        onPressed: _buildTimer,
                      ),
                    ),
                    Expanded(
                        child: CustomDropDownButton(
                            name: 'visible'.tr() + ':',
                            value: model.access,
                            list: ['private', 'public'],
                            onChanged: (v) => context.read(providerRecipeCreateViewModel).access = v)),
                    Expanded(
                        child: CustomDropDownButton(
                            name: 'unit'.tr() + ':',
                            value: model.unit,
                            list: <String>['g', 'ml'],
                            onChanged: (v) => context.read(providerRecipeCreateViewModel).unit = v)),
                  ],
                ),
              ),
              CustomBarList(
                  name: "key_words".tr(),
                  value: model.keyWords,
                  onPressed: () => context.read(providerRecipeCreateViewModel).submitKeyWords(context)),
              CustomBarList(
                  name: "portions".tr(), value: model.portions, onPressed: () => context.read(providerRecipeCreateViewModel).submitPortions(context)),
              TileHeadIngredients(),
              SizedBox(height: 60)
            ],
          );
        }),
      ),
    );
  }
}
