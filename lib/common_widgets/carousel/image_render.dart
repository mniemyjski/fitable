import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class ImageRender extends StatelessWidget {
  final String url;
  final Uint8List uint8list;
  final BoxBorder border;
  final BoxShape shape;
  final Icon errorIcon;

  const ImageRender({Key key, this.url, this.uint8list, this.border, this.shape = BoxShape.rectangle, this.errorIcon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (url.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: url,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            shape: shape,
            border: border,
            image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
          ),
        ),
        placeholder: (context, url) => Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => _getIcon(errorIcon),
      );
    }

    if (uint8list != null)
      return ExtendedImage.memory(
        uint8list,
        cacheRawData: true,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.fill,
      );

    return Container();
  }
}

_getIcon(Icon errorIcon) {
  if (errorIcon != null) return errorIcon;

  return Center(
    child: Icon(
      Icons.fastfood,
      size: 110,
      color: Colors.white,
    ),
  );
}
