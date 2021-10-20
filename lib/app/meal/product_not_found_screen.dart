import 'dart:typed_data';

import 'package:fitable/app/crop/crop_image_screen.dart';
import 'package:fitable/app/meal/widgets/barcode_text.dart';
import 'package:fitable/common_widgets/carousel/models/box_model.dart';
import 'package:fitable/common_widgets/carousel/tile_box.dart';
import 'package:fitable/common_widgets/show_flush_bar.dart';
import 'package:fitable/common_widgets/show_loading_dialog.dart';
import 'package:fitable/routers/route_generator.dart';
import 'package:fitable/services/products_service.dart';
import 'package:fitable/utilities/languages.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductNotFoundArguments {
  final String barcode;

  ProductNotFoundArguments(this.barcode);
}

class ProductNotFound extends StatefulWidget {
  const ProductNotFound({Key key}) : super(key: key);

  @override
  _ProductNotFoundState createState() => _ProductNotFoundState();
}

class _ProductNotFoundState extends State<ProductNotFound> {
  List<Box> boxes = [Box(isEdit: true), Box(isEdit: true), Box(isEdit: true)];

  _add(int current) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 1080,
      maxHeight: 1920,
    );

    Uint8List uint8list = await pickedFile.readAsBytes();

    setState(() {
      boxes[current] = Box(uint8List: uint8list, isEdit: true);
    });
  }

  _crop(int current) async {
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

  _remove(int current) {
    setState(() {
      boxes[current] = Box(isEdit: true);
    });
  }

  sendImages(BuildContext context, String barcode) async {
    if (boxes[0].uint8List == null || boxes[1].uint8List == null) {
      massageFlushBar(context, Languages.images_not_empty());
      return;
    }

    showLoadingDialog(context);

    List<Uint8List> images = [];
    for (Box box in boxes) {
      if (box.uint8List != null) images.add(box.uint8List);
    }

    await context.read(providerProductsService).productImagesToCreate(barcode: barcode, images: images);
    Navigator.pop(context);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final ProductNotFoundArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: FaIcon(Icons.save),
            onPressed: () => sendImages(context, args.barcode),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Center(child: BarcodeText(args.barcode)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 8),
              child: Text('${Languages.image_product()}:'),
            ),
            Container(
              height: 250,
              padding: const EdgeInsets.all(8.0),
              child: TileBox(box: boxes[0], add: () => _add(0), crop: () => _crop(0), remove: () => _remove(0)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 8),
              child: Text('${Languages.image_macro()}:'),
            ),
            Container(
              height: 250,
              padding: const EdgeInsets.all(8.0),
              child: TileBox(box: boxes[1], add: () => _add(1), crop: () => _crop(1), remove: () => _remove(1)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 8),
              child: Text('${Languages.image_support()}:'),
            ),
            Container(
              height: 250,
              padding: const EdgeInsets.all(8.0),
              child: TileBox(box: boxes[2], add: () => _add(2), crop: () => _crop(2), remove: () => _remove(2)),
            ),
          ],
        ),
      ),
    );
  }
}
