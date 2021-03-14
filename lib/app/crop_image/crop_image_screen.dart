import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:extended_image/extended_image.dart';
import 'package:fitable/app/crop_image/crop_Image_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CropImageScreenArguments {
  final File file;

  CropImageScreenArguments({this.file});
}

class CropImageScreen extends ConsumerWidget {
  // void _cropImage(BuildContext context) async {
  //   final model = context.read(providerCropImageViewModel);
  //
  //   var data = model.editorKey.currentState.rawImageData;
  //   print(data);
  //
  //   // Navigator.pop(context);
  // }

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
              color: Colors.black,
              padding: EdgeInsets.all(8),
              child: ExtendedImage.file(
                args.file,
                fit: BoxFit.contain,
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
              // PopupMenuButton<double>(
              //   icon: Icon(Icons.aspect_ratio),
              //   itemBuilder: (context) => [
              //     PopupMenuItem(
              //       child: Text("Original"),
              //       value: 1000 / 667.0,
              //     ),
              //     PopupMenuDivider(),
              //     PopupMenuItem(
              //       child: Text("16:9"),
              //       value: 16.0 / 9.0,
              //     ),
              //     PopupMenuItem(
              //       child: Text("4:3"),
              //       value: 4.0 / 3.0,
              //     ),
              //     PopupMenuItem(
              //       child: Text("1:1"),
              //       value: 1,
              //     ),
              //     PopupMenuItem(
              //       child: Text("3:4"),
              //       value: 3.0 / 4.0,
              //     ),
              //     PopupMenuItem(
              //       child: Text("9:16"),
              //       value: 9.0 / 16.0,
              //     ),
              //   ],
              //   tooltip: 'Aspect Ratio',
              //   onSelected: (x) => null,
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
