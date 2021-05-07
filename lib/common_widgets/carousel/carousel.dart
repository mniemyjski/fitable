import 'package:carousel_slider/carousel_slider.dart';
import 'package:fitable/app/crop/crop_image_screen.dart';
import 'package:fitable/common_widgets/carousel/circles.dart';
import 'package:fitable/common_widgets/carousel/models/box_model.dart';
import 'package:fitable/common_widgets/carousel/tile_box.dart';
import 'package:fitable/routers/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'dart:io';

class Carousel extends StatefulWidget {
  final String videoUrl;
  final List photosUrl;
  final bool edit;
  final bool isShow;
  final ValueChanged<List<String>> onChanged;

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
        boxes.add(Box(url: element, isEdit: widget.edit));
      });
    if (widget.edit) boxes.add(Box(isEdit: true));
    super.initState();
  }

  List<String> _getOnlyPhotosUrl(List<Box> boxes) {
    List<Box> _list = [];
    List<String> _urls = [];
    _list = List.from(boxes);
    _list.removeWhere((element) => element.isVideo);
    _list.forEach((element) {
      if (element.url != '') _urls.add(element.url);
    });

    return _urls;
  }

  void _add() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (boxes[current].url == '') {
        boxes.add(Box(isEdit: true));
        controllerCarousel.nextPage();
      }

      boxes[current] = Box(url: pickedFile.path, isEdit: true);
    });
    widget.onChanged(_getOnlyPhotosUrl(boxes));
  }

  void _crop() async {
    File _file = File(boxes[current].url);

    var result = await Navigator.pushNamed(
      context,
      AppRoute.cropImageScreen,
      arguments: CropImageScreenArguments(file: _file, current: current),
    );

    if (result != null) {
      File _file = result;
      setState(() {
        boxes[current] = Box(url: _file.path, isEdit: true);
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
          // boxes.clear();
          // boxes.add(Box(isEdit: true));
          // controllerCarousel.previousPage();
        }
      }
    });

    widget.onChanged(_getOnlyPhotosUrl(boxes));
  }

  List<Widget> _sliders(BuildContext context) {
    if (widget.edit) widget.onChanged(_getOnlyPhotosUrl(boxes));
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
