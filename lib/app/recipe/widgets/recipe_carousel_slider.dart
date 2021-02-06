import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:fitable/app/recipe/view_models/recipe_create_view_model.dart';
import 'package:fitable/app/recipe/widgets/box_video.dart';
import 'package:fitable/common_widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:image_picker/image_picker.dart';

class RecipeCarouselSlider extends ConsumerWidget {
  _buttonList(BuildContext context, bool crop) {
    return [
      CustomIconButton(
        buttonColor: Colors.grey.withOpacity(0.5),
        icon: Icons.upload_rounded,
        onPressed: () async {
          context.read(providerRecipeCreateViewModel).addImage();
        },
      ),
      if (crop) SizedBox(width: 25),
      if (crop)
        CustomIconButton(
          buttonColor: Colors.grey.withOpacity(0.5),
          icon: Icons.crop,
          onPressed: () {
            context.read(providerRecipeCreateViewModel).cropImage();
          },
        ),
      SizedBox(width: 25),
      CustomIconButton(
        buttonColor: Colors.grey.withOpacity(0.5),
        icon: Icons.delete,
        onPressed: () {
          context.read(providerRecipeCreateViewModel).removeImage();
        },
      ),
    ];
  }

  List<Widget> _imageSliders(BuildContext context, RecipeCreateViewModel model) {
    return model.sliderList.map((item) {
      if (model.sliderList.indexOf(item) == 0) return BoxVideo();

      if (model.sliderList.indexOf(item) != 0) {
        File file = File(item);

        return Container(
          height: 500,
          child: Container(
            child: Stack(
              children: <Widget>[
                // Image.network(
                //   item,
                //   fit: BoxFit.cover,
                //   width: 1000.0,
                //   height: 1000.0,
                // ),
                Image.file(
                  file,
                  width: 1000.0,
                  height: 1000.0,
                  fit: BoxFit.cover,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buttonList(context, item.length > 3 ? true : false),
                  ),
                ),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color.fromARGB(200, 0, 0, 0), Color.fromARGB(0, 0, 0, 0)],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context, watch) {
    final model = watch(providerRecipeCreateViewModel);

    return Column(
      children: [
        CarouselSlider(
          items: _imageSliders(context, model),
          carouselController: model.carouselController,
          options: CarouselOptions(
              enableInfiniteScroll: false,
              viewportFraction: 1.0,
              onPageChanged: (index, reason) {
                model.current = index;
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: model.sliderList.map((url) {
            int index = model.sliderList.indexOf(url);
            return Container(
              width: 12.0,
              height: 12.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: model.current == index ? Color.fromRGBO(0, 0, 0, 0.9) : Color.fromRGBO(0, 0, 0, 0.4),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
