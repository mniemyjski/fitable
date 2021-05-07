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

bool _showNetworkImage(String url) {
  if (url.isEmpty) return false;
  if (url.substring(0, 4) != 'http') return false;
  if (kIsWeb && url.substring(0, 4) == 'http') return false;
  return true;
}

imageRender({
  @required String url,
  BoxBorder border,
  BoxShape shape = BoxShape.rectangle,
  Icon errorIcon,
}) {
  if (url == null) return Container();

  if (_showNetworkImage(url)) {
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
