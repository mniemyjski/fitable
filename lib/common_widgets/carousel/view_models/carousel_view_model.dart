import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fitable/app/crop/crop_image_screen.dart';
import 'package:fitable/common_widgets/carousel/models/box_model.dart';
import 'package:fitable/common_widgets/carousel/tile_box.dart';
import 'package:fitable/routers/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

final providerCarouselViewModel = ChangeNotifierProvider.autoDispose<CarouselViewModel>((ref) {
  return CarouselViewModel();
});

class CarouselViewModel extends ChangeNotifier {
  final CarouselController controllerCarousel = CarouselController();
  int _current = 0;
  bool init = true;
  bool _isVideo = false;

  int get current => _current;

  set current(int current) {
    _current = current;
    notifyListeners();
  }

  List<Box> _boxes = [];
  List<Box> get boxes => _boxes;
  set boxes(List<Box> boxes) {
    _boxes = boxes;
    notifyListeners();
  }

  List<String> getOnlyPhotosUrl() {
    List<Box> _list = [];
    List<String> _urls = [];
    _list = List.from(boxes);
    _list.removeWhere((element) => element.isVideo);
    _list.forEach((element) {
      if (element.url != '') _urls.add(element.url);
    });

    return _urls;
  }

  initState(String videoUrl, List photosUrl, bool edit) {
    // if (videoUrl != '' && !_isVideo) {
    //   List<Box> list = [];
    //   list.add(new Box(url: videoUrl, isVideo: true));
    //   list.addAll(boxes);
    //   boxes = list;
    //   _isVideo = true;
    //   if (edit) {
    //     controllerCarousel.jumpToPage(1);
    //     controllerCarousel.previousPage();
    //   }
    // }
    //
    // if (videoUrl == '' && _isVideo) {
    //   _isVideo = false;
    //   controllerCarousel.jumpToPage(1);
    //   boxes.removeAt(0);
    //   controllerCarousel.previousPage();
    //   notifyListeners();
    // }

    if (init) {
      _boxes.clear();
      if (videoUrl.isNotEmpty) _boxes.add(new Box(url: videoUrl, isVideo: true));
      if (photosUrl != null)
        photosUrl.forEach((element) {
          _boxes.add(Box(url: element, isEdit: edit));
        });
      if (edit) _boxes.add(Box(isEdit: true));
      init = false;
    }
  }

  addImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (boxes[current].url == '') {
      boxes.add(Box(isEdit: true));
      controllerCarousel.nextPage();
    }

    boxes[current] = Box(url: pickedFile.path, isEdit: true);

    notifyListeners();
  }

  cropImage(BuildContext context, String path) async {
    File _file = File(path);

    var result = await Navigator.pushNamed(
      context,
      AppRoute.cropImageScreen,
      arguments: CropImageScreenArguments(file: _file, current: current),
    );

    if (result != null) {
      File _file = result;
      boxes[current] = Box(url: _file.path, isEdit: true);
      notifyListeners();
    }
  }

  removeImage() {
    if (boxes.length > 1 + (_isVideo ? 1 : 0)) {
      boxes.removeAt(current);
      controllerCarousel.previousPage();
    } else {
      if (_isVideo) {
        boxes.removeAt(current);
        boxes.add(Box(isEdit: true));
      } else {
        boxes.clear();
        boxes.add(Box(isEdit: true));
        controllerCarousel.previousPage();
      }
    }

    notifyListeners();
  }
}
