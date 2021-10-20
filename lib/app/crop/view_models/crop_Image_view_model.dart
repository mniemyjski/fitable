import 'dart:typed_data';

import 'package:extended_image/extended_image.dart' hide File;
import 'package:flutter/material.dart' hide Image;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image/image.dart';
import 'package:logger/logger.dart';

final providerCropImageViewModel = ChangeNotifierProvider.autoDispose<CropImageViewModel>((ref) {
  return CropImageViewModel();
});

class CropImageViewModel extends ChangeNotifier {
  final GlobalKey<ExtendedImageEditorState> editorKey = GlobalKey<ExtendedImageEditorState>();

  double aspectRatio = 1;

  reset() {
    editorKey.currentState.reset();
  }

  Uint8List crop() {
    final Rect cropRect = editorKey.currentState.getCropRect();
    var data = editorKey.currentState.rawImageData;

    Image src = decodeImage(data);
    src = bakeOrientation(src);
    src = copyCrop(src, cropRect.left.toInt(), cropRect.top.toInt(), cropRect.width.toInt(), cropRect.height.toInt());
    var fileData = encodeJpg(src, quality: 50);
    return Uint8List.fromList(fileData);
  }
}
