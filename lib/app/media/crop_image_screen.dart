import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:extended_image/extended_image.dart';
import 'package:fitable/app/media/view_models/crop_Image_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CropImageScreenArguments {
  final File file;

  CropImageScreenArguments({this.file});
}

class CropImageScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    final CropImageScreenArguments args = ModalRoute.of(context).settings.arguments;
    final model = watch(providerCropImageViewModel);

    return Scaffold(
      appBar: AppBar(
        title: Text('Crop'),
        actions: <Widget>[
          IconButton(
            onPressed: () => context.read(providerCropImageViewModel).crop(context, args.file.path),
            icon: Icon(Icons.save),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(8),
              child: ExtendedImage.file(
                // 'https://firebasestorage.googleapis.com/v0/b/fitable-76dce.appspot.com/o/recipes%2FOx4QeARgP8l29cBzb5q8%2F0?alt=media&token=04b47889-8def-40e9-a217-f5e06aee1167',
                args.file,
                fit: BoxFit.contain,
                // enableLoadState: true,
                cacheRawData: true,
                mode: ExtendedImageMode.editor,
                extendedImageEditorKey: model.editorKey,
                initEditorConfigHandler: (state) {
                  return EditorConfig(
                    maxScale: 8.0,
                    cropRectPadding: EdgeInsets.all(20.0),
                    hitTestSize: 20.0,
                  );
                },
              ),
            ),
          ),
          Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.undo),
                tooltip: 'Undo',
                onPressed: () => context.read(providerCropImageViewModel).reset(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
