import 'package:carousel_slider/carousel_slider.dart';
import 'package:fitable/common_widgets/carousel/models/box_model.dart';
import 'package:fitable/common_widgets/carousel/tile_box.dart';
import 'package:fitable/common_widgets/carousel/view_models/carousel_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class Carousel extends StatelessWidget {
  final String videoUrl;
  final List photosUrl;
  final bool edit;
  final bool isShow;
  final ValueChanged<List<String>> onChanged;

  Carousel({this.videoUrl = '', this.photosUrl, this.edit = false, this.isShow = true, this.onChanged});

  List<Widget> _circles(BuildContext context, CarouselViewModel model) {
    List<Widget> _list = [];

    for (int index = 0; index < model.boxes.length; index++) {
      Widget item = Container(
        width: 12.0,
        height: 12.0,
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: model.current == index ? Color.fromRGBO(0, 0, 0, 0.9) : Color.fromRGBO(0, 0, 0, 0.4),
        ),
      );

      _list.add(item);
    }

    return _list;
  }

  List<Widget> _sliders(BuildContext context, CarouselViewModel model) {
    if (edit) onChanged(model.getOnlyPhotosUrl());
    return model.boxes.map((item) {
      return TileBox(item);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (!isShow) return Container();

    return Consumer(builder: (context, watch, child) {
      final model = watch(providerCarouselViewModel);
      model.initState(videoUrl, photosUrl, edit);

      return Column(
        children: [
          if (model.boxes.isNotEmpty)
            CarouselSlider(
              items: _sliders(context, model),
              carouselController: model.controllerCarousel,
              options: CarouselOptions(
                enableInfiniteScroll: false,
                viewportFraction: 1.0,
                onPageChanged: (index, reason) => context.read(providerCarouselViewModel).current = index,
              ),
            ),
          if (model.boxes.length > 1)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(Icons.navigate_before),
                      onPressed: () => context.read(providerCarouselViewModel).controllerCarousel.previousPage(),
                    )),
                Row(children: _circles(context, model)),
                Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(Icons.navigate_next),
                      onPressed: () => context.read(providerCarouselViewModel).controllerCarousel.nextPage(),
                    )),
              ],
            ),
        ],
      );
    });
  }
}
