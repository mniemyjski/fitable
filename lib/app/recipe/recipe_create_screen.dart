import 'package:carousel_slider/carousel_slider.dart';
import 'package:fitable/app/account/models/preference_model.dart';
import 'package:fitable/app/recipe/view_models/recipe_create_view_model.dart';
import 'package:fitable/app/recipe/widgets/recipe_carousel_slider.dart';
import 'package:fitable/app/recipe/widgets/box_video.dart';
import 'package:fitable/app/recipe/widgets/tile_head_ingredients.dart';
import 'package:fitable/common_widgets/custom_bar_list.dart';
import 'package:fitable/common_widgets/custom_drop_down_button.dart';
import 'package:fitable/common_widgets/custom_input_bar.dart';
import 'package:fitable/common_widgets/custom_scaffold.dart';
import 'package:fitable/common_widgets/custom_text_field.dart';
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
    model.mute = pref.mute;

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
                    model.videoId = v;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 6),
                child: CustomTextField(
                  name: 'recipe_name'.tr(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 6),
                child: CustomTextField(
                  name: 'description'.tr(),
                  maxLines: 20,
                  minLines: 10,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 6),
                child: Row(
                  children: [
                    Expanded(child: CustomInputBar(name: 'time'.tr(), value: '', onPressed: null)),
                    Expanded(
                        child: CustomDropDownButton(
                            name: 'visible'.tr() + ':',
                            value: model.visible,
                            list: ['private', 'public'],
                            onChanged: (v) => context.read(providerRecipeCreateViewModel).visible = v)),
                    Expanded(
                        child: CustomDropDownButton(
                            name: 'unit'.tr() + ':',
                            value: model.unit,
                            list: <String>['g', 'ml'],
                            onChanged: (v) => context.read(providerRecipeCreateViewModel).unit = v)),
                  ],
                ),
              ),
              CustomBarList(name: "key_words".tr(), value: model.keyWords, onPressed: () => model.submitKeyWords(context)),
              CustomBarList(name: "portions".tr(), value: model.portions, onPressed: () => model.submitPortions(context)),
              TileHeadIngredients(),
              SizedBox(height: 60)
            ],
          );
        }),
      ),
    );
  }
}
