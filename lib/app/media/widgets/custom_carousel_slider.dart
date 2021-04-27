import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:extended_image/extended_image.dart';
import 'package:fitable/app/account/models/preference_model.dart';
import 'package:fitable/app/media/view_models/carousel_view_model.dart';
import 'package:fitable/app/media/widgets/box_video.dart';
import 'package:fitable/common_widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomCarouselSlider extends ConsumerWidget {
  final String videoUrl;
  final List photosUrl;
  final bool edit;

  CustomCarouselSlider({this.videoUrl = '', this.photosUrl, this.edit = false});

  _buttonList(BuildContext context, bool crop, file) {
    if (!edit) return [Container()];

    return [
      CustomIconButton(
        buttonColor: Colors.grey.withOpacity(0.5),
        icon: Icons.upload_rounded,
        onPressed: () => context.read(providerCarouselViewModel).addImage(),
      ),
      if (crop) SizedBox(width: 25),
      if (crop)
        CustomIconButton(
          buttonColor: Colors.grey.withOpacity(0.5),
          icon: Icons.crop,
          onPressed: () => context.read(providerCarouselViewModel).cropImage(context, file),
        ),
      SizedBox(width: 25),
      CustomIconButton(
        buttonColor: Colors.grey.withOpacity(0.5),
        icon: Icons.delete,
        onPressed: () => context.read(providerCarouselViewModel).removeImage(),
      ),
    ];
  }

  List<Widget> _imageSliders(BuildContext context, CarouselViewModel model) {
    if (!edit) {
      model.sliderList = [];
      if (videoUrl.isNotEmpty) model.sliderList.add(videoUrl);
      if (photosUrl != null) model.sliderList.addAll(photosUrl);
    }

    return model.sliderList.map((item) {
      if (model.sliderList.indexOf(item) == 0)
        return Consumer(builder: (context, watch, child) {
          return watch(providerPreference).when(
            data: (pref) => BoxVideo(videoUrl: videoUrl, pref: pref),
            loading: () => Center(
              child: Container(height: 100, width: 100, child: CircularProgressIndicator()),
            ),
            error: (err, stack) => Center(child: Text('Error: $err')),
          );
        });

      if (model.sliderList.indexOf(item) != 0) {
        File file = File(item);

        return Container(
          height: 500,
          child: Container(
            child: Stack(
              children: <Widget>[
                if (edit && file.path.length > 3)
                  ExtendedImage.file(
                    file,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.fill,
                  ),
                if (!edit)
                  CachedNetworkImage(
                    imageUrl: item,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
                      ),
                    ),
                    placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Icon(Icons.account_circle, size: 80),
                  ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buttonList(context, item.length > 3 ? true : false, file),
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
    final model = watch(providerCarouselViewModel);

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
