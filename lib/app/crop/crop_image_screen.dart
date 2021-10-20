import 'dart:typed_data';

import 'package:extended_image/extended_image.dart';
import 'package:fitable/app/crop/view_models/crop_Image_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CropImageScreenArguments {
  final Uint8List uint8list;
  final int current;

  CropImageScreenArguments({@required this.uint8list, @required this.current});
}

class CropImageScreen extends StatelessWidget {
  _save(BuildContext context) {
    var result = context.read(providerCropImageViewModel).crop();
    if (result != null) Navigator.pop(context, result);
  }

  @override
  Widget build(BuildContext context) {
    final CropImageScreenArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Crop'),
        actions: <Widget>[
          IconButton(
            onPressed: () => _save(context),
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
              child: Consumer(builder: (context, watch, child) {
                final model = watch(providerCropImageViewModel);
                return ExtendedImage.memory(
                  args.uint8list,
                  fit: BoxFit.contain,
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
                );
              }),
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
