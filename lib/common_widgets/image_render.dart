import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

_getIcon(Icon errorIcon) {
  if (errorIcon != null) return errorIcon;

  return Icon(
    Icons.fastfood,
    size: 110,
    color: Colors.white,
  );
}

imageRender({
  @required String url,
  bool network = true,
  BoxBorder border,
  BoxShape shape = BoxShape.rectangle,
  Icon errorIcon,
}) {
  if (url == null) return Container();

  if (kIsWeb || network) {
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

  return ExtendedImage.file(
    File(url),
    width: double.infinity,
    height: double.infinity,
    fit: BoxFit.fill,
  );
}
