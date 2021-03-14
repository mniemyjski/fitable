import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image/image.dart' as i;

final providerCropImageViewModel = ChangeNotifierProvider.autoDispose<CropImageViewModel>((ref) {
  return CropImageViewModel();
});

class CropImageViewModel extends ChangeNotifier {
  final GlobalKey<ExtendedImageEditorState> editorKey = GlobalKey<ExtendedImageEditorState>();

  // Key editorKey;
  double aspectRatio = 1;

  reset() {
    editorKey.currentState.reset();
  }

  crop(BuildContext context, String path) async {
    final Rect cropRect = editorKey.currentState.getCropRect();

    var data = editorKey.currentState.rawImageData;

    i.Image src = i.decodeImage(data);
    src = i.copyCrop(src, cropRect.left.toInt(), cropRect.top.toInt(), cropRect.width.toInt(), cropRect.height.toInt());

    var fileData = i.encodeJpg(src);
    File file = File(path + cropRect.toString())..writeAsBytesSync(fileData);

    Navigator.pop(context, file);
  }
}
