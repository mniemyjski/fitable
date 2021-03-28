import 'dart:async';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fitable/app/account/models/account_model.dart';
import 'package:fitable/app/account/models/preference_model.dart';
import 'package:fitable/app/crop_image/crop_image_screen.dart';
import 'package:fitable/app/product/add_key_words_screen.dart';
import 'package:fitable/app/product/add_portions_screen.dart';
import 'package:fitable/app/product/models/ingredient_model.dart';
import 'package:fitable/app/product/product_details_screen.dart';
import 'package:fitable/app/recipe/models/recipe_model.dart';
import 'package:fitable/app/recipe/view_models/carousel_view_model.dart';
import 'package:fitable/app/search/search_screen.dart';
import 'package:fitable/routers/route_generator.dart';
import 'package:fitable/services/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:logger/logger.dart';

final providerCarouselViewModel = ChangeNotifierProvider.autoDispose<CarouselViewModel>((ref) {
  return CarouselViewModel();
});

class CarouselViewModel extends ChangeNotifier {
  final CarouselController carouselController = CarouselController();
  YoutubePlayerController controller;

  int _current;
  int get current => _current != null ? _current : _current = 0;
  set current(int current) {
    if (current == 0 && sliderList[0] != '') {
      Future.delayed(Duration(seconds: 1)).then((value) => controller.load(sliderList[0]));
    }
    _current = current;
    notifyListeners();
  }

  String get videoId => sliderList[0];

  set videoId(String videoId) {
    sliderList[0] = convertUrlToId(videoId);
    controller.load(sliderList[0]);
    notifyListeners();
  }

  bool _mute;
  bool get mute => _mute != null ? _mute : _mute = true;

  set mute(bool mute) {
    _mute = mute;
    notifyListeners();
  }

  List sliderList = ['', '1'];

  static String convertUrlToId(String url, {bool trimWhitespaces = true}) {
    assert(url?.isNotEmpty ?? false, 'Url cannot be empty');
    if (!url.contains("http") && (url.length == 11)) return url;
    if (trimWhitespaces) url = url.trim();

    for (var exp in [
      RegExp(r"^https:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$"),
      RegExp(r"^https:\/\/(?:www\.|m\.)?youtube(?:-nocookie)?\.com\/embed\/([_\-a-zA-Z0-9]{11}).*$"),
      RegExp(r"^https:\/\/youtu\.be\/([_\-a-zA-Z0-9]{11}).*$")
    ]) {
      Match match = exp.firstMatch(url);
      if (match != null && match.groupCount >= 1) return match.group(1);
    }

    return null;
  }

  addImage() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      File _file = File(result.files.single.path);

      var path = _file.path;
      var lastSeparator = path.lastIndexOf(Platform.pathSeparator);
      var newPath = path.substring(0, lastSeparator + 1) + current.toString();
      await _file.rename(newPath);

      sliderList[current] = newPath;
    }

    if (sliderList.length == current + 1 && sliderList.length < 7) {
      sliderList.add((current + 1).toString());
      carouselController.nextPage();
    }
    notifyListeners();
  }

  cropImage(BuildContext context, File file) async {
    var result = await Navigator.pushNamed(context, AppRoute.cropImageScreen, arguments: CropImageScreenArguments(file: file));

    if (result != null) {
      File _file = result;
      sliderList[current] = _file.path;
      notifyListeners();
    }
  }

  removeImage() {
    if (sliderList.length > 2) {
      int _item = current;
      carouselController.previousPage();
      sliderList.removeAt(_item);
    } else
      sliderList[1] = '1';
    notifyListeners();
  }
}
