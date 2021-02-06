import 'package:fitable/app/account/models/preference_model.dart';
import 'package:fitable/app/recipe/view_models/recipe_create_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class BoxVideo extends StatelessWidget {
  _onPressed(BuildContext context) {
    final model = context.read(providerRecipeCreateViewModel);
    model.carouselController.nextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final model = watch(providerRecipeCreateViewModel);

      return Stack(
        children: [
          YoutubePlayerIFrame(
            controller: model.controller,
            // aspectRatio: 16 / 9,
          ),
          Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                  iconSize: 60,
                  icon: Icon(
                    Icons.navigate_next,
                    color: Colors.white,
                  ),
                  onPressed: () => _onPressed(context))),
          // Align(
          //     alignment: Alignment.centerRight, child: Container(height: 110, width: MediaQuery.of(context).size.width / 2 - 40, color: Colors.red)),
        ],
      );
    });
  }
}
