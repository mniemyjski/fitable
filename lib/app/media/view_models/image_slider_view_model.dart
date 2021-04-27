import 'dart:async';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fitable/app/media/crop_image_screen.dart';
import 'package:fitable/routers/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

final providerImageSliderViewModel = ChangeNotifierProvider.autoDispose<ImageSliderViewModel>((ref) {
  return ImageSliderViewModel();
});

class ImageSliderViewModel extends ChangeNotifier {
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
      sliderList[current] = _file.path;
    }

    if (sliderList.length == current + 1 && sliderList.length < 7) {
      sliderList.add((current + 1).toString());
      carouselController.nextPage();
    }
    notifyListeners();
  }

  cropImage(BuildContext context, File file) async {
    var result = await Navigator.pushNamed(
      context,
      AppRoute.cropImageScreen,
      arguments: CropImageScreenArguments(file: file, current: current),
    );

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
