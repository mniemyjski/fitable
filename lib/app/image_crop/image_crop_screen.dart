import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ImageCropScreen extends StatefulWidget {
  final Uint8List image;

  const ImageCropScreen({Key? key, required this.image}) : super(key: key);

  @override
  State<ImageCropScreen> createState() => _ImageCropScreenState();
}

class _ImageCropScreenState extends State<ImageCropScreen> {
  final _controller = CropController();
  Uint8List? _image;

  @override
  void initState() {
    _image = widget.image;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              _controller.crop;
              context.router.pop(_image);
            },
            icon: FaIcon(FontAwesomeIcons.save),
          )
        ],
      ),
      body: Crop(image: _image!, controller: _controller, onCropped: (image) => _image = image),
    );
  }
}
