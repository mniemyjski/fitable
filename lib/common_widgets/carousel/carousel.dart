import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:fitable/app/crop/crop_image_screen.dart';
import 'package:fitable/common_widgets/carousel/circles.dart';
import 'package:fitable/common_widgets/carousel/models/box_model.dart';
import 'package:fitable/common_widgets/carousel/tile_box.dart';
import 'package:fitable/routers/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

class Carousel extends StatefulWidget {
  final String videoUrl;
  final List<Box> photosUrl;
  final bool edit;
  final bool isShow;
  final ValueChanged<List<Box>> onChanged;

  Carousel({this.videoUrl = '', this.photosUrl, this.edit = false, this.isShow = true, this.onChanged});

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  final CarouselController controllerCarousel = CarouselController();
  int current = 0;
  List<Box> boxes = [];

  @override
  void initState() {
    if (widget.videoUrl.isNotEmpty) boxes.add(new Box(url: widget.videoUrl, isVideo: true));
    if (widget.photosUrl != null)
      widget.photosUrl.forEach((element) {
        boxes.add(element.copyWith(isEdit: widget.edit));
      });
    if (widget.edit) boxes.add(Box(isEdit: true));
    super.initState();
  }

  void _add() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 1080,
      maxHeight: 1920,
    );

    Uint8List uint8list = await pickedFile.readAsBytes();

    setState(() {
      if (uint8list != null) {
        boxes.add(Box(isEdit: true));
        controllerCarousel.nextPage();
      }

      boxes[current] = Box(uint8List: uint8list, isEdit: true);
    });
  }

  void _crop() async {
    var result = await Navigator.pushNamed(
      context,
      AppRoute.cropImageScreen,
      arguments: CropImageScreenArguments(uint8list: boxes[current].uint8List, current: current),
    );

    if (result != null) {
      setState(() {
        boxes[current] = Box(uint8List: result, isEdit: true);
      });
    }
  }

  void _remove() {
    setState(() {
      if (boxes.length > 1 + (widget.videoUrl.isNotEmpty ? 1 : 0)) {
        boxes.removeAt(current);
        controllerCarousel.previousPage();
      } else {
        if (widget.videoUrl.isNotEmpty) {
          boxes.removeAt(current);
          boxes.add(Box(isEdit: true));
        } else {
          boxes.removeAt(current);
          boxes.add(Box(isEdit: true));
        }
      }
    });
  }

  List<Widget> _sliders(BuildContext context) {
    if (widget.edit) widget.onChanged(boxes);

    return boxes.map((item) {
      return TileBox(
        box: item,
        add: () => _add(),
        crop: () => _crop(),
        remove: () => _remove(),
      );
    }).toList();
  }

  _checkVideoUrl() {
    if (widget.videoUrl != '' && !boxes[0].isVideo) {
      List<Box> list = [];
      list.add(new Box(url: widget.videoUrl, isVideo: true));
      list.addAll(boxes);
      boxes = list;
      if (widget.edit) {
        controllerCarousel.jumpToPage(1);
        controllerCarousel.previousPage();
      }
    }

    if (widget.videoUrl == '' && boxes[0].isVideo) {
      boxes.removeAt(0);
      controllerCarousel.jumpToPage(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isShow) return Container();

    _checkVideoUrl();

    return Column(
      children: [
        if (boxes.isNotEmpty)
          CarouselSlider(
            items: _sliders(context),
            carouselController: controllerCarousel,
            options: CarouselOptions(
              enableInfiniteScroll: false,
              viewportFraction: 1.0,
              onPageChanged: (index, reason) => setState(() => current = index),
            ),
          ),
        if (boxes.length > 1)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(Icons.navigate_before),
                    onPressed: () => controllerCarousel.previousPage(),
                  )),
              Row(children: circles(context, boxes.length, current)),
              Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(Icons.navigate_next),
                    onPressed: () => controllerCarousel.nextPage(),
                  )),
            ],
          ),
      ],
    );
  }
}
